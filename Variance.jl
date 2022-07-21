using Statistics
using MATLAB
mutable struct Variance
    mode::String
    function Variance(mode::String)
        if mode != "Entire input" && mode !="Each row" && mode !="Each column" && mode !="Specified dimension"
            error("Mode должен быть значенеим Entire input, Each row, Each column, Specified dimension")
        end
        new(mode)
    end
end
function step(var_var::Variance,x,i = 1::Int64)
    if var_var.mode == "Entire input"
        return y =  var(x)
    elseif var_var.mode == "Each row"
        return y = permutedims(hcat(var.(eachrow(x))))
    elseif var_var.mode == "Each column"
        return y = var.(eachcol(x))
        else var_var.mode == "Specified dimension"
        return y = permutedims(hcat(var(x,dims = i))) # return Matrix like Simulink
    end
end
var_var = Variance("Each column")
ouput_var_each_col_jl=step(var_var,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0])
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\variance_Each_column')"
ouput_var_each_col_mat=mat"output1'"
test = ouput_var_each_col_jl - ouput_var_each_col_mat
eps_val = fill(3*eps(),length(test))
if test<eps_val
    println("Тест variance_Each_column пройден")
else test>eps_val
    error("Тест variance_Each_column не пройден")
end

var_var = Variance("Each row")
ouput_var_each_row_jl=step(var_var,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0])
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\variance_Each_row')"
ouput_var_each_row_mat=mat"output1'"
test = ouput_var_each_row_jl - ouput_var_each_row_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест variance_Each_row пройден")
else test>eps_val
    error("Тест variance_Each_row не пройден")
end

var_var = Variance("Entire input")
ouput_var_ent_inp_jl=step(var_var,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0])
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\variance_Entire_input')"
ouput_var_ent_inp_mat=mat"output1'"
test = ouput_var_ent_inp_jl - ouput_var_ent_inp_mat
eps_val = 100000*eps() 
if test<eps_val
    println("Тест variance_Entire_input пройден")
else test>eps_val
    error("Тест variance_Entire_input не пройден")
end

var_var = Variance("Specified dimension")
ouput_var_spec_dem_jl=step(var_var,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0],1)
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\variance_Specified_dimension_1')"
ouput_var_spec_dem_mat=mat"output1'"
test = ouput_var_spec_dem_jl - ouput_var_spec_dem_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест variance_Specified_dimension_1 пройден")
else test>eps_val
    error("Тест variance_Specified_dimension_1 не пройден")
end
