function [TransmittedSignal] = OrnekSendMessageKodu(Temperature,Battery,Position,Velocity)

% inputs'un icinde pozisyonlar vs olur.

% Ilk asama mesajin binary icerigini olusturulmasi
BinaryMessage = GenerateBinaryMessage(Temperature,Battery,Position,Velocity);

% Ikinci asama, binary mesaja bakip continuous time'daki gibi bir sinyal
% olusturmak
PhaseCodedSignal = PhaseModulation(BinaryMessage);

% 3. asamada transmit edilecek sinyali olustururuz. Yani modulation kismi
% ve noise ekleme kismi
TransmittedSignal = CarrierModulation(PhaseCodedSignal);

end