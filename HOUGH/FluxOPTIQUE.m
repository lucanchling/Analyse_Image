clear variables;
close all;
clc;


% Lecture de l'image
I1 = im2double(imread('./MiniCooper/i0001.png'));
I2 = im2double(imread('./MiniCooper/i0002.png'));

%%
figure()
subplot(1,3,1)
imshow(I1)
subplot(1,3,2)
imshow(I2)
DIFF = I2 - I1;
subplot(1,3,3)
imshow(DIFF)

[H,W] = size(I1);

% %%
%% Définition des paramètres de l'algorithme
L = 0.5; % influence cohérence spatiale
%PATCH = (10,10); % taille du patch pour le filtre moyenneur

% %%
%% Calcul des gradients
[Gx, Gy] = gradient(I1);
Gt = I2 - I1;
figure()
subplot(1,3,1)
imshow(Gx)
subplot(1,3,2)
imshow(Gy)
subplot(1,3,3)
imshow(Gt)


% %%
%% Calcul du flux optique par descente de gradient
prec = 1e-3;
flag = 1;

u_n = zeros(H,W);
v_n = zeros(H,W);
u_n1 =zeros(H,W);
v_n1 =zeros(H,W);
i=0;
% le filtre
n = [3,3];
h = fspecial('average', n);
while i<200
    % Calcul de la moyenne dans le voisinage

    ubar = filter2(h, u_n);
    vbar = filter2(h, v_n);

    u_n1 = ubar - Gx.*(Gx.*ubar + Gy.*vbar + Gt)./(L.*L + Gx.*Gx + Gy.*Gy);
    v_n1 = vbar - Gy.*(Gx.*ubar + Gy.*vbar + Gt)./(L*L + Gx.*Gx + Gy.*Gy);

    u_n = u_n1;
    v_n = v_n1;

    %U_mem.append(np.sum(u_n))
    %V_mem.append(np.sum(v_n))
    
    i=i+1;
    % if (np.linalg.norm(u_n1 - u_n)/np.linalg.norm(u_n) < prec) and (np.linalg.norm(v_n1 - v_n)/np.linalg.norm(v_n) < prec):
    %     flag = False
    % pass
end


% %%

u_plot = NaN(H,W);
v_plot = NaN(H,W);

u_plot(1:5:end,1:5:end) = u_n1(1:5:end,1:5:end);
v_plot(1:5:end,1:5:end) = v_n1(1:5:end,1:5:end);


% Affichage du flux sur l'image
figure()

quiver(u_plot, v_plot)%, units='xy', scale=10)

imshow(I2);



