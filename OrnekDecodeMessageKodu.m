function [Message] = OrnekDecodeMessageKodu(TransmittedSignal)

% Ilk is olarak demodulation yapip sinyali baseband'e indiririz
BaseBandSignal = Demodulation(TransmittedSignal);

% Daha sonra bu sinyalden binary string'i geri elde ederiz
BinaryMessage = ReceivedBinaryMessage(BaseBandSignal);

% En son ise binary'ye bakip mesaji cozumleriz
Message = GetMessages(BinaryMessage);

end

