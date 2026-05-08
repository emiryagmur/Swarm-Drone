function [Message] = DecodeCommunucation(TransmittedSignal)

BaseBandSignal = Demodulation(TransmittedSignal);

BinaryMessage = ReceivedBinaryMessage(BaseBandSignal);

Message = GetMessages(BinaryMessage);

end

