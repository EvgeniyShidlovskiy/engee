using Statistics

mutable struct Moving_maximum
    moving_max::Array{Float64}
    window_lenght::Int 
    method::String
    specify::Bool
    function Moving_maximum(method::String,window_lenght::Int)
        if method != "Sliding window" 
            error("Method должен быть значением Sliding window")
        end
        new(fill(-Inf,window_lenght),window_lenght,method,true)
     end

     function Moving_maximum(method::String,specify::Bool)
        if method != "Sliding window" 
            error("Method должен быть значением Sliding window")
        end
        new([-Inf],0,method,0)
     end
end
function step(var_mov::Moving_maximum,x)
    if var_mov.method == "Sliding window" && var_mov.specify == true
        var_mov.moving_max[2:end] = var_mov.moving_max[1:end-1]
        var_mov.moving_max[1]=x
        return maximum(var_mov.moving_max)
    else var_mov.method == "Sliding window" && var_mov.specify == false # input like var_mov,[-1,  -2,  3,  4]
        y=fill(Inf,size(x))
        for index=1:size(x,1)
            
            if  var_mov.moving_max[1] < x[index]
                var_mov.moving_max[1] = x[index]
                y[index] = var_mov.moving_max[1]
            elseif var_mov.moving_max[1] >= x[index]
                var_mov.moving_max[1] = var_mov.moving_max[1]
                y[index] = var_mov.moving_max[1]
            end
        end
        return y
    end
end

var_mov=Moving_maximum("Sliding window",4)
step(var_mov,5)
step(var_mov,-2)
step(var_mov,5)
step(var_mov,5)
step(var_mov,5)




