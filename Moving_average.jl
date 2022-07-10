using Statistics

mutable struct Moving_average
    moving_avr::Array{Float64}
    window_length::Int 
    pwLocal::Float64
    pmLocal::Float64
    lambda::Float64 
    specify::Bool
    method::String
    length::Int
    
    function Moving_average(method::String,window_length::Int)
        if method != "Sliding window" && method != "Exponential weighthing"
            error("Method должен быть значением Sliding window или Exponential weighthing")
        end
        new(zeros(window_length),window_length,0,0,0,true,method,0)
     end

    function Moving_average(method::String,lambda::Float64)
        if method != "Sliding window" && method != "Exponential weighthing"
            error("Method должен быть значением Sliding window или Exponential weighthing")
        end
        new([0.0],0,1,0,lambda,0,method,0)
        end

    function Moving_average(method::String,specify::Bool)
        if method != "Sliding window" && method != "Exponential weighthing"
            error("Method должен быть значением Sliding window или Exponential weighthing")
        end
        new([0.0],0,1,0,0,specify,method,0)
    end
end


function step(var_mov::Moving_average,x)
    if var_mov.method == "Sliding window" && var_mov.specify == true
        var_mov.moving_avr[2:end] = var_mov.moving_avr[1:end-1]
        var_mov.moving_avr[1]=x
        return mean(var_mov.moving_avr)
    elseif var_mov.method == "Exponential weighthing" && var_mov.specify == false
        y = zeros(size(x))
        for index = 1:size(x,1)
            var_mov.pmLocal = (1-(1 /var_mov.pwLocal)) * var_mov.pmLocal + (1/var_mov.pwLocal) * x[index]
            var_mov.pwLocal   = var_mov.lambda * var_mov.pwLocal + 1
            y[index] = var_mov.pmLocal
        end
        return y
    else var_mov.method == "Sliding window" && var_mov.specify == false
        y=zeros(size(x))
        for index=1:size(x,2) 
            var_mov.moving_avr[1]=(var_mov.moving_avr[1] + x[index]) 
            var_mov.length=var_mov.length+1
            y[index]=var_mov.moving_avr[1]/var_mov.length
        end
        return y  
    end
end
  
function step(var_mov::Moving_average,u,lambda::Float64)
    if var_mov.method == "Exponential weighthing" && var_mov.specify == true
        y = zeros(size(u))
        for index = 1:size(u,1)
            var_mov.pmLocal = (1-(1 /var_mov.pwLocal)) * var_mov.pmLocal + (1/var_mov.pwLocal) * u[index]
            var_mov.pwLocal = lambda * var_mov.pwLocal + 1
            y[index] = var_mov.pmLocal
        end
        return y
    end
end

var_mov=Moving_average("Sliding window",false)
step(var_mov,[1 2 3 4])


























