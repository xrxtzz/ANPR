function output = recognize(inputImage)
    %for nonfilled ones
    character = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
    mmax = 0;
    result = '';
    for i=1:36
        now = character(i);
        imgName = ['..\assets\character_templates_2\',now,'.bmp'];
        Temp = imread(imgName);
        img = imresize(inputImage,size(Temp));
        [h,l] = size(img);
        imgNew = zeros(h,l);
        for p=1:h
            for q=1:l
                if (img(p,q)==Temp(p,q)) imgNew(p,q) = 0;
                else imgNew(p,q) = 1;
                end
            end
        end
        ssum = sum(sum(imgNew(:,:)));
        if (ssum>mmax)&&(ssum>h*l*0.8)
            result = now;
            mmax = ssum;
        end
        %figure,imshow(imgNew);
    end
    %for filled ones
    character2 = ['0','4','6','8','9','A','B','D','O','P','Q','R'];
    for i=1:12
        now = character2(i);
        imgName = ['..\assets\character_templates_2\fill',now,'.bmp'];
        Temp = imread(imgName);
        img = imresize(inputImage,size(Temp));
        %imgNew = bitxor(img,Temp);
        [h,l] = size(img);
        imgNew = zeros(h,l);
        for p=1:h
            for q=1:l
                if (img(p,q)==Temp(p,q)) imgNew(p,q) = 0;
                else imgNew(p,q) = 1;
                end
            end
        end
        ssum = sum(sum(imgNew(:,:)));
        if (ssum>mmax)&&(ssum>h*l*0.8)
            result = now;
            mmax = ssum;
        end
    end
    %another filled ones
    character3 = ['6','9'];
    for i=1:2
        now = character3(i);
        imgName = ['..\assets\character_templates_2\fill',now,'_2.bmp'];
        Temp = imread(imgName);
        img = imresize(inputImage,size(Temp));
        [h,l] = size(img);
        imgNew = zeros(h,l);
        %imgNew = bitxor(img,Temp);
        for p=1:h
            for q=1:l
                if (img(p,q)==Temp(p,q)) imgNew(p,q) = 0;
                else imgNew(p,q) = 1;
                end
            end
        end
        ssum = sum(sum(imgNew(:,:)));
        if (ssum>mmax)&&(ssum>h*l*0.8)
            result = now;
            mmax = ssum;
        end
    end
    output = result;
        