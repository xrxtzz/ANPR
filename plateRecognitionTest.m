%DIP14 Assignment 3 number plate recognition.
%In this assignment, you should build your own number plate recognition method.
%We supply 10 images for you to test and reserve 10 images.
%Your method's final accuracy will be judged by 20 images.
clc; clear all;

%test image label, cell.
trueNumber = textread('../assets/label.txt', '%s');
numImages = length(trueNumber);
acc = zeros(numImages,1);
for i = 1:numImages
    %test car image.
    imgName = ['../assets/car', num2str(i), '.jpg'];
	imgTest = imread(imgName);
	label = trueNumber{i};
	pred = numberPlateRecognition(imgTest);
	%For each test car, the edit distance between your prediction and 
	%true label divided by the length is the error.
	acc(i) = 1 - min(1, editDistance(label, pred)/length(label));
end
res = mean(acc);
disp(res);

