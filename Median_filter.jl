using Statistics
mutable struct Median_filter
    median_fir::Array{Float64}
    windows_lenght::Int
    function Median_filter(windows_lenght::Int)
        new(zeros(windows_lenght),windows_lenght)
    end
end
function step(var_median_fir::Median_filter,x::Float64)
    var_median_fir.median_fir[2:end]=var_median_fir.median_fir[1:end-1]
    var_median_fir.median_fir[1]=x
    return median(var_median_fir.median_fir)
end
median_fir=Median_filter(4)
step(median_fir,-1.0)
step(median_fir,-2.0)
step(median_fir,3.0)
step(median_fir,2.0)
step(median_fir,5.0)
step(median_fir,2.0)