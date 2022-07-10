using Statistics

mutable struct Moving_minimum
    moving_min::Array{Float64}
    window_lenght::Int 
    method::String
    specify::Bool
    function Moving_minimum(method::String,window_lenght::Int)
        if method != "Sliding window" 
            error("Method должен быть значением Sliding window")
        end
        new(fill(Inf,window_lenght),window_lenght,method,true)
     end

     function Moving_minimum(method::String,specify::Bool)
        if method != "Sliding window" 
            error("Method должен быть значением Sliding window")
        end
        new([Inf],0,method,0)
     end
end
function step(var_mov::Moving_minimum,x)
    if var_mov.method == "Sliding window" && var_mov.specify == true
        var_mov.moving_min[2:end] = var_mov.moving_min[1:end-1]
        var_mov.moving_min[1]=x
        return minimum(var_mov.moving_min)
    else var_mov.method == "Sliding window" && var_mov.specify == false # input like var_mov,[-1,  -2,  3,  4]
        y=fill(Inf,size(x))
        for index=1:size(x,1)
            
            if  var_mov.moving_min[1] > x[index]
                var_mov.moving_min[1] = x[index]
                y[index] = var_mov.moving_min[1]
            elseif var_mov.moving_min[1] <= x[index]
                var_mov.moving_min[1] = var_mov.moving_min[1]
                y[index] = var_mov.moving_min[1]
            end
        end
        return y
    end
end

var_mov=Moving_minimum("Sliding window",4)
step(var_mov,9)
step(var_mov,10)
step(var_mov,-8)
step(var_mov,9)
step(var_mov,10)
step(var_mov,9)
step(var_mov,10)

