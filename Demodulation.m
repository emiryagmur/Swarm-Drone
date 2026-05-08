function [BaseBandSignal] = Demodulation(ReceivedSignal)

Fs = 1e5;
fc = 20000;
fp = 1000;

t = (0:length(ReceivedSignal)-1)/Fs;

ReceivedSignal = smoothdata(ReceivedSignal,'movmean',5);

Carrier = sin(2*pi*fc*t);
d = ReceivedSignal .* Carrier;
df = lowpass(d,2100,Fs);

PhaseCarrier = sin(2*pi*fp*t);
p = df .* PhaseCarrier .* 2;
pf = lowpass(p,1200,Fs);

BaseBandSignal = pf;

end
