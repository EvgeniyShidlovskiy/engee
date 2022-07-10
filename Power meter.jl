using Statistics

mutable struct Moving_average
    moving_avr::Array{Float64}
    window_length::Int 
    function Moving_average(window_length::Int)
        
            new(zeros(window_length),window_length)
    end
end

function step(var_mov::Moving_average,x)
    var_mov.moving_avr[2:end] = var_mov.moving_avr[1:end-1]
    var_mov.moving_avr[1]=x
    return 10log10(mean(var_mov.moving_avr.^2))+30
end
var_mov=Moving_average(4)
step(var_mov,1)
