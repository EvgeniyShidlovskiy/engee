#need add Running mode
mutable struct Minimum
    mode::String
    min_over::String
    function Minimum(mode::String,min_over::String)
        if mode != "Value" && mode != "Index" && mode != "Value and Index"
            error("Mode должен быть значенеим Value, Index, Value and Index")
        end
        if min_over != "Entire input" && min_over != "Each row" && min_over != "Each column" && min_over != "Specified dimension"
            error("Value over должен быть значенеим Entire input, Each row, Each column,Specified dimension")
        end
        new(mode,min_over)
    end
end
function step(var_minimum::Minimum,x::Array{Float64},i=1::Int64)
    if var_minimum.min_over ==  "Entire input" 
           val = findmin(x)
    elseif var_minimum.min_over == "Each row"
        val = findmin.(eachrow(x))
    elseif var_minimum.min_over == "Each column"
        val = findmin.(eachcol(x))
    else var_minimum.min_over == "Specified dimension"
        val = findmin(x,dims = i)
    end
   
    if var_minimum.mode == "Value"
        if var_minimum.min_over ==  "Entire input" || var_minimum.min_over ==  "Specified dimension"
            val[1]
        else
            n=floor(Int,length(collect(Iterators.flatten(val)))/2)
            return reshape(collect(Iterators.flatten(val)),2,n)[1,:]
        end
    elseif var_minimum.mode == "Index"
        if var_minimum.min_over ==  "Entire input" || var_minimum.min_over ==  "Specified dimension"
            val[2]
        else
            n=floor(Int,length(collect(Iterators.flatten(val)))/2)
            return reshape(collect(Iterators.flatten(val)),2,n)[2,:]
    end
    else var_minimum.mode == "Value and Index"
        return val
    end
end
var_minimum=Minimum("Value and Index","Each column")
step(var_minimum,[2.0 -3.0 58.0])


