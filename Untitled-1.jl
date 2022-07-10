

function step(u,bins,low_lim,up_lim)

y = zeros(bins)
i = 1;
  for k=1:length(u)
   
    if u[i] <= low_lim 
		  u0 = 1;
    elseif u[i] > up_lim
      u0 = bins-1;
    else 
      z=(u[i]-low_lim)
      r=bins/(up_lim-low_lim)
      u0::Int = ceil((z)  * (r));
        if (u0 > bins-1) 
          u0 = bins-1;
        end
    end
 
    y[u0]=y[u0]+1;
	  i=i+1;
  end
  return permutedims(hcat(y))
end
  step([2 3 3 4 4 4 -2 -2 5 5 5 5 5],12,1,4)
