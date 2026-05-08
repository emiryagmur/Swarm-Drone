%TODO: inputları tanımla.

BitNumber=8;
Scale=100;

TemperatureInteger=floor(Temperature);
TemperatureDecimal=round((Temperature-TemperatureInteger)*Scale);

TemperatureInteger2Binary = dec2bin(typecast(int8(TemperatureInteger),'uint8'),8);
TemperatureDecimal2Binary = dec2bin(TemperatureDecimal,8);

if length(TemperatureInteger2Binary)>BitNumber
TemperatureInteger2Binary = TemperatureInteger2Binary(end-BitNumber+1:end);
end

if length(TemperatureDecimal2Binary)>BitNumber
TemperatureDecimal2Binary = TemperatureDecimal2Binary(end-BitNumber+1:end);
end

BatteryInteger=floor(Battery);
BatteryDecimal=round((Battery-BatteryInteger)*Scale);

BatteryInteger2Binary = dec2bin(typecast(int8(BatteryInteger),'uint8'),8);
BatteryDecimal2Binary = dec2bin(BatteryDecimal,8);

if length(BatteryInteger2Binary)>BitNumber
BatteryInteger2Binary = BatteryInteger2Binary(end-BitNumber+1:end);
end

if length(BatteryDecimal2Binary)>BitNumber
BatteryDecimal2Binary = BatteryDecimal2Binary(end-BitNumber+1:end);
end


XCoordinate = Position(1);
YCoordinate = Position(2);
ZCoordinate = Position(3);

XCoordinateInteger=floor(XCoordinate);
XCoordinateDecimal=round((XCoordinate-XCoordinateInteger)*Scale);

XCoordinateInteger2Binary = dec2bin(typecast(int8(XCoordinateInteger),'uint8'),8);
XCoordinateDecimal2Binary = dec2bin(XCoordinateDecimal,8);

if length(XCoordinateInteger2Binary)>BitNumber
XCoordinateInteger2Binary = XCoordinateInteger2Binary(end-BitNumber+1:end);
end
if length(XCoordinateDecimal2Binary)>BitNumber
XCoordinateDecimal2Binary = XCoordinateDecimal2Binary(end-BitNumber+1:end);
end


YCoordinateInteger=floor(YCoordinate);
YCoordinateDecimal=round((YCoordinate-YCoordinateInteger)*Scale);

YCoordinateInteger2Binary = dec2bin(typecast(int8(YCoordinateInteger),'uint8'),8);
YCoordinateDecimal2Binary = dec2bin(YCoordinateDecimal,8);

if length(YCoordinateInteger2Binary)>BitNumber
YCoordinateInteger2Binary = YCoordinateInteger2Binary(end-BitNumber+1:end);
end
if length(YCoordinateDecimal2Binary)>BitNumber
YCoordinateDecimal2Binary = YCoordinateDecimal2Binary(end-BitNumber+1:end);
end


ZCoordinateInteger=floor(ZCoordinate);
ZCoordinateDecimal=round((ZCoordinate-ZCoordinateInteger)*Scale);

ZCoordinateInteger2Binary = dec2bin(typecast(int8(ZCoordinateInteger),'uint8'),8);
ZCoordinateDecimal2Binary = dec2bin(ZCoordinateDecimal,8);

if length(ZCoordinateInteger2Binary)>BitNumber
ZCoordinateInteger2Binary = ZCoordinateInteger2Binary(end-BitNumber+1:end);
end
if length(ZCoordinateDecimal2Binary)>BitNumber
ZCoordinateDecimal2Binary = ZCoordinateDecimal2Binary(end-BitNumber+1:end);
end

XVelocity = Velocity(1);
YVelocity = Velocity(2);
ZVelocity = Velocity(3);

XVelocityInteger=floor(XVelocity);
XVelocityDecimal=round((XVelocity-XVelocityInteger)*Scale);

XVelocityInteger2Binary = dec2bin(typecast(int8(XVelocityInteger),'uint8'),8);
XVelocityDecimal2Binary = dec2bin(XVelocityDecimal,8);

if length(XVelocityInteger2Binary)>BitNumber
XVelocityInteger2Binary = XVelocityInteger2Binary(end-BitNumber+1:end);
end
if length(XVelocityDecimal2Binary)>BitNumber
XVelocityDecimal2Binary = XVelocityDecimal2Binary(end-BitNumber+1:end);
end

YVelocityInteger=floor(YVelocity);
YVelocityDecimal=round((YVelocity-YVelocityInteger)*Scale);

YVelocityInteger2Binary = dec2bin(typecast(int8(YVelocityInteger),'uint8'),8);
YVelocityDecimal2Binary = dec2bin(YVelocityDecimal,8);

if length(YVelocityInteger2Binary)>BitNumber
YVelocityInteger2Binary = YVelocityInteger2Binary(end-BitNumber+1:end);
end
if length(YVelocityDecimal2Binary)>BitNumber
YVelocityDecimal2Binary = YVelocityDecimal2Binary(end-BitNumber+1:end);
end

ZVelocityInteger=floor(ZVelocity);
ZVelocityDecimal=round((ZVelocity-ZVelocityInteger)*Scale);

ZVelocityInteger2Binary = dec2bin(typecast(int8(ZVelocityInteger),'uint8'),8);
ZVelocityDecimal2Binary = dec2bin(ZVelocityDecimal,8);

