%% Q1_part1_a
%% SampleRate 40   level 0.2
clear all; close all; clc;
 
rbImage = im2double(imread('icon_back.png'));
[h, w, ~] = size(rbImage);
imshow(rbImage);
 
%% Mouse input
sample_point = 39;
xlabel ('Select at most 39 points along the outline', 'FontName', '微軟正黑體', 'FontSize', 14);
[ ctrlPointX, ctrlPointY ] = ginput(sample_point);
ctrlPointList = [ctrlPointX ctrlPointY];
clickedN = size(ctrlPointList,1);
 
promptStr = sprintf('%d points selected', clickedN);
xlabel (promptStr, 'FontName', '微軟正黑體', 'FontSize', 14);
 
%% Calculate Bazier Curve (Your efforts here)
level = 0.2;
outlineVertexList = BZC(sample_point,level,ctrlPointList);
 
%% Draw and fill the polygon  Last 3 input arguments: (ctrlPointScattered, polygonPlotted, filled)
 
result_low_low = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList, true, true, true );
imwrite(result_low_low, 'result_40_02.png');

%% SampleRate 40   level 0.01
level = 0.01;
outlineVertexList = BZC(sample_point,level,ctrlPointList);

%% Draw and fill the polygon  Last 3 input arguments: (ctrlPointScattered, polygonPlotted, filled)
result_low_high = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList, true, true, true );
imwrite(result_low_high, 'result_40_001.png');


%% SampleRate 100   level 0.2
%clear all; close all; clc;
 
rbImage = im2double(imread('icon_back.png'));
[h, w, ~] = size(rbImage);
imshow(rbImage);
 
%% Mouse input
sample_point = 99;
xlabel ('Select at most 99 points along the outline', 'FontName', '微軟正黑體', 'FontSize', 14);
[ ctrlPointX, ctrlPointY ] = ginput(sample_point);
ctrlPointList = [ctrlPointX ctrlPointY];
clickedN = size(ctrlPointList,1);
 
promptStr = sprintf('%d points selected', clickedN);
xlabel (promptStr, 'FontName', '微軟正黑體', 'FontSize', 14);
 
%% Calculate Bazier Curve (Your efforts here)
level = 0.2;
outlineVertexList = BZC(sample_point,level,ctrlPointList);
 
%% Draw and fill the polygon  Last 3 input arguments: (ctrlPointScattered, polygonPlotted, filled)
 
result_high_low = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList, true, true, true );
imwrite(result_high_low, 'result_100_02.png');

%% SampleRate 100   level 0.01
level = 0.01;
outlineVertexList = BZC(sample_point,level,ctrlPointList);

%% Draw and fill the polygon  Last 3 input arguments: (ctrlPointScattered, polygonPlotted, filled)
 
result_high_high = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList, true, true, true );
imwrite(result_high_high, 'result_100_001.png');

%% Show image 
r = imread('result_40_02.png');
figure;
imshow(r);
title('samplerate = 40 LoD = 0.2');

r = imread('result_40_001.png');
figure;
imshow(r);
title('samplerate = 40 LoD = 0.01');

r = imread('result_100_02.png');
figure;
imshow(r);
title('samplerate = 100 LoD = 0.2');

r = imread('result_100_001.png');
figure;
imshow(r);
title('samplerate = 100 LoD = 0.01');

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
figure;
result_4X = drawAndFillPolygon( rbImage_4X, ctrlPointList, outlineVertexList, true, true, true );
imwrite(result_4X, 'result4X_CP.png');
