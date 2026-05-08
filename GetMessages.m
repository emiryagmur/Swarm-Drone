function Message = GetMessages(BinaryMessage)
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

CombineVals = @(intPart, decPart) intPart + sign(intPart + (intPart==0)) * (decPart/Scale);

Message.Temperature = CombineVals(TemperatureInteger, TemperatureDecimal);
Message.Battery = CombineVals(BatteryInteger, BatteryDecimal);
Message.Position = [CombineVals(Xint, Xdec) CombineVals(Yint, Ydec) CombineVals(Zint, Zdec)];
Message.Velocity = [CombineVals(VXint, VXdec) CombineVals(VYint, VYdec) CombineVals(VZint, VZdec)];
end