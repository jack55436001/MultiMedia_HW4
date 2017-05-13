clear all
close all
%% fscanf the obj file at 3D figure
al = fopen('al7KC.obj');

vertex_al = fscanf(al,'v %f %f %f %f %f %f\n',[6, Inf])';
faces_al = fscanf(al,'f %f %f %f\n',[3, Inf])';

fclose(al);


%% Q2_c( Adding the HSV color cylinder onto the same world space as al7KC.obj, and then do some transformation)

%% Put HSV color cylinder
%% Define Vertices
NumOfVert = 108;   %divide by 6 for color fill
vertsPolarAngle = linspace(0,2*pi,NumOfVert+1);
vertsX = cos(vertsPolarAngle);
vertsY = sin(vertsPolarAngle);
topVerts = zeros(NumOfVert+1,3);
botVerts = zeros(NumOfVert+1,3);
topVertIndex = zeros(NumOfVert+1,1);
botVertIndex = zeros(NumOfVert+1,1);
for i=1:NumOfVert
    topVerts(i,:) = [vertsX(i) vertsY(i)+2.5 0.5-2.5];  %move (0,2.5,-2.5)
    botVerts(i,:) = [vertsX(i) vertsY(i)+2.5 -0.5-2.5]; %move (0,2.5,-2.5)
end
topVerts(NumOfVert+1,:) = [0 0+2.5 0.5-2.5];    %move (0,2.5,-2.5)
botVerts(NumOfVert+1,:) = [0 0+2.5 -0.5-2.5];   %move (0,2.5,-2.5)

index = 1;
for i=1:NumOfVert+1
    topVertIndex(i) = index;
    index = index + 1;
end
for i=1:NumOfVert+1
    botVertIndex(i) = index;
    index = index + 1;
end

verts = [ topVerts; botVerts ];

%% Define Colors

vertColor = zeros(2*(NumOfVert+1),3);
slice0to1 = linspace(0,1,NumOfVert/6);
slice1to0 = linspace(1,0,NumOfVert/6);
allzero = zeros(NumOfVert/6,1);
allone = ones(NumOfVert/6,1);

vertColor(1:NumOfVert/6,1) =allone;
vertColor(1:NumOfVert/6,2) =slice0to1;
vertColor(1:NumOfVert/6,3) =allzero;

vertColor(NumOfVert/6+1:2*NumOfVert/6,1) =slice1to0;
vertColor(NumOfVert/6+1:2*NumOfVert/6,2) =allone;
vertColor(NumOfVert/6+1:2*NumOfVert/6,3) =allzero;

vertColor(2*NumOfVert/6+1:3*NumOfVert/6,1) =allzero;
vertColor(2*NumOfVert/6+1:3*NumOfVert/6,2) =allone;
vertColor(2*NumOfVert/6+1:3*NumOfVert/6,3) =slice0to1;

vertColor(3*NumOfVert/6+1:4*NumOfVert/6,1) =allzero;
vertColor(3*NumOfVert/6+1:4*NumOfVert/6,2) =slice1to0;
vertColor(3*NumOfVert/6+1:4*NumOfVert/6,3) =allone;

vertColor(4*NumOfVert/6+1:5*NumOfVert/6,1) =slice0to1;
vertColor(4*NumOfVert/6+1:5*NumOfVert/6,2) =allzero;
vertColor(4*NumOfVert/6+1:5*NumOfVert/6,3) =allone;

vertColor(5*NumOfVert/6+1:6*NumOfVert/6,1) =allone;
vertColor(5*NumOfVert/6+1:6*NumOfVert/6,2) =allzero;
vertColor(5*NumOfVert/6+1:6*NumOfVert/6,3) =slice1to0;

vertColor(NumOfVert+1,:) = [1,1,1];

for i = NumOfVert+2:2*(NumOfVert+1)
    vertColor(i,:) = [0,0,0];
end

%% Empty faces list
faces = [];

