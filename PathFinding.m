function[Waypoints] = PathFinding(StartPoint, EndPoint, DangerZoneCenter, DangerZoneRadius)
% This function enables a UAV traveling from point A to point B to reach
% its target without getting stuck in a danger zone.
% ------------------------- Inputs ---------------------------------
% StartPoint: Starting Point of the Path. 3x1 vector containing [x;y;z]
% positions. All of them are in meters.
% EndPoint: Ending Point of the Path. 3x1 vector containing [x;y;z]
% positions. All of them are in meters.
% DangerZoneCenter: Center position of the Danger Zone which is modeled as
% a sphere. 3x1 vector containing [x;y;z] positions. All of them are in
% meters.
% DangerZoneRadius: Radius of the Danger Zone which is modeled as a sphere.
% A float containing the radius in meters.
% -------------------------------------------------------------------
% ------------------------- Outputs ---------------------------------
% Waypoints: Cartesian positions of the waypoints generated. 3xN Matrix
% where each column contaions [x;y;z] positions of a waypoint. N is the
% total number of the waypoints. All the entries are in meters.
% -------------------------------------------------------------------
% Muhammed Emir Yagmur 24.02.2026

if norm(StartPoint - DangerZoneCenter) < DangerZoneRadius
    % If the distance between the StartPoint and the Danger Zone Center is
    % smaller than the radius; then, the Danger Zone is defined around the
    % vehicle.
    % TODO: Bu durumda en yakin yuzeye gitmeli. Sonra da Danger Zonedan
    % cikacak sekilde hareket etmeli. Simdilik boyle biraktim
    fprintf("Warning: !!Drone is inside the Danger Zone!!");
    Waypoints = EndPoint;
    return
end


DZCorner(:,1) = [DangerZoneCenter(1)+DangerZoneRadius; DangerZoneCenter(2)+DangerZoneRadius; DangerZoneCenter(3)+DangerZoneRadius];
DZCorner(:,2) = [DangerZoneCenter(1)+DangerZoneRadius; DangerZoneCenter(2)+DangerZoneRadius; DangerZoneCenter(3)-DangerZoneRadius];
DZCorner(:,3) = [DangerZoneCenter(1)+DangerZoneRadius; DangerZoneCenter(2)-DangerZoneRadius; DangerZoneCenter(3)+DangerZoneRadius];
DZCorner(:,4) = [DangerZoneCenter(1)+DangerZoneRadius; DangerZoneCenter(2)-DangerZoneRadius; DangerZoneCenter(3)-DangerZoneRadius];
DZCorner(:,5) = [DangerZoneCenter(1)-DangerZoneRadius; DangerZoneCenter(2)+DangerZoneRadius; DangerZoneCenter(3)+DangerZoneRadius];
DZCorner(:,6) = [DangerZoneCenter(1)-DangerZoneRadius; DangerZoneCenter(2)+DangerZoneRadius; DangerZoneCenter(3)-DangerZoneRadius];
DZCorner(:,7) = [DangerZoneCenter(1)-DangerZoneRadius; DangerZoneCenter(2)-DangerZoneRadius; DangerZoneCenter(3)+DangerZoneRadius];
DZCorner(:,8) = [DangerZoneCenter(1)-DangerZoneRadius; DangerZoneCenter(2)-DangerZoneRadius; DangerZoneCenter(3)-DangerZoneRadius];

% The distances from the StartPoint to each corner is measured.
Dist_Start2Corner(1) = norm(StartPoint - DZCorner(:,1));
Dist_Start2Corner(2) = norm(StartPoint - DZCorner(:,2));
Dist_Start2Corner(3) = norm(StartPoint - DZCorner(:,3));
Dist_Start2Corner(4) = norm(StartPoint - DZCorner(:,4));
Dist_Start2Corner(5) = norm(StartPoint - DZCorner(:,5));
Dist_Start2Corner(6) = norm(StartPoint - DZCorner(:,6));
Dist_Start2Corner(7) = norm(StartPoint - DZCorner(:,7));
Dist_Start2Corner(8) = norm(StartPoint - DZCorner(:,8));


% The equation of a line between the starting and ending points
LineEq_a = EndPoint(1)-StartPoint(1);
LineEq_b = EndPoint(2)-StartPoint(2);
LineEq_c = EndPoint(3)-StartPoint(3);


% Plane equation
[~, idx] = sort(Dist_Start2Corner);

ClosestPoints2Start(:,1) = DZCorner(:, idx(1));
ClosestPoints2Start(:,2) = DZCorner(:, idx(2));
ClosestPoints2Start(:,3) = DZCorner(:, idx(3));
ClosestPoints2Start(:,4) = DZCorner(:, idx(4));

PlaneEq_Vector1 = ClosestPoints2Start(:,2) - ClosestPoints2Start(:,1);
PlaneEq_Vector2 = ClosestPoints2Start(:,3) - ClosestPoints2Start(:,1);
PlaneEq_VerticalVector = cross(PlaneEq_Vector1,PlaneEq_Vector2);

% TODO: Bu 3 variable'in ismini mantikli seylerle degistir veya aciklama
% yazip ne anlama geldiklerini anlat
x3 = ClosestPoints2Start(1,1);
y3 = ClosestPoints2Start(2,1);
z3 = ClosestPoints2Start(3,1);

