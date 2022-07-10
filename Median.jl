using Statistics

mutable struct Median
    mode::String
    function Median(mode::String)
        if mode != "Entire input" && mode !="Each row" && mode !="Each column" && mode !="Specified dimension"
            error("Mode должен быть значенеим Entire input, Each row, Each column, Specified dimension")
        end
        new(mode)
    end
end
function step(var_median::Median,x::Array{Float64},i = 1::Int64)
    if var_median.mode == "Entire input"
        return y = median(x)
    elseif var_median.mode == "Each row"
        return y = median.(eachrow(x))
    elseif var_median.mode == "Each column"
        return y = median.(eachcol(x))
        else var_median.mode == "Specified dimension"
        return y = median(x,dims = i)
    end
end
var_median = Median("Entire input")
step(var_median,[2.0 -3.0 58.0;5.0 30.0 -80;50.0 -1.0 3.0])