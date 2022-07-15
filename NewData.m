
%% NewData.m
%Abigail G Basener
%This code will take a portoin of the perfict master data putting it in a
%file named Data and will distort the same images(for training) and put
%them in a file named DisData

%% Set Up
% The derictery of the database of images, and file type
imgPath  = 'DataMaster\*.png';
% The number of images that you want to work with
N = 33081;
% number of sets of disorated data
M = 10;

%% Load Images
tic
imds = imageDatastore(imgPath);
imgs = readall(imds);
DataNames = vertcat(imds.Files);

%% Make perfict images(saved in Data)
%Gets name of orginal file name
newImgPath = extractBefore(imgPath,"*.png");
mkdir('Data')
for i = 1:N
    % Makes name for the image(corisponding with its orginal name)
    Token = extractAfter(DataNames(i),newImgPath);
    % Adds path to data file
    FNm = strcat('Data/', Token);
    Nm = strcat(FNm,"\Org.png");
    Nm = convertCharsToStrings(Nm);
    FNm = convertCharsToStrings(FNm);
    % Saves image
    mkdir(FNm);
    imwrite(imgs{i}, Nm);
end

%% Make distorted Images(Saved in DisData)
mkdir("DisData")
for i = 1:N
    % Makes name for the image(corisponding with its orginal name)
    % Get name of origanl image
    Token = extractAfter(DataNames(i),newImgPath);
    Token = extractBefore(Token,".png");
    % Make file with name of orgianl name
    FNm = strcat("DisData\", Token);
    FNm = convertCharsToStrings(FNm);
    mkdir(FNm);
            %Origanle Image
    Nm = strcat(FNm,"\Org.png");
    Nm = convertCharsToStrings(Nm);
    imwrite(imgs{i}, Nm);
    for j = 1:M %Saves M sets of the distorted images
        %Saves images with desired distortoins
            %Rotated Image
        Nm = strcat(FNm,"\", int2str(j),"Rot.png");
        Nm = convertCharsToStrings(Nm);
        imwrite(DisImg(imgs{i}, 1), Nm);
            %Black & White Image
        Nm = strcat(FNm,"\", int2str(j),"BW.png");
        Nm = convertCharsToStrings(Nm);
        imwrite(DisImg(imgs{i}, 2), Nm);
            % Shrink
        Nm = strcat(FNm,"\", int2str(j),"Shrink.png");
        Nm = convertCharsToStrings(Nm);
        imwrite(DisImg(imgs{i}, 3), Nm);
            % Grow
        Nm = strcat(FNm,"\", int2str(j),"Grow.png");
        Nm = convertCharsToStrings(Nm);
        imwrite(DisImg(imgs{i}, 4), Nm);
            % Collor Distort/Darken (twice)
        Nm = strcat(FNm, "\", int2str(j),"ColDisD1.png");
        Nm = convertCharsToStrings(Nm);
        imwrite(DisImg(imgs{i}, 5), Nm);
        Nm = strcat(FNm, "\", int2str(j),"ColDisD2.png");
        Nm = convertCharsToStrings(Nm);
        imwrite(DisImg(imgs{i}, 5), Nm);
            % Collor Distort/Brighten (twice)
        Nm = strcat(FNm,"\", int2str(j),"ColDisB1.png");
        Nm = convertCharsToStrings(Nm);
        imwrite(DisImg(imgs{i}, 6), Nm);
        Nm = strcat(FNm,"\", int2str(j),"ColDisB2.png");
        Nm = convertCharsToStrings(Nm);
        imwrite(DisImg(imgs{i}, 6), Nm);
            % Blur
        Nm = strcat(FNm,"\", int2str(j),"Blur.png");
        Nm = convertCharsToStrings(Nm);
        imwrite(DisImg(imgs{i}, 7), Nm);
    end
end
toc
