function [BinaryMessage] = GenerateBinaryMessage(Temperature,Battery,Position,Velocity)

BitNumber=8;
Scale=100;

if Temperature >= 0
    TemperatureInteger=floor(Temperature);
    TemperatureDecimal=round((Temperature-TemperatureInteger)*Scale);
else
    TemperatureInteger=ceil(Temperature);
    TemperatureDecimal=round((TemperatureInteger-Temperature)*Scale);
end

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

if XCoordinate >= 0
    XCoordinatenteger=floor(XCoordinate);
    XCoordinateDecimal=round((XCoordinate-XCoordinateInteger)*Scale);
else
    XCoordinateInteger=ceil(XCoordinate);
    XCoordinateDecimal=round((XCoordinateInteger-XCoordinate)*Scale);
end

XCoordinateInteger2Binary = dec2bin(typecast(int8(XCoordinateInteger),'uint8'),8);
XCoordinateDecimal2Binary = dec2bin(XCoordinateDecimal,8);

if length(XCoordinateInteger2Binary)>BitNumber
XCoordinateInteger2Binary = XCoordinateInteger2Binary(end-BitNumber+1:end);
end

if length(XCoordinateDecimal2Binary)>BitNumber
XCoordinateDecimal2Binary = XCoordinateDecimal2Binary(end-BitNumber+1:end);
end

if YCoordinate >= 0
    YCoordinatenteger=floor(YCoordinate);
    YCoordinateDecimal=round((YCoordinate-YCoordinateInteger)*Scale);
else
    YCoordinateInteger=ceil(YCoordinate);
    YCoordinateDecimal=round((YCoordinateInteger-YCoordinate)*Scale);
end

YCoordinateInteger2Binary = dec2bin(typecast(int8(YCoordinateInteger),'uint8'),8);
YCoordinateDecimal2Binary = dec2bin(YCoordinateDecimal,8);

if length(YCoordinateInteger2Binary)>BitNumber
YCoordinateInteger2Binary = YCoordinateInteger2Binary(end-BitNumber+1:end);
end

if length(YCoordinateDecimal2Binary)>BitNumber
YCoordinateDecimal2Binary = YCoordinateDecimal2Binary(end-BitNumber+1:end);
end

if ZCoordinate >= 0
    ZCoordinatenteger=floor(ZCoordinate);
    ZCoordinateDecimal=round((ZCoordinate-ZCoordinateInteger)*Scale);
else
    ZCoordinateInteger=ceil(ZCoordinate);
    ZCoordinateDecimal=round((ZCoordinateInteger-ZCoordinate)*Scale);
end

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

if XVelocity >= 0
    XVelocityInteger=floor(XVelocity);
    XVelocityDecimal=round((XVelocity-XVelocityInteger)*Scale);
else
    XVelocityInteger=ceil(XVelocity);
    XVelocityDecimal=round((XVelocityInteger-XVelocity)*Scale);
end

XVelocityInteger2Binary = dec2bin(typecast(int8(XVelocityInteger),'uint8'),8);
XVelocityDecimal2Binary = dec2bin(XVelocityDecimal,8);

if length(XVelocityInteger2Binary)>BitNumber
XVelocityInteger2Binary = XVelocityInteger2Binary(end-BitNumber+1:end);
end

if length(XVelocityDecimal2Binary)>BitNumber
XVelocityDecimal2Binary = XVelocityDecimal2Binary(end-BitNumber+1:end);
end

if YVelocity >= 0
    YVelocityInteger=floor(YVelocity);
    YVelocityDecimal=round((YVelocity-YVelocityInteger)*Scale);
else
    YVelocityInteger=ceil(YVelocity);
    YVelocityDecimal=round((YVelocityInteger-YVelocity)*Scale);
end

YVelocityInteger2Binary = dec2bin(typecast(int8(YVelocityInteger),'uint8'),8);
YVelocityDecimal2Binary = dec2bin(YVelocityDecimal,8);

if length(YVelocityInteger2Binary)>BitNumber
YVelocityInteger2Binary = YVelocityInteger2Binary(end-BitNumber+1:end);
end

if length(YVelocityDecimal2Binary)>BitNumber
YVelocityDecimal2Binary = YVelocityDecimal2Binary(end-BitNumber+1:end);
end

if ZVelocity >= 0
    ZVelocityInteger=floor(ZVelocity);
    ZVelocityDecimal=round((ZVelocity-ZVelocityInteger)*Scale);
else
    ZVelocityInteger=ceil(ZVelocity);
    ZVelocityDecimal=round((ZVelocityInteger-ZVelocity)*Scale);
end

ZVelocityInteger2Binary = dec2bin(typecast(int8(ZVelocityInteger),'uint8'),8);
ZVelocityDecimal2Binary = dec2bin(ZVelocityDecimal,8);

if length(ZVelocityInteger2Binary)>BitNumber
ZVelocityInteger2Binary = ZVelocityInteger2Binary(end-BitNumber+1:end);
end

if length(ZVelocityDecimal2Binary)>BitNumber
ZVelocityDecimal2Binary = ZVelocityDecimal2Binary(end-BitNumber+1:end);
end

BinaryMessage = strcat(TemperatureInteger2Binary,TemperatureDecimal2Binary,...
BatteryInteger2Binary,BatteryDecimal2Binary,...
XCoordinateInteger2Binary,XCoordinateDecimal2Binary,...
YCoordinateInteger2Binary,YCoordinateDecimal2Binary,...
ZCoordinateInteger2Binary,ZCoordinateDecimal2Binary,...
XVelocityInteger2Binary,XVelocityDecimal2Binary,...
YVelocityInteger2Binary,YVelocityDecimal2Binary,...
ZVelocityInteger2Binary,ZVelocityDecimal2Binary);

end