% TODO: Bu 3 variable'in ismini mantikli seylerle degistir veya aciklama
% yazip ne anlama geldiklerini anlat
x6 = PlaneEq_VerticalVector(1);
y6 = PlaneEq_VerticalVector(2);
z6 = PlaneEq_VerticalVector(3);

D = -(x6 * x3 + y6 * y3 + z6 * z3); % TODO: Bu D ismini mantikli seylerle degistir veya aciklama yazip ne anlama geldigini anlat

% Intersection of the plane and the line
tConstant = x6*LineEq_a + y6*LineEq_b + z6*LineEq_c; % TODO: Bu tConstant ismini mantikli seylerle degistir veya aciklama yazip ne anlama geldigini anlat
constant = -(x6*StartPoint(1) + y6*StartPoint(2) + z6*StartPoint(3) + D); % TODO: Bu constant ismini mantikli seylerle degistir veya aciklama yazip ne anlama geldigini anlat

if tConstant~= 0
    t = constant / tConstant; % TODO: Bu t ismini mantikli seylerle degistir
    IntersectionX = StartPoint(1) + LineEq_a*t;
    IntersectionY = StartPoint(2) + LineEq_b*t;
    IntersectionZ = StartPoint(3) + LineEq_c*t;
    IntersectionPoint = [IntersectionX; IntersectionY; IntersectionZ];
else
    IntersectionPoint = [];
end

% If IntersectionPoint is empty, then either the danger zone is outside the
% StartPoint-EndPoint line, or one of the sides of the danger zone
% coincides with the StartPoint-EndPoint line. Then, Output is just
% EndPoint.
if isempty(IntersectionPoint) 
    Waypoints = EndPoint;
elseif norm(StartPoint-EndPoint) < norm(IntersectionPoint-EndPoint)
    % If StartPoint is closer to EndPoint than the IntersectionPoint, than
    % the danger zone is outside the StartPoint-EndPoint line. Then, Output
    % is just EndPoint.
    Waypoints = EndPoint;

elseif norm(StartPoint-EndPoint) < norm(IntersectionPoint-StartPoint)
    % If EndPoint is closer to StartPoint than the IntersectionPoint, than
    % the danger zone is outside the StartPoint-EndPoint line. Then, Output
    % is just EndPoint.
    Waypoints = EndPoint;

elseif IsPointInsideTheCube(IntersectionPoint, DZCorner) ~= 1
    % If the IntersectionPoint is outside of the Danger Zone and the output
    % is just the EndPoint
    Waypoints = EndPoint;

else
    % If any of the conditions above does not hold; then, the Danger Zone
    % is on the StartPoint-EndPoint line. Then, all the waypoints should be
    % calculated around the Danger Zone Cube.
    Waypoints = IntersectionPoint; % The first waypoint

    % Finding the nearest edge from the intersection point
    DistanceIntersection2ClosestCorners(1) = norm(IntersectionPoint - ClosestPoints2Start(:,1));
    DistanceIntersection2ClosestCorners(2) = norm(IntersectionPoint - ClosestPoints2Start(:,2));
    DistanceIntersection2ClosestCorners(3) = norm(IntersectionPoint - ClosestPoints2Start(:,3));
    DistanceIntersection2ClosestCorners(4) = norm(IntersectionPoint - ClosestPoints2Start(:,4));
    
    [~, idx] = sort(DistanceIntersection2ClosestCorners);

    ClosestPoints2Intersection(:,1) = ClosestPoints2Start(:, idx(1));
    ClosestPoints2Intersection(:,2) = ClosestPoints2Start(:, idx(2));

    % W is the vector from the point to the line which we want to project
    % the point onto. V is the vector between two points on the line.
    W = IntersectionPoint - ClosestPoints2Intersection(:,1);
    V = ClosestPoints2Intersection(:,2) - ClosestPoints2Intersection(:,1);
    ProjectedPoint = (dot(W,V) / dot(V,V))*V + ClosestPoints2Intersection(:,1);

    Waypoints(:,end+1) = ProjectedPoint;
    
    
    % Progress on the surface
    if IsPointInsideTheCube(ProjectedPoint + [2*DangerZoneRadius;0;0], DZCorner) > 0
        Waypoints(:,end+1) = ProjectedPoint + [2*DangerZoneRadius;0;0];
    elseif IsPointInsideTheCube(ProjectedPoint - [2*DangerZoneRadius;0;0], DZCorner) > 0
        Waypoints(:,end+1) = ProjectedPoint - [2*DangerZoneRadius;0;0];
    elseif IsPointInsideTheCube(ProjectedPoint + [0;2*DangerZoneRadius;0], DZCorner) > 0
        Waypoints(:,end+1) = ProjectedPoint + [0;2*DangerZoneRadius;0];
    elseif IsPointInsideTheCube(ProjectedPoint - [0;2*DangerZoneRadius;0], DZCorner) > 0
        Waypoints(:,end+1) = ProjectedPoint - [0;2*DangerZoneRadius;0];
    elseif IsPointInsideTheCube(ProjectedPoint + [0;0;2*DangerZoneRadius], DZCorner) > 0
        Waypoints(:,end+1) = ProjectedPoint + [0;0;2*DangerZoneRadius];
    elseif IsPointInsideTheCube(ProjectedPoint - [0;0;2*DangerZoneRadius], DZCorner) > 0
        Waypoints(:,end+1) = ProjectedPoint - [0;0;2*DangerZoneRadius];
    end
    
    % from danger zone to end point
    Waypoints(:,end+1) = EndPoint;

end


end