using Statistics
using MATLAB
mutable struct Moving_average
    moving_avr::Array{Float64}
    window_length::Int 
    pwLocal::Float64
    pmLocal::Float64
    lambda::Float64 
    specify::Bool
    method::String
    length::Int
    
    function Moving_average(method::String,window_length::Int)
        if method != "Sliding window" && method != "Exponential weighthing"
            error("Method должен быть значением Sliding window или Exponential weighthing")
        end
        new(zeros(window_length),window_length,0,0,0,true,method,0)
     end

    function Moving_average(method::String,lambda::Float64)
        if method != "Sliding window" && method != "Exponential weighthing"
            error("Method должен быть значением Sliding window или Exponential weighthing")
        end
        new([0.0],0,1,0,lambda,0,method,0)
        end

    function Moving_average(method::String,specify::Bool)
        if method != "Sliding window" && method != "Exponential weighthing"
            error("Method должен быть значением Sliding window или Exponential weighthing")
        end
        new([0.0],0,1,0,0,specify,method,0)
    end
end


function step(var_mov::Moving_average,x)
    if var_mov.method == "Sliding window" && var_mov.specify == true
        var_mov.moving_avr[2:end] = var_mov.moving_avr[1:end-1]
        var_mov.moving_avr[1]=x
        return mean(var_mov.moving_avr)
    elseif var_mov.method == "Exponential weighthing" && var_mov.specify == false
        y = zeros(size(x))
        for index = 1:size(x,1)
            var_mov.pmLocal = (1-(1 /var_mov.pwLocal)) * var_mov.pmLocal + (1/var_mov.pwLocal) * x[index]
            var_mov.pwLocal   = var_mov.lambda * var_mov.pwLocal + 1
            y[index] = var_mov.pmLocal
        end
        return y
    else var_mov.method == "Sliding window" && var_mov.specify == false
        y=zeros(size(x))
        for index=1:size(x,2) 
            var_mov.moving_avr[1]=(var_mov.moving_avr[1] + x[index]) 
            var_mov.length=var_mov.length+1
            y[index]=var_mov.moving_avr[1]/var_mov.length
        end
        return y  
    end
end
  
function step(var_mov::Moving_average,u,lambda::Float64)
    if var_mov.method == "Exponential weighthing" && var_mov.specify == true
        y = zeros(size(u))
        for index = 1:size(u,1)
            var_mov.pmLocal = (1-(1 /var_mov.pwLocal)) * var_mov.pmLocal + (1/var_mov.pwLocal) * u[index]
            var_mov.pwLocal = lambda * var_mov.pwLocal + 1
            y[index] = var_mov.pmLocal
        end
        return y
    end
end



var_mov=Moving_average("Sliding window",false)
ouput_jl = [step(var_mov,[2]) step(var_mov,[3]) step(var_mov,[4]) step(var_mov,[5])]
mat"input1=[2 3 4 5]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Moving_Average_without_win_length')"
ouput_mat=mat"output1'"
test = ouput_jl-ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Moving_Average_without_win_length пройден")
else vec(test)>vec(eps_val)
    error("Тест Moving_Average_without_win_length не пройден")
end

var_mov=Moving_average("Sliding window",4)
ouput_jl = [step(var_mov,2) step(var_mov,3) step(var_mov,4) step(var_mov,5)]
mat"input1=[2 3 4 5]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Moving_Average_win_length')"
ouput_mat=mat"output1'"
test = ouput_jl-ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Moving_Average_win_length пройден")
else vec(test)>vec(eps_val)
    error("Тест Moving_Average_win_length не пройден")
end

var_mov=Moving_average("Exponential weighthing",true)
ouput_jl = [step(var_mov,[2],0.9) step(var_mov,[3],0.9) step(var_mov,[4],0.9) step(var_mov,[5],0.9)]
mat"input1=[2 3 4 5]"
mat"forgetting_factor=0.9"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Moving_Average_Exponential_weighthing_forget_factor')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Moving_Average_Exponential_weighthing_forget_factor пройден")
else vec(test)>vec(eps_val)
    error("Тест Moving_Average_Exponential_weighthing_forget_factor не пройден")
end

var_mov=Moving_average("Exponential weighthing",0.9)
ouput_jl = [step(var_mov,[2]) step(var_mov,[3]) step(var_mov,[4]) step(var_mov,[5])]
mat"input1=[2 3 4 5]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Moving_Average_Exponential_weighthing_09')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Moving_Average_Exponential_weighthing_09 пройден")
else vec(test)>vec(eps_val)
    error("Тест Moving_Average_Exponential_weighthing_09 не пройден")
end


























