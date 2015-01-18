clc,close    
BW=imread('../assets/car6.jpg');  
    
BW=rgb2gray(BW);    
thresh=[0.01,0.17];    
sigma=2;%定义高斯参数    
f = edge(double(BW),'canny',thresh,sigma);    
figure(1),imshow(f,[]);    
title('canny 边缘检测');    
    
[H, theta, rho]= hough(f,'RhoResolution', 0.5);    
%imshow(theta,rho,H,[],'notruesize'),axis on,axis normal    
%xlabel('\theta'),ylabel('rho');    
    
peak=houghpeaks(H,5);    
hold on    
    
lines=houghlines(f,theta,rho,peak);    
figure,imshow(f,[]),title('Hough Transform Detect Result'),hold on    
for k=1:length(lines)    
    xy=[lines(k).point1;lines(k).point2];    
    plot(xy(:,1),xy(:,2),'LineWidth',4,'Color',[.6 .6 .6]);    
end    