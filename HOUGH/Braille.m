%% Braille - Image 1

clear variables;
close all;
clc;

I = im2double(imread("./Braille/braille1.png"));
I= I+0.2;



% Filtrage --> Prétraitement
% SE = strel('disk',5);   % Element structurant
% I = imdilate(I,SE);
% imshow(I)



S = strel('disk',37);   % Element structurant
Ifiltered = imtophat(I,S);
figure()
imshow(Ifiltered,[])

% SE = strel('disk',4);   % Element structurant
% Ifiltered = imdilate(Ifiltered,SE);

% Détection de cercles
[centers, radius] = imfindcircles(Ifiltered,[1 15],'ObjectPolarity','bright');
figure()
imshow(I,[])
viscircles(centers, radius,'Color','b')


%%
% Egalisation d'histograme
Ifiltered = histeq(I);
% figure()
% imshow(Ifiltered,[])