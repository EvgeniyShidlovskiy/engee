
mutable struct Autocorrelation
    acorr::Array{Float64}
    scaling::String
    com_all_neg_lags::Bool
    qty_non_neg_lags::Int64

    function Autocorrelation(scaling::String)
        if scaling != "None" && scaling != "Biased" && scaling != "Unbiased" && scaling != "Unity at zero-lag" 
            error("Scaling должен быть значением None или Biased или Unbiased или Unity at zero-lag")
        end
        new([0.0],scaling,true,0)
    end
    function Autocorrelation(scaling::String,qty_non_neg_lags::Int64)
         if scaling != "None" && scaling != "Biased" && scaling != "Unbiased" && scaling != "Unity at zero-lag" 
            error("Scaling должен быть значением None или Biased или Unbiased или Unity at zero-lag")
        end
        new([0.0],scaling,false,qty_non_neg_lags)
    end
end

 function step(var_acorr::Autocorrelation,u)
 
    if var_acorr.com_all_neg_lags == false
        if var_acorr.qty_non_neg_lags > length(u)
            error("Максимальное количество задержек должно быть меньше длины вводимых значений
            The maximum lag must be less than the number of input samples")
        end
        lags = var_acorr.qty_non_neg_lags + 1 
    elseif var_acorr.com_all_neg_lags == true
        lags = (length(u))
    end
    if var_acorr.scaling == "None" 
        y = zeros(lags);
    idxout = 1;
        for i = 1:lags 
        accTmp = 0.0;
        idx1 = 1;
        idx2 = i;
            for k = 1:length(u) - i+1
            accTmp = accTmp + u[idx1] * u[idx2];
            idx1=idx1+1;
            idx2=idx2+1;
            end
        y[idxout] = accTmp;
        idxout=idxout+1;
        end
    elseif var_acorr.scaling == "Biased"
        y = zeros(lags);
        idxout = 1;
            for i = 1:lags
            accTmp = 0.0;
            idx1 = 1;
            idx2 = i;
                for k = 1:length(u) - i+1
                accTmp = accTmp + u[idx1] * u[idx2];
                idx1=idx1+1;
                idx2=idx2+1;
                end
            y[idxout] = accTmp/length(u);
            idxout=idxout+1;
            end
    elseif var_acorr.scaling == "Unbiased"
        y = zeros(lags);
        idxout = 1;
            for i = 1:lags 
            accTmp = 0.0;
            idx1 = 1;
            idx2 = i;
                for k = 1:length(u) - i+1
                accTmp = accTmp + u[idx1] * u[idx2];
                idx1=idx1+1;
                idx2=idx2+1;
                end

            y[idxout] = accTmp/(length(u)-i+1);
            idxout=idxout+1;
            end
    else var_acorr.scaling == "Unity at zero-lag"
        y = zeros(lags);
        accTmp0 = 0.0
        idxout = 1;
            for i = 1:lags 
            accTmp = 0.0;
            idx1 = 1;
            idx2 = i;
                for k = 1:length(u) - i+1
                accTmp = accTmp + u[idx1] * u[idx2];
                idx1=idx1+1;
                idx2=idx2+1;
                end
                    if i==1
                    accTmp0 = accTmp;
                    end
                y[idxout] = accTmp/accTmp0;
                idxout=idxout+1;
            end
         end
    return y
end
var_acorr=Autocorrelation("None",3)
outputjl=step(var_acorr,[1 2 3 4 5 6 7 8])
