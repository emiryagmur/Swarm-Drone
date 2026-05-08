function [MessageSignal] = ConstructMessageSignal(BinaryMessage)

Tb = 1e-3;
Fs = 1e5;

Ns = round(Tb*Fs);

b = TransmittedSignal;

MessageSignal = repelem(b, Ns);

end