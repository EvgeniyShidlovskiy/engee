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
function step(var_mean::Mean,x,i = 1::Int64)
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

var_mean = Mean("Each column")
ouput_jl = step(var_mean,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Mean_Each_colum')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if test<eps_val
    println("Тест Mean_Each_colum пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Mean_Each_colum не пройден")
end

var_mean = Mean("Each row")
ouput_jl=step(var_mean,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Mean_Each_rows')"
ouput_mat=mat"output1'"
test = ouput_jl[1] - ouput_mat
eps_val = 3*eps()
if test<eps_val
    println("Тест Mean_Each_rows пройден")
    test_num = test_num + 1;
else test>veceps_val
    error("Тест Mean_Each_rows не пройден")
end

var_mean = Mean("Entire input")
ouput_std_each_row_jl=step(var_mean,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0])
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Mean_Entire_input')"
ouput_std_each_row_mat=mat"output1'"
test = ouput_std_each_row_jl - ouput_std_each_row_mat
eps_val = 3*eps()
if test<eps_val
    println("Тест Mean_Entire_input пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест Mean_Entire_input не пройден")
end

var_mean = Mean("Specified dimension")
ouput_var_spec_dem_jl=step(var_mean,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0],1)
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Mean_Specified_dimension_1')"
ouput_var_spec_dem_mat=mat"output1'"
test = vec(ouput_var_spec_dem_jl) - ouput_var_spec_dem_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Mean_Specified_dimension_1 пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Mean_Specified_dimension_1 не пройден")
end