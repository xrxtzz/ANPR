function output = CalcRotate(inputImage)
   testImage = rgb2gray(inputImage);
   testEdge = edge(testImage,'sobel');
   [H, theta, rho]= hough(testEdge,'RhoResolution', 0.5);    
   %imshow(theta,rho,H,[],'notruesize'),axis on,axis normal    
   %xlabel('\theta'),ylabel('rho');       
   peak=houghpeaks(H,5);    
   lines=houghlines(testEdge,theta,rho,peak); 
   alpha = 0;
   i=0;
   for k=1:length(lines) 
        xy=[lines(k).point1;lines(k).point2]; 
        if xy(1,1)>xy(2,1) || xy(1,1)<xy(2,1) 
            if (xy(1,2)-xy(2,2))/(xy(1,1)-xy(2,1))<5 
                alpha = (xy(1,2)-xy(2,2))/(xy(1,1)-xy(2,1));
                i = i+1;
            end
        end
   end
   output = alpha/i;