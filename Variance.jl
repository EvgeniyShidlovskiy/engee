using Statistics

mutable struct Variance
    mode::String
    function Variance(mode::String)
        if mode != "Entire input" && mode !="Each row" && mode !="Each column" && mode !="Specified dimension"
            error("Mode должен быть значенеим Entire input, Each row, Each column, Specified dimension")
        end
        new(mode)
    end
end
function step(var_var::Variance,x::Array{Float64},i = 1::Int64)
    if var_var.mode == "Entire input"
        return y = var(x)
    elseif var_var.mode == "Each row"
        return y = var.(eachrow(x))
    elseif var_var.mode == "Each column"
        return y = var.(eachcol(x))
        else var_var.mode == "Specified dimension"
        return y = permutedims(hcat(var(x,dims = i))) # return Matrix like Simulink
    end
end
var_var = Variance("Each row")
step(var_var,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0])