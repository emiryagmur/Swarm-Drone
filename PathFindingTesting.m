close all
clear
clc
dbstop if error
CornerCoordinates = [3 3 3;
                     3 3 -3;
                     3 -3 3;
                     3 -3 -3;
                     -3 3 3;
                     -3 3 -3;
                     -3 -3 3;
                     -3 -3 -3];

CubeSurfaces = [1 2 6 5; 3 4 8 7; 1 3 4 2; 5 7 8 6; 1 3 7 5; 2 4 8 6]';

xc = CornerCoordinates(:,1);
yc = CornerCoordinates(:,2);
zc = CornerCoordinates(:,3);

StartPoint = [-3.4;0.27;-1.32];
EndPoint = [3.7;4.09;-4.5];
DangerZoneCenter = [0;0;0];
DangerZoneRadius = 3;

[Waypoints] = PathFinding(StartPoint, EndPoint, DangerZoneCenter, DangerZoneRadius);
Waypoints = [StartPoint, Waypoints];

patch(xc(CubeSurfaces), yc(CubeSurfaces), zc(CubeSurfaces), 'r', 'facealpha', '0.1');

for j = 1:size(Waypoints,2)-1
    patch([Waypoints(1,j) Waypoints(1,j+1)], [Waypoints(2,j) Waypoints(2,j+1)], [Waypoints(3,j) Waypoints(3,j+1)], 'b')
end

view(3)

% NOT: StartPoint = [-6;1;0] ve EndPoint = [6;1;0] iken Waypoints = [-6 -3 -3 3 6; 1 1 3 3 1; 0 0 0 0 0] olmali
% NOT: StartPoint = [-6;6;0] ve EndPoint = [6;6;0] iken Waypoints = [-6 6; 6 6; 0 0] olmali
% NOT: StartPoint = [0;0;0] ve EndPoint = [6;6;0] iken Waypoints = [0 6; 6 6; 0 0] olmali
% NOT: StartPoint = [5;5;5] ve EndPoint = [6;6;6] iken Waypoints = [5 6; 5 6; 5 6] olmali
% NOT: StartPoint = [-6;-1;2] ve EndPoint = [4;5;5] iken Waypoints = [-6 -3 -3 3 4; -1 0.8 0.8 0.8 5; 2 2.9 3 3 5] olmali
