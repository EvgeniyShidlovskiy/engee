mutable struct FIRFilter
       dstates::Array{Float64}
       num::Array{Float64}
       function FIRFilter(num::Array{Float64})
              new(zeros(length(num)),num)
       end
 end
 fir=FIRFilter([1.0;1.0;1.0;1.0])
fir2=FIRFilter([1.0;1.0;1.0;1.0;1.0])
 function step(fir::FIRFilter,x::Float64)
       fir.dstates[2:end]=fir.dstates[1:end-1]
       fir.dstates[1]=x
       return sum(fir.num .* fir.dstates)        
 end
 step(fir,1.0)