function [out_sig] = NEWFFT(in_sig,k,N)
    len = size(in_sig,2);
    out_sig = zeros(1,len);
    if len == 1
        out_sig = in_sig;
          
    else 
        Ok = in_sig(1:2:len);
        Ek = in_sig(2:2:len);
    
        FOk = NEWFFT(Ok,k,N/2);
        FEk = NEWFFT(Ek,k,N/2);
        
        out_sig = FEk + exp(-1i*2*pi*k/N).*FOk;
    end
end