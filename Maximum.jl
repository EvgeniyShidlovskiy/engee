#need add Running mode
mutable struct Maximum
    mode::String
    max_over::String
    function Maximum(mode::String,max_over::String)
        if mode != "Value" && mode != "Index" && mode != "Value and Index"
            error("Mode должен быть значенеим Value, Index, Value and Index")
        end
        if max_over != "Entire input" && max_over != "Each row" && max_over != "Each column" && max_over != "Specified dimension"
            error("Value over должен быть значенеим Entire input, Each row, Each column,Specified dimension")
        end
        new(mode,max_over)
    end
end
function step(var_maximum::Maximum,x::Array{Float64},i=1::Int64)
    if var_maximum.max_over ==  "Entire input" 
           val = findmax(x)
    elseif var_maximum.max_over == "Each row"
        val = findmax.(eachrow(x))
    elseif var_maximum.max_over == "Each column"
        val = findmax.(eachcol(x))
    else var_maximum.max_over == "Specified dimension"
        val = findmax(x,dims = i)
    end
   
    if var_maximum.mode == "Value"
        if var_maximum.max_over ==  "Entire input" || var_maximum.max_over ==  "Specified dimension"
            val[1]
        else
            n=floor(Int,length(collect(Iterators.flatten(val)))/2)
            return reshape(collect(Iterators.flatten(val)),2,n)[1,:]
        end
    elseif var_maximum.mode == "Index"
        if var_maximum.max_over ==  "Entire input" || var_maximum.max_over ==  "Specified dimension"
            val[2]
        else
            n=floor(Int,length(collect(Iterators.flatten(val)))/2)
            return reshape(collect(Iterators.flatten(val)),2,n)[2,:]
    end
    else var_maximum.mode == "Value and Index"
        return val
    end
end
var_maximum=Maximum("Value","Entire input")
step(var_maximum,[2.0 -3.0 58.0;5.0 30.0 -80;50.0 -1.0 3.0])

