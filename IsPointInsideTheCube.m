function [IsInside] = IsPointInsideTheCube(Point, CubeCorners)
% Inputs: Point 3x1 position vector, all are in meters
% CubeCorner: 3x8 matrix containing corners of the cube. The order of the
% corners does not matter. All position and in meters.
% IsInside: 1 if the point is inside the cube, 0 if the point is outside
% the cube.
IsInside = 1;

[~, index_x] = sort(CubeCorners(1,:)); % Sorting the x points of the corners of the cube
[~, index_y] = sort(CubeCorners(2,:)); % Sorting the y points of the corners of the cube
[~, index_z] = sort(CubeCorners(3,:)); % Sorting the z points of the corners of the cube

minx = CubeCorners(1,index_x(1));
maxx = CubeCorners(1,index_x(end));

miny = CubeCorners(2,index_y(1));
maxy = CubeCorners(2,index_y(end));

minz = CubeCorners(3,index_z(1));
maxz = CubeCorners(3,index_z(end));

if (Point(1) - maxx) > 10^-6 || (minx - Point(1)) > 10^-6 || (Point(2) - maxy) > 10^-6 || (miny - Point(2)) > 10^-6 || (Point(3) - maxz) > 10^-6 || (minz - Point(3)) > 10^-6
    IsInside = 0;
end