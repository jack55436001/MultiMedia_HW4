%% Q1_part1_a
%% SampleRate 40    level 0.2
clear all; close all; clc;

rbImage = im2double(imread('icon_back.png'));
[h, w, ~] = size(rbImage);
imshow(rbImage);

%% Mouse input
sample_point = 39;
xlabel ('Select at most 40 points along the outline', 'FontName', '微軟正黑體', 'FontSize', 14);
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

figure; result_low_low = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList, true, true, true );
imwrite(result_low_low, 'result_40_02.png');

%% SampleRate 100   level 0.2
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
 
level = 0.2;
outlineVertexList = BZC(sample_point,level,ctrlPointList);
 
%% Draw and fill the polygon  Last 3 input arguments: (ctrlPointScattered, polygonPlotted, filled)
 
figure; result_high_low = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList, true, true, true );
imwrite(result_high_low, 'result_100_02.png');

%% SampleRate 40   level 0.01
clear all; close all; clc;
 
rbImage = im2double(imread('icon_back.png'));
[h, w, ~] = size(rbImage);
imshow(rbImage);
 
%% Mouse input
sample_point = 39;
xlabel ('Select at most 40 points along the outline', 'FontName', '微軟正黑體', 'FontSize', 14);
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
 
figure; result_low_high = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList, true, true, true );
imwrite(result_low_high, 'result_40_001.png');

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
