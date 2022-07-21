using Statistics
using  MATLAB
mutable struct Power_meter
    mesurement::String
    moving_pow::Array{Float64}
    window_length::Int
    reference::Int 
    power_units::String

    function Power_meter(mesurement::String,window_length::Int,reference::Int,power_units::String)
     if   mesurement != "Average power"  && mesurement != "Peak power" && mesurement != "Peak-to_average Ratio" && mesurement != "All" 
        error("Mesurement должен быть значением Average power или Peak power или Peak-to_average Ratio или All")
     end
     if   power_units != "dBm"  && power_units != "dBW" && power_units != "Watts"
        error("Power units должен быть значением dBm или dBW или Watts")
     end
     new(mesurement,zeros(window_length),window_length,reference,power_units)
    end
end

function step(var_pow::Power_meter,x)
    if var_pow.mesurement == "Average power" && var_pow.power_units == "dBm"
    var_pow.moving_pow[2:end] = var_pow.moving_pow[1:end-1]
    var_pow.moving_pow[1]=x
    return 10log10(mean(var_pow.moving_pow.^2)/var_pow.reference)+30
    elseif  var_pow.mesurement == "Average power" && var_pow.power_units == "dBW"
        var_pow.moving_pow[2:end] = var_pow.moving_pow[1:end-1]
        var_pow.moving_pow[1]=x
    return  10log10(mean(var_pow.moving_pow.^2)/var_pow.reference)
    elseif var_pow.mesurement == "Average power" && var_pow.power_units == "Watts"
        var_pow.moving_pow[2:end] = var_pow.moving_pow[1:end-1]
        var_pow.moving_pow[1]=x
    return  mean(var_pow.moving_pow.^2)/var_pow.reference
    elseif var_pow.mesurement == "Peak power" && var_pow.power_units == "dBm"
        var_pow.moving_pow[2:end] = var_pow.moving_pow[1:end-1]
        var_pow.moving_pow[1]=x
    return 10log10(maximum(var_pow.moving_pow.^2)/var_pow.reference)+30
    elseif var_pow.mesurement == "Peak power" && var_pow.power_units == "dBW"
        var_pow.moving_pow[2:end] = var_pow.moving_pow[1:end-1]
        var_pow.moving_pow[1]=x
    return 10log10(maximum(var_pow.moving_pow.^2)/var_pow.reference)
    elseif var_pow.mesurement == "Peak power" && var_pow.power_units == "Watts"
        var_pow.moving_pow[2:end] = var_pow.moving_pow[1:end-1]
        var_pow.moving_pow[1]=x
    return  maximum(var_pow.moving_pow.^2)/var_pow.reference
    elseif var_pow.mesurement == "Peak-to_average Ratio" && var_pow.power_units == "dBm"
        var_pow.moving_pow[2:end] = var_pow.moving_pow[1:end-1]
        var_pow.moving_pow[1]=x
    return 10log10(maximum(var_pow.moving_pow.^2)/mean(var_pow.moving_pow.^2))
    elseif var_pow.mesurement == "Peak-to_average Ratio" && var_pow.power_units == "dBW" # why this mesurement copy privious method
        var_pow.moving_pow[2:end] = var_pow.moving_pow[1:end-1]
        var_pow.moving_pow[1]=x
    return 10log10(maximum(var_pow.moving_pow.^2)/mean(var_pow.moving_pow.^2))
    elseif var_pow.mesurement == "Peak-to_average Ratio" && var_pow.power_units == "Watts"
        var_pow.moving_pow[2:end] = var_pow.moving_pow[1:end-1]
        var_pow.moving_pow[1]=x
    return (maximum(var_pow.moving_pow.^2)/mean(var_pow.moving_pow.^2))
    elseif var_pow.mesurement == "All" && var_pow.power_units == "dBm"
        var_pow.moving_pow[2:end] = var_pow.moving_pow[1:end-1]
        var_pow.moving_pow[1]=x
    return 10log10(mean(var_pow.moving_pow.^2)/var_pow.reference)+30 ,
            10log10(maximum(var_pow.moving_pow.^2)/var_pow.reference)+30 ,
            10log10(maximum(var_pow.moving_pow.^2)/mean(var_pow.moving_pow.^2))
    elseif  var_pow.mesurement == "All" && var_pow.power_units == "dBW"
            var_pow.moving_pow[2:end] = var_pow.moving_pow[1:end-1]
            var_pow.moving_pow[1]=x
    return  10log10(mean(var_pow.moving_pow.^2)/var_pow.reference) ,
            10log10(maximum(var_pow.moving_pow.^2)/var_pow.reference) ,
            10log10(maximum(var_pow.moving_pow.^2)/mean(var_pow.moving_pow.^2))
    elseif var_pow.mesurement == "All" && var_pow.power_units == "Watts"
            var_pow.moving_pow[2:end] = var_pow.moving_pow[1:end-1]
            var_pow.moving_pow[1]=x
    return  mean(var_pow.moving_pow.^2)/var_pow.reference ,
            maximum(var_pow.moving_pow.^2)/var_pow.reference ,
            (maximum(var_pow.moving_pow.^2)/mean(var_pow.moving_pow.^2))
