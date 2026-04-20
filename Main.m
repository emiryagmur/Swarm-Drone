clear
close all
clc
dbstop if error

% Genel olarak bu template'teki sirayi izleyebiliriz. Her sey faraza
% yazilmistir, daha cok guncellemelere ugrar. Input ve outputlarda eksik
% veya yanlis olabilir. Islem siralarinda vs de degisiklikler olabilir.
% Input'lara, output'lara, fonksiyon isimlerine cok takilma, hangi sirada
% hangi fonksiyon gerceklesecek ona bak sadece. Isimlendirmeler vs tamamen
% degistirilebilir kolaylikla


%% Initializing the parameters
deltaT = 0.1; % in seconds


%% Generating the Map
% Ilk olarak harita olustururuz. 3D objelerle bir seyler yapabilsek cok iyi
% olur ama nasil yapildigini hic bilmiyorum.
MapParameters.MapType = 1; % haritanin parametrelerini olusturmakla baslariz
Map = GenerateMap(MapParameters); % Harita olusturma fonksiyonu



%% UAV Initialization
% Daha sonra IHA'larin baslangic konumu vs baslangic parametre ve
% kosullarini atariz.
AlphaUAV.Positions = zeros(3,1); % x position, y position, z position; all of them are in m
AlphaUAV.Velocities = zeros(3,1); % x velocity, y velocity, z velocity; all of them are in m/s
AlphaUAV.Temperatures = 30; % in Celcius degrees

BetaUAV1.Positions = [5; 0; 0]; % x position, y position, z position; all of them are in m
BetaUAV1.Velocities = zeros(3,1); % x velocity, y velocity, z velocity; all of them are in m/s
BetaUAV1.Temperatures = 30; % in Celcius degrees

BetaUAV2.Positions = [0; 5; 0]; % x position, y position, z position; all of them are in m
BetaUAV2.Velocities = zeros(3,1); % x velocity, y velocity, z velocity; all of them are in m/s
BetaUAV2.Temperatures = 30; % in Celcius degrees

BetaUAV3.Positions = [-5; 0; 0]; % x position, y position, z position; all of them are in m
BetaUAV3.Velocities = zeros(3,1); % x velocity, y velocity, z velocity; all of them are in m/s
BetaUAV3.Temperatures = 30; % in Celcius degrees

BetaUAV4.Positions = [0;-5; 0]; % x position, y position, z position; all of them are in m
BetaUAV4.Velocities = zeros(3,1); % x velocity, y velocity, z velocity; all of them are in m/s
BetaUAV4.Temperatures = 30; % in Celcius degrees


%% Simulation
FinishSimulation = 0; % Simulasyonu bitirme parametresi. Bir buton olustururuz ve ona tiklaninca bu degeri 1 yapar

while ~FinishSimulation

    Operator2AlphaMesage = Operator2AlphaCommunication(); % Alpha operatorden emirleri alir, burada bi ui tasarlariz ve kullanici bazi butonlarla vs emir verebilir
    
    NextPositions = CalculateNextPositions(Operator2AlphaMesage); % Bu islem alpha iha'nin icinde gerceklesecek normalde. kendisinin ve betalarin deltaT kadar sure sonra gitmelerin gereken yeri hesaplar. Waypoint hesaplama fonksiyonunu da bunun icinde cagiririz

    Alpha2Beta1TransmittedMessage = AlphaSendMessageToBeta(BetaUAV1); % Alpha'dan betalara giden emirler, bu fonksiyonlar gercekte alpha icinde kosturulacak
    Alpha2Beta2TransmittedMessage = AlphaSendMessageToBeta(BetaUAV2);
    Alpha2Beta3TransmittedMessage = AlphaSendMessageToBeta(BetaUAV3);
    Alpha2Beta4TransmittedMessage = AlphaSendMessageToBeta(BetaUAV4);

    Alpha2Beta1ReceivedMessage = DecodeReceivedMessage(Alpha2Beta1TransmittedMessage); % Receive kismi, bu fonksiyonlar gercekte beta icinde kosturulacak. Bu yuzden transmit kismindan ayiriyoruz
    Alpha2Beta2ReceivedMessage = DecodeReceivedMessage(Alpha2Beta2TransmittedMessage);
    Alpha2Beta3ReceivedMessage = DecodeReceivedMessage(Alpha2Beta3TransmittedMessage);
    Alpha2Beta4ReceivedMessage = DecodeReceivedMessage(Alpha2Beta4TransmittedMessage);

    % NOT: Communication fonksiyonlarini tek fonksiyon seklinde yazmistim
    % once. Daha sonra ise transmit ve receive seklinde ikiye ayrilmasi
    % gerektigini fark ettim. Bastaki ve asagidaki communication
    % kisimlarini da bu sekilde guncellemek lazim ama su an buna usendim.

    AlphaControlParameters = Control(AlphaUAV.Positions(:,end), NextPositions.AlphaPosition); % kontrol kismi, buraya motor gucu, itki kuvveti vs hesaplayan bi kod bulup koyariz

    Beta1ControlParameters = Control(BetaUAV1.Positions(:,end), NextPositions.Beta1Position);
    Beta2ControlParameters = Control(BetaUAV2.Positions(:,end), NextPositions.Beta2Position);
    Beta3ControlParameters = Control(BetaUAV3.Positions(:,end), NextPositions.Beta3Position);
    Beta4ControlParameters = Control(BetaUAV4.Positions(:,end), NextPositions.Beta4Position);

    pause(deltaT); % Aradan deltaT kadar zaman gecer ve artik ihalar gitmeleri gereken yere gitmislerdir

    AlphaUAV.Positions(:,end+1) = NextPositions.AlphaPosition;
    BetaUAV1.Positions(:,end+1) = NextPositions.Beta1Position;
    BetaUAV2.Positions(:,end+1) = NextPositions.Beta2Position;
    BetaUAV3.Positions(:,end+1) = NextPositions.Beta3Position;
    BetaUAV4.Positions(:,end+1) = NextPositions.Beta4Position;

    % BetaUAVlarin bulundugu durum (pozisyon, sicaklik, hiz vs) ile alakali Alpha'ya gonderigi mesajlar
    Beta12AlphaMessage = Beta2AlphaCommunication(BetaUAV1);
    Beta22AlphaMessage = Beta2AlphaCommunication(BetaUAV2);
    Beta32AlphaMessage = Beta2AlphaCommunication(BetaUAV3);
    Beta42AlphaMessage = Beta2AlphaCommunication(BetaUAV4);

    % Alpha'nin hem kendi hem de betalarin durumlarini operatore bildirdigi fonksiyon
    Alpha2OperatorMessage = Alpha2OperatorCommunication(AlphaUAV, BetaUAV1, BetaUAV2, BetaUAV3, BetaUAV4);

    % Operator'un yani user'in gordugu text'leri guncelleriz
    UpdateOperatorUAV(Alpha2OperatorMessage);

    % Bi haritalandirma vs yapmayi becerebilirsek yeni konumlarina
    % geldikleri icin haritayi da guncelleyip simulasyonu bitiririz.
    UpdateMap(); % Icine uavlarin konumu, ui text'leri vs bircok input alabilir. Simdilik bos biraktim.
end


