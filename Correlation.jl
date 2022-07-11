mutable struct Correlation
    mode::String
    function Correlation(mode::String)
		if mode != "Correlation"
			error("Функция должна быть Correlation")
		end
       new(mode)
    end
end

function step(var_xcorr::Correlation,u,x)
	
    port1 = length(u)
	port2 = length(x)
	y = zeros((port1 + port2)-1)
	out = 1;
		for i = 1:(port1 + port2)-1
		
			if i - (port2-1) >= 1 
			  j = i - (port2-1);
			else 
			  j = 1;
			end

			if i <= port1-1 
			  jEnd = i;
			else 
			  jEnd = port1;
			end

		acc = x[(j - i+1) + (port2-1)] * u[j];
			for j=j+1: jEnd 
			  acc = acc + x[(j - i+1) + (port2-1)] * u[j];
			end

		y[out] = acc;
		out=out+1;
		end
		return permutedims(hcat(y))
end
var_xcorr=Correlation("Correlation")
step(var_xcorr,[7 8 -9 0],[1 2 3 4])