end 

end

var_pow=Power_meter("Peak-to_average Ratio",4,1,"Watts")
ouput_jl = [step(var_pow,1) step(var_pow,2) step(var_pow,3) step(var_pow,4)]
mat"input1=[1 2 3 4]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Power_meter_Peak_to_average_Ratio_Watts')"
ouput_mat=mat"output1'"
test = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Power_meter_Peak_to_average_Ratio_Watts пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Power_meter_Peak_to_average_Ratio_Watts не пройден")
end

var_pow=Power_meter("Peak-to_average Ratio",4,1,"dBW")
ouput_jl = [step(var_pow,1) step(var_pow,2) step(var_pow,3) step(var_pow,4)]
mat"input1=[1 2 3 4]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Power_meter_Peak_to_average_Ratio_dBW')"
ouput_mat=mat"output1'"
test = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Power_meter_Peak_to_average_Ratio_dBW пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Power_meter_Peak_to_average_Ratio_dBW не пройден")
end


var_pow=Power_meter("Peak-to_average Ratio",4,1,"dBm")
ouput_jl = [step(var_pow,1) step(var_pow,2) step(var_pow,3) step(var_pow,4)]
mat"input1=[1 2 3 4]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Power_meter_Peak_to_average_Ratio_dBm')"
ouput_mat=mat"output1'"
test = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Power_meter_Peak_to_average_Ratio_dBm пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Power_meter_Peak_to_average_Ratio_dBm не пройден")
end
#

var_pow=Power_meter("Peak power",4,1,"Watts")
ouput_jl = [step(var_pow,1) step(var_pow,2) step(var_pow,3) step(var_pow,4)]
mat"input1=[1 2 3 4]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Power_meter_Peak_power_Watts')"
ouput_mat=mat"output1'"
test = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Power_meter_Peak_power_Watts пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Power_meter_Peak_power_Watts не пройден")
end

var_pow=Power_meter("Peak power",4,1,"dBW")
ouput_jl = [step(var_pow,1) step(var_pow,2) step(var_pow,3) step(var_pow,4)]
mat"input1=[1 2 3 4]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Power_meter_Peak_power_dBW')"
ouput_mat=mat"output1'"
test = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Power_meter_Peak_power_dBW пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Power_meter_Peak_power_dBW не пройден")
end


var_pow=Power_meter("Peak power",4,1,"dBm")
ouput_jl = [step(var_pow,1) step(var_pow,2) step(var_pow,3) step(var_pow,4)]
mat"input1=[1 2 3 4]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Power_meter_Peak_power_dBm')"
ouput_mat=mat"output1'"
test = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Power_meter_Peak_power_dBm пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Power_meter_Peak_power_dBm не пройден")
end
##

var_pow=Power_meter("Average power",4,1,"Watts")
ouput_jl = [step(var_pow,1) step(var_pow,2) step(var_pow,3) step(var_pow,4)]
mat"input1=[1 2 3 4]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Power_meter_Average_power_Watts')"
ouput_mat=mat"output1'"
test = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Power_meter_Average_power_Watts пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Power_meter_Average_power_Watts не пройден")
end

var_pow=Power_meter("Average power",4,1,"dBW")
ouput_jl = [step(var_pow,1) step(var_pow,2) step(var_pow,3) step(var_pow,4)]
mat"input1=[1 2 3 4]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Power_meter_Average_power_dBW')"
ouput_mat=mat"output1'"
test = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Power_meter_Average_power_dBW пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Power_meter_Average_power_dBW не пройден")
end


var_pow=Power_meter("Average power",4,1,"dBm")
ouput_jl = [step(var_pow,1) step(var_pow,2) step(var_pow,3) step(var_pow,4)]
mat"input1=[1 2 3 4]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Power_meter_Average_power_dBm')"
ouput_mat=mat"output1'"
test = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Power_meter_Average_power_dBm пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Power_meter_Average_power_dBm не пройден")
end

#=var_pow=Power_meter("All",4,1,"Watts")
ouput_jl = step(var_pow,1), step(var_pow,2), step(var_pow,3), step(var_pow,4) 
mat"input1=[1 2 3 4]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Power_meter_All_Watts')"
ouput_mat=mat"outputavg'",mat"outputpeak'",mat"outputPAPR'"=#