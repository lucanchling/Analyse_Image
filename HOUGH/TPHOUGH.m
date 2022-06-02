clear variables;
close all;
clc;



I = im2gray(im2double(imread('Images/buildings.png')));

% Les paramètres
[h,w] = size(I);
N = 1000;
rhomax= ceil(sqrt((h-1)^2+(w-1)^2));
%rho = linspace(-rhomax,rhomax,N);
teta= linspace(0,pi,N);
seuil = 0.1;

% Creation de l'image des contours
contour = edge(I,'canny');
%imshow(contour)

% Matrice d'accumulation H
[Yc,Xc]= find(contour ~= 0);  % Récupération coordonnées des piuxel où il y a des contours

sinusoide = @(x,y,teta)(ceil(y*cos(teta)+x*sin(teta)));
rho = sinusoide(Xc,Yc,teta);    % récupération des différentes sinusoides

H = zeros(2*rhomax,length(teta));

for i_rho = 1:length(rho(1,:))
    for i_teta = 1:length(teta)
        H(rho(i_rho,i_teta) + rhomax,i_teta) = H(rho(i_rho,i_teta) + rhomax,i_teta) +1;
    end
end

image(H)
colorbar
