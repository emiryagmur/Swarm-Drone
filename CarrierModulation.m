function [TransmittedSignal] = CarrierModulation(PhaseCodedSignal)

Fs = 1e5;

t = (0:length(PhaseCodedSignal)-1)/Fs;

fc = 20000;

Carrier = sin(2*pi*fc*t);

TransmittedSignal = PhaseCodedSignal .* Carrier;

end