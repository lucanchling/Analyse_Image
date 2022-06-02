%% Braille - Image 1

clear variables;
close all;
clc;

I = im2double(imread("./Braille/braille1.png"));

% Filtrage --> Prétraitement

% Dilatation
SE = strel('disk',3);   % Element structurant
I = imdilate(I,SE);

% TopHat
S = strel('disk',37);   % Element structurant
Ifiltered = imtophat(I,S);

figure()
imshow(Ifiltered)

% Détection de cercles
[centers, radius] = imfindcircles(Ifiltered,[2 20],'ObjectPolarity','bright');
figure()
imshow(I,[])
viscircles(centers, radius,'Color','b')

%% Braille - Image 2
clear variables;
close all;
clc;

I = im2double(imread("./Braille/braille2.png"));
I = rgb2gray(I);
% Filtrage --> Prétraitement


% BottomHat
S = strel('disk',10);   % Element structurant
Ifiltered = imbothat(I,S);
%figure()
%imshow(Ifiltered,[])



% Filtre médian
Ifiltered = medfilt2(Ifiltered,[2 3]);

% figure()
% imshow(Ifiltered,[])

SE = strel('disk',2);   % Element structurant
Ifiltered = imdilate(Ifiltered,SE);
figure()
imshow(Ifiltered)

% SE = strel('disk',4);   % Element structurant
% Ifiltered = imdilate(Ifiltered,SE);

% Détection de cercles
[centers, radius] = imfindcircles(Ifiltered,[1 6]);
figure()
imshow(I,[])
viscircles(centers, radius,'Color','b')


%% Braille - Image 4
clear variables;
close all;
clc;

I = im2double(imread("./Braille/braille4.png"));

% Filtrage --> Prétraitement
SE = strel('disk',3);   % Element structurant
I = imdilate(I,SE);
% imshow(I)


S = strel('disk',37);   % Element structurant
Ifiltered = imtophat(I,S);
figure()
imshow(Ifiltered,[])

% SE = strel('disk',4);   % Element structurant
% Ifiltered = imdilate(Ifiltered,SE);

% Détection de cercles
[centers, radius] = imfindcircles(Ifiltered,[2 20],'ObjectPolarity','bright');
figure()
imshow(I,[])
viscircles(centers, radius,'Color','b')

%%
% S = strel('disk',3);   % Element structurant
% Ifiltered = imopen(Ifiltered,S);
% Egalisation d'histograme
Ifiltered = histeq(I);
% figure()
% imshow(Ifiltered,[])