if length(ZVelocityInteger2Binary)>BitNumber
ZVelocityInteger2Binary = ZVelocityInteger2Binary(end-BitNumber+1:end);
end
if length(ZVelocityDecimal2Binary)>BitNumber
ZVelocityDecimal2Binary = ZVelocityDecimal2Binary(end-BitNumber+1:end);
end


TransmittedSignal=strcat(TemperatureInteger2Binary,TemperatureDecimal2Binary,BatteryInteger2Binary,BatteryDecimal2Binary,XCoordinateInteger2Binary,XCoordinateDecimal2Binary,YCoordinateInteger2Binary,YCoordinateDecimal2Binary,ZCoordinateInteger2Binary,ZCoordinateDecimal2Binary,XVelocityInteger2Binary,XVelocityDecimal2Binary,YVelocityInteger2Binary,YVelocityDecimal2Binary,ZVelocityInteger2Binary,ZVelocityDecimal2Binary);
%TODO: comment windowa yazdır.

TransmittedSignal = 2*(TransmittedSignal-'0')-1;
%todo comment windowa yazdır.

Tb = 1e-3;
Fs = 1e5;

Ns = round(Tb*Fs);

b = TransmittedSignal;

MessageSignal = repelem(b, Ns);
%todo comment windowa yazdır.
t = (0:length(MessageSignal)-1)/Fs;

fp = 1000;

phi = MessageSignal*(-pi/2) + pi/2;
%todo test optional.
PhaseCodedSignal = sin(2*pi*fp*t + phi);
%todo test. hem time domainde hem de fourier domainde (fft uygula)
fc = 20000;

Carrier = sin(2*pi*fc*t);
%todo test. hem time domainde hem de fourier domainde (fft uygula)
TransmittedSignal = PhaseCodedSignal .* Carrier;
%todo test. hem time domainde hem de fourier domainde (fft uygula)
Fs = 1e5;
fc = 20000;
fp = 1000;

t = (0:length(ReceivedSignal)-1)/Fs;

%ReceivedSignal = smoothdata(ReceivedSignal,'movmean',5);

Carrier = sin(2*pi*fc*t);
d = ReceivedSignal .* Carrier;
%todo test. hem time domainde hem de fourier domainde (fft uygula)
df = lowpass(d,2100,Fs);
%todo test. hem time domainde hem de fourier domainde (fft uygula)

PhaseCarrier = sin(2*pi*fp*t);
p = df .* PhaseCarrier .* 2;
%todo test. hem time domainde hem de fourier domainde (fft uygula)
pf = lowpass(p,1200,Fs);
%todo test. hem time domainde hem de fourier domainde (fft uygula)

BaseBandSignal = pf;

Tb = 1e-3;
Fs = 1e5;

Ns = round(Tb*Fs);

Nbits = floor(length(BaseBandSignal)/Ns);
%todo comment windowa yazdır
BinaryMessage = '';

for i = 1:Nbits
    
    segment = BaseBandSignal((i-1)*Ns+1 : i*Ns);
    
    if mean(segment) > 0
        BinaryMessage = strcat(BinaryMessage,'1');
    else
        BinaryMessage = strcat(BinaryMessage,'0');
    end
    
end
%todo comment windowa yazdır

BitNumber = 8;
Scale = 100;
index = 1;

ReadInt = @(binStr) double(typecast(uint8(bin2dec(binStr)), 'int8'));
ReadDec = @(binStr) double(bin2dec(binStr));

TemperatureInteger = ReadInt(BinaryMessage(index:index+7)); index=index+BitNumber;
TemperatureDecimal = ReadDec(BinaryMessage(index:index+7)); index=index+BitNumber;

BatteryInteger = ReadInt(BinaryMessage(index:index+7)); index=index+BitNumber;
BatteryDecimal = ReadDec(BinaryMessage(index:index+7)); index=index+BitNumber;

Xint = ReadInt(BinaryMessage(index:index+7)); index=index+BitNumber;
Xdec = ReadDec(BinaryMessage(index:index+7)); index=index+BitNumber;

Yint = ReadInt(BinaryMessage(index:index+7)); index=index+BitNumber;
Ydec = ReadDec(BinaryMessage(index:index+7)); index=index+BitNumber;

Zint = ReadInt(BinaryMessage(index:index+7)); index=index+BitNumber;
Zdec = ReadDec(BinaryMessage(index:index+7)); index=index+BitNumber;

VXint = ReadInt(BinaryMessage(index:index+7)); index=index+BitNumber;
VXdec = ReadDec(BinaryMessage(index:index+7)); index=index+BitNumber;

VYint = ReadInt(BinaryMessage(index:index+7)); index=index+BitNumber;
VYdec = ReadDec(BinaryMessage(index:index+7)); index=index+BitNumber;

VZint = ReadInt(BinaryMessage(index:index+7)); index=index+BitNumber;
VZdec = ReadDec(BinaryMessage(index:index+7));
%todo comment windowa yazdır

CombineVals = @(intPart, decPart) intPart + sign(intPart + (intPart==0)) * (decPart/Scale);
%todo comment windowa yazdır

Message.Temperature = CombineVals(TemperatureInteger, TemperatureDecimal);
Message.Battery = CombineVals(BatteryInteger, BatteryDecimal);
Message.Position = [CombineVals(Xint, Xdec) CombineVals(Yint, Ydec) CombineVals(Zint, Zdec)];
Message.Velocity = [CombineVals(VXint, VXdec) CombineVals(VYint, VYdec) CombineVals(VZint, VZdec)];
%todo comment windowa yazdır