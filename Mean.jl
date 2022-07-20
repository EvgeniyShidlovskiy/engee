using Statistics

mutable struct Mean
    mode::String
    function Mean(mode::String)
        if mode != "Entire input" && mode !="Each row" && mode !="Each column" && mode !="Specified dimension"
            error("Mode должен быть значенеим Entire input, Each row, Each column, Specified dimension")
        end
        new(mode)
    end
end
function step(var_mean::Mean,x::Array{Float64},i = 1::Int64)
    if var_mean.mode == "Entire input"
        return y = mean(x)
    elseif var_mean.mode == "Each row"
        return y = mean.(eachrow(x))
    elseif var_mean.mode == "Each column"
        return y = mean.(eachcol(x))
        else var_mean.mode == "Specified dimension"
        return y = permutedims(hcat(mean(x,dims = i)))
    end
end
var_mean = Mean("Entire input")
step(var_mean,[2.0 -3.0 58.0;5.0 30.0 -80;50.0 -1.0 3.0],1)