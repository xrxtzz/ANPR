function output = numberPlateRecognition(inputImage)
%in this function, you should finish the automatic Number Plate Recognition.
%the input parameter is a matrix of a color image.
%the output parameter is the number of license plate.
%you can use different methods to complete the task, however you should never change the parameter structure.
%better final result will get higher scores.
%we provide 2 character templates in the asset directory, you can also use other template.
    I = rgb2gray(inputImage);
    %figure,imshow(I);
    imgEdge = edge(I,'sobel');
    %imgEdge = edge(I,'canny',[0.01,0.17],2);
    %imgEdge = edge(I,'log'); 
    [height,length] = size(imgEdge);
    output =  '';
    %figure,imshow(imgEdge);
    aaa = zeros(length,1);
    for i=1:length
        aaa(i) = sum(imgEdge(:,i));
    end
    %figure,plot(1:length,aaa);
    
    lmax=0;
    li=0;
    T=0.1;
    for i=round(T*length):round((0.5-T)*length)
        if aaa(i)>lmax 
            lmax = aaa(i);
            li = i;
        end
    end
    rmax=0;
    ri=0;
    for i=round(length*(T+0.5)):round(length*(1-T))
        if aaa(i)>rmax
            rmax = aaa(i);
            ri = i;
        end
    end
    imgNew = imgEdge(:,li:ri);
    %figure,imshow(imgNew);
    

    
    bbb = zeros(height,1);
    for i=1:height
        bbb(i) = sum(imgNew(i,:));
    end
    %figure,plot(1:height,bbb);
    umax = 0;
    ui = 0;
    for i=round(T*height):round((0.5-T)*height)
        if bbb(i)>umax 
            umax = bbb(i);
            ui = i;
        end
    end
    dmax=0;
    di=0;
    for i=round(height*(T+0.5)):round(height*(1-T))
        if bbb(i)>dmax
            dmax = bbb(i);
            di = i;
        end
    end
    
    imgNN = I(ui:di,li:ri);
    %figure,imshow(imgNN);
    [nh,nl] = size(imgNN);
    img = zeros(nh,nl);
    aver = 0.8*sum(sum(imgNN(:,:)))/(nl*nh);
    for i=1:nh
        for j=1:nl
            if imgNN(i,j)<aver 
                img(i,j)=0;
            else
                img(i,j)=1;
            end
        end
    end
    img = imopen(img,ones(round(nh/50),round(nl/50)));
    %figure,imshow(img);
    

    bb = zeros(nh,1);
    for i=1:nh
        bb(i) = sum(img(i,:));
    end
    mmax = max(bb(:));
    ui = 0;
    di = nh;
    for i=1:round(0.5*nh)
        if (bb(i)>0.9*mmax)&&(i>ui)
            ui = i;
        end
    end
    for i=round(0.5*nh):nh
        if (bb(i)>0.9*mmax)&&(i<di)
            di = i;
        end
    end
    img = img(ui:di,:);
    %figure,imshow(img);
    %output = inputImage;
    ave = sum(sum(img(:,:)))/nl;
    
    [nh,nl] = size(img);
    aa = zeros(nl,1);
    for i=1:nl 
        aa(i) = sum(img(:,i));
    end
    mmax = max(aa(:));
    
    %figure,plot(1:nl,aa);
    %hold on
    %plot(1:nl,ave);
    
    i=1;
    while (i<nl)
        %Select separate characters
        while (aa(i)>=0.95*mmax)&&(i<nl)
            i=i+1;
        end
        lj = i;
        while (aa(i)<0.95*mmax)&&(i<nl)
            i=i+1;
        end
        rj = i;
        imgTemp = img(:,lj:rj);
        %Enhance separate characters
        bbTemp = zeros(nh,1);
        for j=1:nh
            bbTemp(j) = sum(imgTemp(j,:));
        end
        nmax = max(bbTemp(:));
        uj = 1;
        dj = nh;
        for j=1:round(0.5*nh)
            if (bbTemp(j)>0.95*nmax)&&(j>uj)
                uj = j;
            end
        end
        for j=round(0.5*nh):nh
            if (bbTemp(j)>0.95*nmax)&&(j<dj)
                dj = j;
            end
        end
        %imgTemp = imgTemp(uj:dj,:);
        
        %recognize separate characters
        if (dj-uj>1*(rj-lj)) && (dj-uj<(rj-lj)*4)
            %figure,imshow(imgTemp);
            text = recognize(imgTemp);
            output = [output,text]; 
        end     
        %output = output+txt.text;
    end
    output
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    