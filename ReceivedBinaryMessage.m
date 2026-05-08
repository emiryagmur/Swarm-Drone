function BinaryMessage = ReceivedBinaryMessage(BaseBandSignal)

Tb = 1e-3;
Fs = 1e5;

Ns = round(Tb*Fs);

Nbits = floor(length(BaseBandSignal)/Ns);

BinaryMessage = '';

for i = 1:Nbits
    
    segment = BaseBandSignal((i-1)*Ns+1 : i*Ns);
    
    if mean(segment) > 0
        BinaryMessage = strcat(BinaryMessage,'1');
    else
        BinaryMessage = strcat(BinaryMessage,'0');
    end
    
end