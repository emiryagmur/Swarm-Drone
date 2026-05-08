function [TransmittedSignal] = TransmitMessageSignal(MessageSignal);

t = (0:length(MessageSignal)-1)/Fs;

fp = 1000;

phi = MessageSignal*(-pi/2) + pi/2;

PhaseCodedSignal = sin(2*pi*fp*t + phi);

fc = 20000;

Carrier = sin(2*pi*fc*t);

TransmittedSignal = PhaseCodedSignal .* Carrier;

end