%% Top faces
for i=1:NumOfVert
   if(i==NumOfVert)
       faces = [faces;topVertIndex(i) topVertIndex(NumOfVert+1) topVertIndex(1)]; 
   else
       faces = [faces;topVertIndex(i) topVertIndex(NumOfVert+1) topVertIndex(i+1)]; 
   end
end

%% Side faces (Your efforts here)
for i=1:NumOfVert
   if(i==NumOfVert)
       faces = [faces;topVertIndex(i) botVertIndex(1) topVertIndex(1)]; 
   else
       faces = [faces;topVertIndex(i) botVertIndex(i+1) topVertIndex(i+1)]; 
   end
end

for i=1:NumOfVert
   if(i==NumOfVert)
       faces = [faces;botVertIndex(i) topVertIndex(i) botVertIndex(1)];
   else
       faces = [faces;botVertIndex(i) topVertIndex(i) botVertIndex(i+1)]; 
   end
end
%% Bottom faces
for i=1:NumOfVert
   if(i==NumOfVert)
       faces = [faces;botVertIndex(i) botVertIndex(NumOfVert+1) botVertIndex(1)]; 
   else
       faces = [faces;botVertIndex(i) botVertIndex(NumOfVert+1) botVertIndex(i+1)]; 
   end 
end

%% Adjust al7KC.obj 
vertex = vertex_al(:,1:3);

max_x = max(vertex(:,1));
min_x = min(vertex(:,1));
x_move = (max_x + min_x)/2;

max_y = max(vertex(:,2));
min_y = min(vertex(:,2));
y_move = (max_y + min_y)/2;

max_z = max(vertex(:,3));
min_z = min(vertex(:,3));
z_move = (max_z + min_z)/2;

vertex (:,1) = vertex (:,1) - x_move;
vertex (:,2) = vertex (:,2) - y_move;
vertex (:,3) = vertex (:,3) - z_move;
%% Combine two object and show result
outfaces = faces_al;
colors = vertex_al(:,4:6);
vertex = [vertex;verts];
outfaces = [outfaces;faces+3618]; %adjust index
colors = [colors;vertColor];
result = trisurf(outfaces,vertex(:,1),vertex(:,2),vertex(:,3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0);
saveas(result,'Q2_c.fig');

%% Lighting (You may need to modify the lighting here)
%% Q2_d
figure
trisurf(outfaces,vertex(:,1),vertex(:,2),vertex(:,3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0);
title('Position Light');
light('Position',[0.0,0.0,5.0],'Style','local');
lighting phong;

figure
trisurf(outfaces,vertex(:,1),vertex(:,2),vertex(:,3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0);
title('Directional Light');
light('Position',[0.0,0.0,5.0],'Style','infinite');
lighting phong;
%% Q2_e
figure
trisurf(outfaces,vertex(:,1),vertex(:,2),vertex(:,3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0);
title('Ka = 1.0 Kd = 0.0 Ks = 0.0');
light('Position',[0.0,0.0,5.0]);
material([1.0,0.0,0.0]);
lighting phong;

figure
trisurf(outfaces,vertex(:,1),vertex(:,2),vertex(:,3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0);
title('Ka = 0.1 Kd = 1.0 Ks = 0.0');
light('Position',[0.0,0.0,5.0]);
material([0.1,1.0,0.0]);
lighting phong;

figure
trisurf(outfaces,vertex(:,1),vertex(:,2),vertex(:,3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0);
title('Ka = 0.1 Kd = 0.1 Ks = 1.0');
light('Position',[0.0,0.0,5.0]);
material([0.1,0.1,1.0]);
lighting phong;

figure
trisurf(outfaces,vertex(:,1),vertex(:,2),vertex(:,3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0);
title('Ka = 0.1 Kd = 0.8 Ks = 1.0');
light('Position',[0.0,0.0,5.0]);
material([0.1,0.8,1.0]);
lighting phong;