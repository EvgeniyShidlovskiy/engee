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
	y = zeros(port1)
	out = 0;
		for i = 0:(port1 + port2)-3
		
			if i - (port2-1) >= 0 
			  j = i - (port2-1);
			else 
			  j = 0;
			end

			if i <= port1-1 
			  jEnd = i;
			else 
			  jEnd = port1-1;
			end

		acc = x[(j - i) + (port2-1)+1] * u[j+1];
			for j=j:jEnd-1 
			  acc = acc + x[(j - i) + (port2-1)+1] * u[j+1];
			end

		y[out+1] = acc;
		out=out+1;
		end
		return permutedims(hcat(y))
end
var_xcorr=Correlation("Correlation")
ouput_jl=step(var_xcorr,[7 8 -9 0],[1 2 3 4])

