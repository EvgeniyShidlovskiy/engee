using Statistics

mutable struct Standart_deviation
    mode::String
    function Standart_deviation(mode::String)
        if mode != "Entire input" && mode !="Each row" && mode !="Each column" && mode !="Specified dimension"
            error("Mode должен быть значенеим Entire input, Each row, Each column, Specified dimension")
        end
        new(mode)
    end
end
function step(var_stan_dev::Standart_deviation,x::Array{Float64},i = 1::Int64)
    if var_stan_dev.mode == "Entire input"
        return y = std(x)
    elseif var_stan_dev.mode == "Each row"
        return y = std.(eachrow(x))
    elseif var_stan_dev.mode == "Each column"
        return y = std.(eachcol(x))
        else var_stan_dev.mode == "Specified dimension"
        return y = permutedims(hcat(std(x,dims = i))) # return Matrix like Simulink
    end
end
var_stan_dev = Standart_deviation("Specified dimension")
step(var_stan_dev,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0],1)