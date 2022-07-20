using Statistics
using MATLAB
mutable struct Standart_deviation
    mode::String
    function Standart_deviation(mode::String)
        if mode != "Entire input" && mode !="Each row" && mode !="Each column" && mode !="Specified dimension"
            error("Mode должен быть значенеим Entire input, Each row, Each column, Specified dimension")
        end
        new(mode)
    end
end
function step(var_stan_dev::Standart_deviation,x,i = 1::Int64)
    if var_stan_dev.mode == "Entire input"
        return y = std(x)
    elseif var_stan_dev.mode == "Each row"
        return y = permutedims(hcat(std.(eachrow(x))))
    elseif var_stan_dev.mode == "Each column"
        return y = std.(eachcol(x))
        else var_stan_dev.mode == "Specified dimension"
        return y = permutedims(hcat(std(x,dims = i))) 
    end
end
#tests


var_stan_dev = Standart_deviation("Each column")
ouput_std_each_col_jl=step(var_stan_dev,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0])
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Standart_deviation_Each_column')"
ouput_std_each_col_mat=mat"output1'"
test = ouput_std_each_col_jl - ouput_std_each_col_mat
eps_val = fill(3*eps(),length(test))
if test<eps_val
    println("Тест Standart_deviation_Each_column пройден")
else test>eps_val
    error("Тест Standart_deviation_Each_column не пройден")
end

var_stan_dev = Standart_deviation("Each row")
ouput_std_each_row_jl=step(var_stan_dev,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0])
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Standart_deviation_Each_row')"
ouput_std_each_row_mat=mat"output1'"
test = ouput_std_each_row_jl - ouput_std_each_row_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Standart_deviation_Each_row пройден")
else test>eps_val
    error("Тест Standart_deviation_Each_row не пройден")
end

var_var = Standart_deviation("Entire input")
ouput_std_ent_inp_jl=step(var_var,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0])
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Standart_deviation_Entire_input')"
ouput_std_ent_inp_mat=mat"output1'"
test = ouput_std_ent_inp_jl - ouput_std_ent_inp_mat
eps_val = 100000*eps()
if test<eps_val
    println("Тест Standart_deviation_Entire_input пройден")
else test>eps_val
    error("Тест Standart_deviation_Entire_input не пройден")
end

var_stan_dev = Standart_deviation("Specified dimension")
ouput_std_spec_dem_jl=step(var_stan_dev,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0],1)
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Standart_deviation_Specified_dimension_1')"
ouput_std_spec_dem_mat=mat"output1'"
test = ouput_std_spec_dem_jl - ouput_std_spec_dem_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Standart_deviation_Specified_dimension_1 пройден")
else test>eps_val
    error("Тест Standart_deviation_Specified_dimension_1 не пройден")
end