using Statistics
using  MATLAB
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
        return y = sqrt(mean(x.^2.))
    elseif var_rms.mode == "Each row"
        return y = permutedims(hcat(sqrt.(mean.(eachrow(k)))))
    elseif var_rms.mode == "Each column"
        return y = sqrt.(mean.(eachcol(k)))
        else var_rms.mode == "Specified dimension"
        return y = permutedims(hcat(sqrt.(mean(k,dims = i)))) # return Matrix like Simulink
    end
end
var_rms = Rms("Each column")
ouput_rms_jl = step(var_rms,[2.0 -3.0 58.0;5.0 30.0 -80;50.0 -1.0 3.0])
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\RMS_Each_column')"
ouput_rms_mat=mat"output1'"
test = ouput_rms_jl - ouput_rms_mat
eps_val = fill(3*eps(),length(test))
if test<eps_val
    println("Тест RMS_Each_column пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест RMS_Each_column не пройден")
end

var_rms = Rms("Each row")
ouput_std_each_row_jl=step(var_rms,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0])
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\RMS_Each_row')"
ouput_std_each_row_mat=mat"output1'"
test = ouput_std_each_row_jl - ouput_std_each_row_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест RMS_Each_row пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест RMS_Each_row не пройден")
end

var_rms = Rms("Entire input")
ouput_std_each_row_jl=step(var_rms,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0])
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\RMS_Entire_inp')"
ouput_std_each_row_mat=mat"output1'"
test = ouput_std_each_row_jl - ouput_std_each_row_mat
eps_val = 3*eps()
if test<eps_val
    println("Тест RMS_Entire_input пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест RMS_Entire_input не пройден")
end

var_rms = Rms("Specified dimension")
ouput_var_spec_dem_jl=step(var_rms,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0],1)
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\RMS_Specified_dimension_1')"
ouput_var_spec_dem_mat=mat"output1'"
test = ouput_var_spec_dem_jl - ouput_var_spec_dem_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест RMS_Specified_dimension_1 пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест RMS_Specified_dimension_1 не пройден")
end
