
mutable struct Histogram
  find_hist_over::String
  bins::Int64
  low_lim::Int64
  up_lim::Int64
  normalized::Bool
  running:: Bool
  reset_port:: String
  y::Array{Float64}
  ye::Array{Float64}

  function Histogram(find_hist_over::String,bins::Int64,low_lim::Int64,up_lim::Int64)
  if find_hist_over != "Entire input" && find_hist_over != "Each column"
    error("Поиск гистограммы должен быть по методу Entire input или Each column")
  end
     new(find_hist_over,bins,low_lim,up_lim,false,false,"")
  end
  function Histogram(find_hist_over::String,bins::Int64,low_lim::Int64,up_lim::Int64,normalized::Bool)
    if find_hist_over != "Entire input" && find_hist_over != "Each column"
      error("Поиск гистограммы должен быть по методу Entire input или Each column")
    end
       new(find_hist_over,bins,low_lim,up_lim,normalized,false,"")
    end
    
  function Histogram(find_hist_over::String,bins::Int64,low_lim::Int64,up_lim::Int64,normalized::Bool,running:: Bool,reset_port:: String)
      if find_hist_over != "Entire input" && find_hist_over != "Each column"
        error("Поиск гистограммы должен быть по методу Entire input или Each column")
      end
         new(find_hist_over,bins,low_lim,up_lim,normalized,running,reset_port,zeros(bins),[0.0])
  end  
end

function setup(var_hist::Histogram,u)
  var_hist.ye = zeros(var_hist.bins,size(u,2))
end
function step(var_hist::Histogram,u)
  if var_hist.find_hist_over == "Entire input" && var_hist.normalized == false
y = zeros(var_hist.bins)

  for k=1:length(u)
   
    if u[i] <= var_hist.low_lim 
		  u0 = 1;
    elseif u[i] > var_hist.up_lim
      u0 = var_hist.bins;
    else 
      z=(u[i]-var_hist.low_lim)
      r=var_hist.bins/(var_hist.up_lim-var_hist.low_lim)
      u0::Int = ceil((z)  * (r));
        if (u0 > var_hist.bins-1) 
          u0 = var_hist.bins;
        end
    end
 
    y[u0]=y[u0]+1;
	  i=i+1;
  end
elseif var_hist.find_hist_over == "Each column" && var_hist.normalized == false
  y=zeros(var_hist.bins,size(u,2))
  i = -(size(u,1)-1);
  idxOutO = 1;
    for  j = 1:size(u,2)
    
      idxIn = i + (size(u,1));
      for k = 1:size(u,1)
        
          
          if (u[idxIn] <= var_hist.low_lim)
            u0 = 1;
          elseif u[idxIn] > var_hist.up_lim
            u0 = var_hist.bins;
          else 
            u0::Int = ceil((u[idxIn] - var_hist.low_lim) * var_hist.bins/(var_hist.up_lim-var_hist.low_lim));
            if (u0 > var_hist.bins-1) 
              u0 = var_hist.bins;
            end
          end

          u0 = u0 + idxOutO-1;
          y[u0]=y[u0]+1;
          idxIn=idxIn+1;
      end

      i = i + size(u,1);
      idxOutO =idxOutO+var_hist.bins;  
  end
elseif var_hist.find_hist_over == "Entire input" && var_hist.normalized == true
  y=zeros(var_hist.bins)
  i = 0;
   for k = 0:size(u,1)*size(u,2)-1
   
       if u[i+1] <= var_hist.low_lim
         u0 = 0;
        elseif u[i+1] > var_hist.up_lim
         u0 = var_hist.bins-1;
        else 
       r=var_hist.bins/(var_hist.up_lim-var_hist.low_lim)
         u0::Int = ceil((u[i+1] - var_hist.low_lim) * r - 1.0);
         if (u0 > var_hist.bins-1) 
           u0 = var_hist.bins-1;
         end
       end
 
       y[u0+1]=y[u0+1]+1;
       i=i+1;
   end
 
   for i = 0:1:var_hist.bins-3
     y[i+1] = y[i+1]/(size(u,1)*size(u,2))
       
   end
  
   for i = var_hist.bins-2:var_hist.bins-1
    y[i+1] = y[i+1]/(size(u,1)*size(u,2))
   end

elseif var_hist.find_hist_over == "Each column" && var_hist.normalized == true
  y=zeros(var_hist.bins,size(u,2))
  i = -(size(u,1)-1);
    idxOutO = 0;
    for j = 0:size(u,2)-1
     
      idxIn = i + (size(u,1)-1);
      for k = 0:size(u,1)-1
        
          
          if u[idxIn+1] <= var_hist.low_lim
            u0 = 0;
           elseif u[idxIn+1] > var_hist.up_lim
             u0 = var_hist.bins-1;
           else 
            r= var_hist.bins/(var_hist.up_lim-var_hist.low_lim)
            u0::Int = ceil((u[idxIn+1] - var_hist.low_lim) *  r - 1.0);
            if (u0 > var_hist.bins-1) 
              u0 = var_hist.bins-1;
        end
           end
  
          u0 = u0 + idxOutO
          y[u0+1]=y[u0+1]+1;
          idxIn=idxIn+1;
        end
  
      i = i + size(u,1);
      idxOutO =idxOutO + var_hist.bins;
   end
  
     for i = 0:1:(var_hist.bins*size(u,2))-3
  
     y[i+1] =  y[i+1]/size(u,1)
  
   for i = (var_hist.bins*size(u,2))-2:(var_hist.bins*size(u,2))-1
      y[i+1] = y[i+1]/(size(u,1))
     end
