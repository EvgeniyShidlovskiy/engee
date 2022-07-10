using Statistics

mutable struct Rms
    mode::String
    function Rms(mode::String)
        if mode != "Entire input" && mode !="Each row" && mode !="Each column" && mode !="Specified dimension"
            error("Mode должен быть значенеим Entire input, Each row, Each column, Specified dimension")
        end
        new(mode)
    end
end
function step(var_rms::Rms,x::Array{Float64},i = 1::Int64)
    k= x.^2.
    if var_rms.mode == "Entire input"
        return y = sqrt(mean(k))
    elseif var_rms.mode == "Each row"
        return y = sqrt.(mean.(eachrow(k)))
    elseif var_rms.mode == "Each column"
        return y = sqrt.(mean.(eachcol(k)))
        else var_rms.mode == "Specified dimension"
        return y = permutedims(hcat(sqrt.(mean(k,dims = i)))) # return Matrix like Simulink
    end
end
var_rms = Rms("Specified dimension")
step(var_rms,[2.0 -3.0 58.0;5.0 30.0 -80;50.0 -1.0 3.0],2)