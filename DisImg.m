function disImg = DisImg(Img, n)

    switch n
        %% Indivigle adjustments to images
    case 1  % Rotating Image
        r = randi([0 180],1,1);
        disImg = imrotate(Img,r); 
    case 2  % Black and White
        %r = randi([0 180],1,1);
        disImg = rgb2gray(Img); 
    case 3  % Shrink Image
        r  = randi([40 100],1,1);
        disImg = imresize(Img, [r NaN]);
    case 4  % Grow Image
        r  = randi([100 500],1,1);
        disImg = imresize(Img, [r NaN]);
    case 5  % Collor Distort/Darken
        r = randi([10 40],1,1)/100;
        b = randi([10 40],1,1)/100;
        g = randi([10 40],1,1)/100;
        disImg = imadjust(Img,[],[0 0 0; r b g]);  
    case 6
        r = randi([50 90],1,1)/100;
        b = randi([50 90],1,1)/100;
        g = randi([50 90],1,1)/100;
        disImg = imadjust(Img,[],[r b g; 1 1 1]); 
    case 7
        r = randi([50 100],1,1);
        avg3 = ones(r) / r^2;
        disImg = imfilter(Img, avg3, 'conv');
        rl = randi([0 3],1,1)/10;
        bl = randi([0 3],1,1)/10;
        gl = randi([0 3],1,1)/10;
        rh = randi([7 10],1,1)/10;
        bh = randi([7 10],1,1)/10;
        gh = randi([7 10],1,1)/10;
        disImg = imadjust(Img,[],[rl bl gl; rh bh gh]);
    otherwise   %Nothing happens
        disImg = Img; 
    end
    %% Adjustments to all images
    % Add a small rotatoin
    r = randi([-35 35],1,1);
    disImg = imrotate(disImg,r/10);
    if randi([0 1],1,1)== 1 %Flip half of images randomly
        disImg = imrotate(disImg,180);
    end
end

