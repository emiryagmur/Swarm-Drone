function [PhaseCodedSignal] = PhaseModulation(BinaryMessage)

TransmittedSignal = 2*(BinaryMessage-'0')-1;

Tb = 1e-3;
Fs = 1e5;

Ns = round(Tb*Fs);

b = TransmittedSignal;

MessageSignal = repelem(b, Ns);

t = (0:length(MessageSignal)-1)/Fs;

fp = 1000;

phi = MessageSignal*(-pi/2) + pi/2;

PhaseCodedSignal = sin(2*pi*fp*t + phi);

end