end
end
return show(y)
end

function step(var_hist::Histogram,u,rst)
  if var_hist.find_hist_over == "Entire input" && var_hist.normalized == false && var_hist.running == true && var_hist.reset_port == "None-zero sample"
 
    
    if rst != 0
      for i = 0:var_hist.bins-1
        var_hist.y[i+1] = 0.0;
      end
  
      i = 0;
   for k = 0:size(u,1)*size(u,2)-1
     
         if u[i+1] <= var_hist.low_lim
           u0 = 0;
          elseif u[i+1] > var_hist.up_lim
           u0 = var_hist.bins-1;
          else 
         r=var_hist.bins/(var_hist.up_lim-var_hist.low_lim)
           u0::Int = ceil((u[i+1] - var_hist.low_lim) * r - 1.0);
           if (u0 > var_hist.bins-1) 
             u0 = var_hist.bins-1;
           end
         end
   
         var_hist.y[u0+1]=var_hist.y[u0+1]+1;
         i=i+1;
     end
    else 
      i = 0;
       for k = 0:size(u,1)*size(u,2)-1
     
         if u[i+1] <= var_hist.low_lim
           u0 = 0;
          elseif u[i+1] > var_hist.up_lim
           u0 = var_hist.bins-1;
          else 
         r=var_hist.bins/(var_hist.up_lim-var_hist.low_lim)
           u0::Int = ceil((u[i+1] - var_hist.low_lim) * r - 1.0);
           if (u0 > var_hist.bins-1) 
             u0 = var_hist.bins-1;
           end
         end
   
         var_hist.y[u0+1]=var_hist.y[u0+1]+1;
         i=i+1;
     end
    end
  elseif var_hist.find_hist_over == "Each column" && var_hist.normalized == false && var_hist.running == true && var_hist.reset_port == "None-zero sample" 
  
    if rst != 0 
     i = -(size(u,1)-1)
    idxOutO = 0;
    for j = 0:size(u,2)-1
     
      idxIn = i + (size(u,1)-1);
      for k = 0:size(u,1)-1
        
           if u[idxIn+1] <= var_hist.low_lim
            u0 = 0;
           elseif u[idxIn+1] > var_hist.up_lim
             u0 = var_hist.bins-1;
           else 
            r= var_hist.bins/(var_hist.up_lim-var_hist.low_lim)
            u0::Int = ceil((u[idxIn+1] - var_hist.low_lim) *  r - 1.0);
            if (u0 > var_hist.bins-1) 
              u0 = var_hist.bins-1;
        end
           end

          u0 = u0 + idxOutO
          var_hist.ye[u0+1]=var_hist.ye[u0+1]+1;
          idxIn=idxIn+1;
        end
  
      i = i + size(u,1);
      idxOutO =idxOutO + var_hist.bins;
   end
  else 
    i = -(size(u,1)-1)
    idxOutO = 0;
    for j = 0:size(u,2)-1
     
      idxIn = i + (size(u,1)-1);
      for k = 0:size(u,1)-1
        
           if u[idxIn+1] <= var_hist.low_lim
            u0 = 0;
           elseif u[idxIn+1] > var_hist.up_lim
             u0 = var_hist.bins-1;
           else 
            r= var_hist.bins/(var_hist.up_lim-var_hist.low_lim)
            u0::Int = ceil((u[idxIn+1] - var_hist.low_lim) *  r - 1.0);
            if (u0 > var_hist.bins-1) 
              u0 = var_hist.bins-1;
        end
           end

          u0 = u0 + idxOutO
          var_hist.ye[u0+1]=var_hist.ye[u0+1]+1;
          idxIn=idxIn+1;
        end
  
      i = i + size(u,1);
      idxOutO =idxOutO + var_hist.bins;
   end
  end  
  end
return var_hist.ye
end

var_hist=Histogram("Each column",7,1,10,false,true,"None-zero sample")
setup(var_hist,[1 2 -2; 4 83 6; 4 100 6;4 83 6;4 -80 6;4 83 0;4 83 6;2 83 6;1 83 6])
step(var_hist,[1 2 -2; 4 83 6; 4 100 6;4 83 6;4 -80 6;4 83 0;4 83 6;2 83 6;1 83 6],0)
step(var_hist,[1 2 -2; 4 83 6; 4 100 6;4 83 6;4 -80 6;4 83 0;4 83 6;2 83 6;1 83 6],0)


