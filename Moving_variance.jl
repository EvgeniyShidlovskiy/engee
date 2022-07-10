using Statistics

mutable struct Moving_variance
       moving_var::Array{Float64}
       window_length::Int
       method::String
       specify::Bool
       pwLocal::Float64
       pmLocal::Vector{Float64}
       puLocal::Float64
       psLocal::Vector{Float64}
       v_prev::Float64
       lambda::Float64

       

       function Moving_variance(method::String,window_length::Int)
              if method != "Sliding window" && method != "Exponential weighthing"
                error("Method должен быть значением Sliding window или Exponential weighthing")
              end
              new(zeros(window_length),window_length,method,true,1,[0.0],1,[0.0],0,0)
       end
       function Moving_variance(method::String,lambda::Float64)
              if method != "Sliding window" && method != "Exponential weighthing"
                  error("Method должен быть значением Sliding window или Exponential weighthing")
              end
              new([0.0],0,method,0,1,[0.0],1,[0.0],0,lambda)
              end
       function Moving_variance(method::String,specify::Bool)
              if method != "Sliding window" && method != "Exponential weighthing"
                error("Method должен быть значением Sliding window или Exponential weighthing")
              end
              new([0.0],0,method,specify,1,[0.0],1,[0.0],0,0)
       end
end

function step(var_var::Moving_variance, x)
       if var_var.method == "Sliding window" && var_var.specify == true
              var_var.moving_var[2:end]=var_var.moving_var[1:end-1]
              var_var.moving_var[1]=x
              return var(var_var.moving_var)

       elseif var_var.method == "Exponential weighthing" && var_var.specify == false
                 if isreal(x)
                     y = zeros(size(x))
                     u = x
                 else
                     # Split real & imaginary parts to separate channels
                     y = zeros(size(x,1),2*size(x,2),class(x))
                     u = zeros(size(x,1),2*size(x,2),class(x))
                     for index = 1:size(x,2)
                         u[:,(index-1) *2+1] = real(x[:,index])
                         u[:,(index-1) *2+2] = imag(x[:,index])
                     end
                 end
     
                 for index = 1:size(u,1)
                     pmLocal_prev = var_var.pmLocal
                     var_var.pmLocal = (1-(1/var_var.pwLocal)) * var_var.pmLocal .+ (1/var_var.pwLocal) * u[index]
                     var_var.puLocal = ((var_var.pwLocal - 1)/var_var.pwLocal)^2 * var_var.puLocal + (1/var_var.pwLocal)^2;    
                     v = var_var.pwLocal * (1 - var_var.puLocal)
                     if v[1] !=0 # skip at first iteration
                            var_var.psLocal = (1 ./ v) .* ( var_var.lambda *  var_var.v_prev .* var_var.psLocal .+ ((var_var.pwLocal-1)/var_var.pwLocal) .* (pmLocal_prev .- u[index,:]).^2 );  
                       y[index,:] = var_var.psLocal
                     end
                     var_var.v_prev    = v
                     var_var.pwLocal   = var_var.lambda * var_var.pwLocal + 1
                 end
                 
                 if isreal(x)
                     z = y
                 else
                     # sum variance of real & imaginary parts
                     z = zeros(size(x),class(x))
                     for index = 1:size(x,2)
                         z[:,index] = y[:,(index-1) *2+1] + y[:,(index-1) *2+2]
                     end
                 end     
      
    else var_var.method == "Sliding window" && var_var.specify == false
        lambda = 1.0
        if isreal(x)
            y = zeros(size(x))
            u = x
        else
            # Split real & imaginary parts to separate channels
            y = zeros(size(x,1),2*size(x,2),class(x))
            u = zeros(size(x,1),2*size(x,2),class(x))
            for index = 1:size(x,2)
                u[:,(index-1) *2+1] = real(x[:,index])
                u[:,(index-1) *2+2] = imag(x[:,index])
            end
        end
 
        for index = 1:size(u,1)
            pmLocal_prev = var_var.pmLocal
            var_var.pmLocal = (1-(1/var_var.pwLocal)) * var_var.pmLocal .+ (1/var_var.pwLocal) * u[index]
            var_var.puLocal = ((var_var.pwLocal - 1)/var_var.pwLocal)^2 * var_var.puLocal + (1/var_var.pwLocal)^2;    
            v = var_var.pwLocal * (1 - var_var.puLocal)
            if v[1] !=0 # skip at first iteration
                   var_var.psLocal = (1 ./ v) .* ( lambda *  var_var.v_prev .* var_var.psLocal .+ ((var_var.pwLocal-1)/var_var.pwLocal) .* (pmLocal_prev .- u[index,:]).^2 );  
              y[index,:] = var_var.psLocal
            end
            var_var.v_prev    = v
            var_var.pwLocal   = lambda * var_var.pwLocal + 1
        end
        
        if isreal(x)
            z = y
        else
            # sum variance of real & imaginary parts
            z = zeros(size(x),class(x))
            for index = 1:size(x,2)
                z[:,index] = y[:,(index-1) *2+1] + y[:,(index-1) *2+2]
            end
        end     
    end
end

function step(var_var::Moving_variance,x,lambda::Float64)
if var_var.method == "Exponential weighthing" && var_var.specify == true
        
    if isreal(x)
           y = zeros(size(x))
           u = x
       else
           # Split real & imaginary parts to separate channels
           y = zeros(size(x,1),2*size(x,2),class(x))
           u = zeros(size(x,1),2*size(x,2),class(x))
           for index = 1:size(x,2)
               u[:,(index-1) *2+1] = real(x[:,index])
               u[:,(index-1) *2+2] = imag(x[:,index])
           end
       end

       for index = 1:size(u,1)
           pmLocal_prev = var_var.pmLocal
           var_var.pmLocal = (1-(1/var_var.pwLocal)) * var_var.pmLocal .+ (1/var_var.pwLocal) * u[index]
           var_var.puLocal = ((var_var.pwLocal - 1)/var_var.pwLocal)^2 * var_var.puLocal + (1/var_var.pwLocal)^2;    
           v = var_var.pwLocal * (1 - var_var.puLocal)
           if v[1] !=0 # skip at first iteration
                  var_var.psLocal = (1 ./ v) .* ( lambda *  var_var.v_prev .* var_var.psLocal .+ ((var_var.pwLocal-1)/var_var.pwLocal) .* (pmLocal_prev .- u[index,:]).^2 );  
             y[index,:] = var_var.psLocal
           end
           var_var.v_prev    = v
           var_var.pwLocal   = lambda * var_var.pwLocal + 1
       end
       
       if isreal(x)
           z = y
       else
           # sum variance of real & imaginary parts
           z = zeros(size(x),class(x))
           for index = 1:size(x,2)
               z[:,index] = y[:,(index-1) *2+1] + y[:,(index-1) *2+2]
           end
       end     
    end
end
moving_var=Moving_variance("Sliding window",4)
step(moving_var,2)
step(moving_var,3)
step(moving_var,4)



