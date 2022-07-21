using Statistics
mutable struct Median_filter
    median_fir::Array{Float64}
    windows_lenght::Int
    function Median_filter(windows_lenght::Int)
        new(zeros(windows_lenght),windows_lenght)
    end
end
function step(var_median_fir::Median_filter,x)
    var_median_fir.median_fir[2:end]=var_median_fir.median_fir[1:end-1]
    var_median_fir.median_fir[1]=x
    return median(var_median_fir.median_fir)
end

var_median_fir=Median_filter(4)
ouput_jl = [step(var_median_fir,2) step(var_median_fir,3) step(var_median_fir,4) step(var_median_fir,5)]
mat"input1=[2 3 4 5]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Median_filter')"
ouput_mat=mat"output1'"
test = ouput_jl-ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Median_filter_win_length пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Median_filter_win_length не пройден")
end