%% SampleRate 100   level 0.01
clear all; close all; clc;
 
rbImage = im2double(imread('icon_back.png'));
[h, w, ~] = size(rbImage);
imshow(rbImage);
 
%% Mouse input
sample_point = 99;
xlabel ('Select at most 100 points along the outline', 'FontName', '微軟正黑體', 'FontSize', 14);
[ ctrlPointX, ctrlPointY ] = ginput(sample_point);
ctrlPointList = [ctrlPointX ctrlPointY];
clickedN = size(ctrlPointList,1);
 
promptStr = sprintf('%d points selected', clickedN);
xlabel (promptStr, 'FontName', '微軟正黑體', 'FontSize', 14);
 
%% Calculate Bazier Curve (Your efforts here)
%outlineVertexList = ctrlPointList; %Enrich outlineVertexList
 
level = 0.01;
outlineVertexList = BZC(sample_point,level,ctrlPointList);
 
%% Draw and fill the polygon  Last 3 input arguments: (ctrlPointScattered, polygonPlotted, filled)
 
figure; result_high_high = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList, true, true, true );
imwrite(result_high_high, 'result_100_001.png');

%% Q1_part1_b

%%  Nearest-neighbor interpolation

rbImage = im2double(imread('result_100_001.png'));
RGB = imresize(rbImage, 4, 'nearest');
imwrite(RGB,'result4X_NB.png');

%%  Scale the sampled control points by 4 times
sample_point = 99;
level = 0.01;
rbImage = im2double(imread('icon_back.png'));
rbImage_4X = imresize(rbImage, 4, 'nearest');
ctrlPointList = ctrlPointList*4;
outlineVertexList = BZC(sample_point,level,ctrlPointList);
figure; result_high_high = drawAndFillPolygon( rbImage_4X, ctrlPointList, outlineVertexList, true, true, true );
imwrite(result_high_high, 'result4X_CP.png');
