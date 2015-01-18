clc; clear all;

Origin = imread('../assets/car7.jpg');
%figure,imshow(imrotate(Origin,CalcRotate(Origin)));
I = numberPlateRecognition(imrotate(Origin,CalcRotate(Origin)));
%figure,imshow(I);