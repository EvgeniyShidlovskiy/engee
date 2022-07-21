using Statistics
using  MATLAB
mutable struct Moving_standart_deviation
    moving_std::Array{Float64} 
    window_lenght::Int 
    method::String
    specify::Bool
    pwLocal::Float64
    pmLocal::Vector{Float64}
    puLocal::Float64
    psLocal::Vector{Float64}
    v_prev::Float64
    lambda::Float64

    function Moving_standart_deviation(method::String,window_length::Int)
        if method != "Sliding window" && method != "Exponential weighthing"
        error("Method должен быть значением Sliding window или Exponential weighthing")
        end
        new(zeros(window_length),window_length,method,true,1,[0.0],1,[0.0],0,0)
    end
    function Moving_standart_deviation(method::String,lambda::Float64)
        if method != "Sliding window" && method != "Exponential weighthing"
            error("Method должен быть значением Sliding window или Exponential weighthing")
        end
        new([0.0],0,method,0,1,[0.0],1,[0.0],0,lambda)
        end
    function Moving_standart_deviation(method::String,specify::Bool)
        if method != "Sliding window" && method != "Exponential weighthing"
        error("Method должен быть значением Sliding window или Exponential weighthing")
        end
        new([0.0],0,method,specify,1,[0.0],1,[0.0],0,0)
    end
end
function step(standart_deviation::Moving_standart_deviation,x)
    if standart_deviation.method == "Sliding window" && standart_deviation.specify == true
        standart_deviation.moving_std[2:end] = standart_deviation.moving_std[1:end-1]
        standart_deviation.moving_std[1]=x
        return std(standart_deviation.moving_std)

     elseif standart_deviation.method == "Exponential weighthing" && standart_deviation.specify == false
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
                     pmLocal_prev = standart_deviation.pmLocal
                     standart_deviation.pmLocal = (1-(1/standart_deviation.pwLocal)) * standart_deviation.pmLocal .+ (1/standart_deviation.pwLocal) * u[index]
                     standart_deviation.puLocal = ((standart_deviation.pwLocal - 1)/standart_deviation.pwLocal)^2 * standart_deviation.puLocal + (1/standart_deviation.pwLocal)^2;    
                     v = standart_deviation.pwLocal * (1 - standart_deviation.puLocal)
                     if v[1] !=0 # skip at first iteration
                            standart_deviation.psLocal = (1 ./ v) .* ( standart_deviation.lambda *  standart_deviation.v_prev .* standart_deviation.psLocal .+ ((standart_deviation.pwLocal-1)/standart_deviation.pwLocal) .* (pmLocal_prev .- u[index,:]).^2 );  
                       y[index,:] = sqrt.(standart_deviation.psLocal)
                     end
                     standart_deviation.v_prev    = v
                     standart_deviation.pwLocal   = standart_deviation.lambda * standart_deviation.pwLocal + 1
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
      
    else standart_deviation.method == "Sliding window" && standart_deviation.specify == false
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
            pmLocal_prev = standart_deviation.pmLocal
            standart_deviation.pmLocal = (1-(1/standart_deviation.pwLocal)) * standart_deviation.pmLocal .+ (1/standart_deviation.pwLocal) * u[index]
            standart_deviation.puLocal = ((standart_deviation.pwLocal - 1)/standart_deviation.pwLocal)^2 * standart_deviation.puLocal + (1/standart_deviation.pwLocal)^2;    
            v = standart_deviation.pwLocal * (1 - standart_deviation.puLocal)
            if v[1] !=0 # skip at first iteration
                   standart_deviation.psLocal = (1 ./ v) .* ( lambda *  standart_deviation.v_prev .* standart_deviation.psLocal .+ ((standart_deviation.pwLocal-1)/standart_deviation.pwLocal) .* (pmLocal_prev .- u[index,:]).^2 );  
              y[index,:] = sqrt.(standart_deviation.psLocal)
            end
            standart_deviation.v_prev    = v
            standart_deviation.pwLocal   = lambda * standart_deviation.pwLocal + 1
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

function step(standart_deviation::Moving_standart_deviation,x,lambda::Float64)
if standart_deviation.method == "Exponential weighthing" && standart_deviation.specify == true
        
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
           pmLocal_prev = standart_deviation.pmLocal
           standart_deviation.pmLocal = (1-(1/standart_deviation.pwLocal)) * standart_deviation.pmLocal .+ (1/standart_deviation.pwLocal) * u[index]
           standart_deviation.puLocal = ((standart_deviation.pwLocal - 1)/standart_deviation.pwLocal)^2 * standart_deviation.puLocal + (1/standart_deviation.pwLocal)^2;    
           v = standart_deviation.pwLocal * (1 - standart_deviation.puLocal)
           if v[1] !=0 # skip at first iteration
                  standart_deviation.psLocal = (1 ./ v) .* ( lambda *  standart_deviation.v_prev .* standart_deviation.psLocal .+ ((standart_deviation.pwLocal-1)/standart_deviation.pwLocal) .* (pmLocal_prev .- u[index,:]).^2 );  
             y[index,:] = sqrt.(standart_deviation.psLocal)
           end
           standart_deviation.v_prev    = v
           standart_deviation.pwLocal   = lambda * standart_deviation.pwLocal + 1
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


moving_std=Moving_standart_deviation("Sliding window",false)
ouput_jl = [step(moving_std,[2]) step(moving_std,[3]) step(moving_std,[4]) step(moving_std,[5])]
mat"input1=[2 3 4 5]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Moving_standart_deviation_without_win_length')"
ouput_mat=mat"output1'"
test = ouput_jl-ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Moving_standart_deviation_without_win_length пройден")
else vec(test)>vec(eps_val)
    error("Тест Moving_standart_deviation_without_win_length не пройден")
end

moving_std=Moving_standart_deviation("Sliding window",4)
ouput_jl = [step(moving_std,2) step(moving_std,3) step(moving_std,4) step(moving_std,5)]
mat"input1=[2 3 4 5]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Moving_standart_deviation_win_length')"
ouput_mat=mat"output1'"
test = ouput_jl-ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Moving_standart_deviation_win_length пройден")
else vec(test)>vec(eps_val)
    error("Тест Moving_standart_deviation_win_length не пройден")
end

moving_std=Moving_standart_deviation("Exponential weighthing",true)
ouput_jl = [step(moving_std,[2],0.9) step(moving_std,[3],0.9) step(moving_std,[4],0.9) step(moving_std,[5],0.9)]
mat"input1=[2 3 4 5]"
mat"forgetting_factor=0.9"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Moving_standart_deviation_Exponential_weighthing_forget_factor')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Moving_standart_deviation_Exponential_weighthing_forget_factor пройден")
else vec(test)>vec(eps_val)
    error("Тест Moving_standart_deviation_Exponential_weighthing_forget_factor не пройден")
end

moving_std=Moving_standart_deviation("Exponential weighthing",0.9)
ouput_jl = [step(moving_std,[2]) step(moving_std,[3]) step(moving_std,[4]) step(moving_std,[5])]
mat"input1=[2 3 4 5]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Moving_standart_deviation_Exponential_weighthing_09')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Moving_standart_deviation_Exponential_weighthing_09 пройден")
else vec(test)>vec(eps_val)
    error("Тест Moving_standart_deviation_Exponential_weighthing_09 не пройден")
end
