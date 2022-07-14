mutable struct Detrend
    mode::String
    function Detrend(mode::String)
          new(mode)
    end
end

function step(var_det::Detrend,x)
  y=zeros(length(x))
  rtb_a = 0.0;
  tmp = -0.0;

  ramp = collect(1:length(x)) 
  DotProduct2 = sum(ramp.*ramp)    
  Maximum = maximum(ramp) 
  MatrixSum1=sum(ramp)  
  linearterm3=DotProduct2*Maximum  
  linearterm2= MatrixSum1^2    
  Sum1 = linearterm3 - linearterm2 

  for i = 0:length(x)-1
  
    rtb_a = rtb_a + ramp[i+1] .* x[i+1];
    tmp = tmp + x[i+1];
  end

 
  if Sum1 > 1.0
 
  
    rtb_b = (DotProduct2 * tmp - MatrixSum1 *
             rtb_a) / Sum1;

    
    rtb_a = (rtb_a * Maximum - tmp * MatrixSum1) /
      Sum1;

  
  elseif Sum1 <= 1.0
 
    rtb_b = x[1];

    rtb_a = Sum1;

  end

 
  for i = 0:1:length(x)-3

    y[i+1] = x[i+1] - (ramp[i+1] * rtb_a +
    rtb_b);
  end

  for i = length(x)-2:length(x)-1
   
    y[i+1] = x[i+1] - (ramp[i+1] * rtb_a +
      rtb_b);
  end
  return y
end

step([-2 3 7 6 7 6 -7])