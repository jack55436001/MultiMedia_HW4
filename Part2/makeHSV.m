clear all; close all; clc;

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
    topVerts(i,:) = [vertsX(i) vertsY(i) 0.5];
    botVerts(i,:) = [vertsX(i) vertsY(i) -0.5];
end
topVerts(NumOfVert+1,:) = [0 0 0.5];
botVerts(NumOfVert+1,:) = [0 0 -0.5];

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

%% Show HSV cylinder in 3D figure
result = trisurf(faces,verts(:,1),verts(:,2),verts(:,3),'FaceVertexCData', vertColor,'FaceColor','interp', 'EdgeAlpha', 0);
