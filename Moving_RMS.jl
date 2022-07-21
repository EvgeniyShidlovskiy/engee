using Statistics
using  MATLAB
mutable struct  Moving_rms
    mov_root_mean_squre::Array{Float64}
    window_lenght::Int 
    pwLocal::Float64
    pmLocal::Float64
    lambda::Float64 
    specify::Bool
    method::String
    length::Int

    function Moving_rms(method::String,window_length::Int)
        if method != "Sliding window" && method != "Exponential weighthing"
            error("Method должен быть значением Sliding window или Exponential weighthing")
        end
        new(zeros(window_length),window_length,0,0,0,true,method,0)
     end

    function Moving_rms(method::String,lambda::Float64)
        if method != "Sliding window" && method != "Exponential weighthing"
            error("Method должен быть значением Sliding window или Exponential weighthing")
        end
        new([0.0],0,1,0,lambda,0,method,0)
    end

    function Moving_rms(method::String,specify::Bool)
        if method != "Sliding window" && method != "Exponential weighthing"
            error("Method должен быть значением Sliding window или Exponential weighthing")
        end
        new([0.0],0,1,0,0,specify,method,0)
    end
end

function step(mrms::Moving_rms,x)
    if mrms.method == "Sliding window" && mrms.specify == true
        mrms.mov_root_mean_squre[2:end]=mrms.mov_root_mean_squre[1:end-1]
        mrms.mov_root_mean_squre[1]=x
        return sqrt(mean(mrms.mov_root_mean_squre.^2.))
    elseif mrms.method == "Exponential weighthing" && mrms.specify == false
        y = zeros(size(x))
        for index = 1:size(x,1)
            mrms.pmLocal = (1-(1 /mrms.pwLocal)) * mrms.pmLocal + (1/mrms.pwLocal) * (x[index])^2
            mrms.pwLocal   = mrms.lambda * mrms.pwLocal + 1
            y[index] = sqrt(mrms.pmLocal)
        end
        return y
    else mrms.method == "Sliding window" && mrms.specify == false
        y = zeros(size(x))
        lambda = 1.0
        for index = 1:size(x,1)
            mrms.pmLocal = (1-(1 /mrms.pwLocal)) * mrms.pmLocal + (1/mrms.pwLocal) * (x[index])^2
            mrms.pwLocal   = lambda * mrms.pwLocal + 1
            y[index] = sqrt(mrms.pmLocal)
        end
        return y
        
    end
end
  
function step(mrms::Moving_rms,x,lambda::Float64)
    if mrms.method == "Exponential weighthing" && mrms.specify == true
        y = zeros(size(x))
        for index = 1:size(x,1)
            mrms.pmLocal = (1-(1 /mrms.pwLocal)) * mrms.pmLocal + (1/mrms.pwLocal) * (x[index])^2
            mrms.pwLocal   = lambda * mrms.pwLocal + 1
            y[index] = sqrt(mrms.pmLocal)
        end
        return y
        end
    end



mrms=Moving_rms("Sliding window",false)
ouput_jl = [step(mrms,[2]) step(mrms,[3]) step(mrms,[4]) step(mrms,[5])]
mat"input1=[2 3 4 5]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Moving_RMS_without_win_length')"
ouput_mat=mat"output1'"
test = ouput_jl-ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Moving_RMS_without_win_length пройден")
else vec(test)>vec(eps_val)
    error("Тест Moving_RMS_without_win_length не пройден")
end

mrms=Moving_rms("Sliding window",4)
ouput_jl = [step(mrms,2) step(mrms,3) step(mrms,4) step(mrms,5)]
mat"input1=[2 3 4 5]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Moving_RMS_win_length')"
ouput_mat=mat"output1'"
test = ouput_jl-ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Moving_RMS_win_length пройден")
else vec(test)>vec(eps_val)
    error("Тест Moving_RMS_win_length не пройден")
end

mrms=Moving_rms("Exponential weighthing",true)
ouput_jl = [step(mrms,[2],0.9) step(mrms,[3],0.9) step(mrms,[4],0.9) step(mrms,[5],0.9)]
mat"input1=[2 3 4 5]"
mat"forgetting_factor=0.9"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Moving_RMS_Exponential_weighthing_forget_factor')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Moving_RMS_Exponential_weighthing_forget_factor пройден")
else vec(test)>vec(eps_val)
    error("Тест Moving_RMS_Exponential_weighthing_forget_factor не пройден")
end

mrms=Moving_rms("Exponential weighthing",0.9)
ouput_jl = [step(mrms,[2]) step(mrms,[3]) step(mrms,[4]) step(mrms,[5])]
mat"input1=[2 3 4 5]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Moving_RMS_Exponential_weighthing_09')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Moving_RMS_Exponential_weighthing_09 пройден")
else vec(test)>vec(eps_val)
    error("Тест Moving_RMS_Exponential_weighthing_09 не пройден")
end

