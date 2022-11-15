close all;
clear all;
clc;
%% input images

load('TNO_dataset.mat');  % MFNet_dataset // OSU_dataset // RoadScene_dataset % // 5_sequence // 6_sequence // TNO-Duine_sequence // TNO-Tree_sequence
%% Fusion
num_lam = 0;
for im = 1:i_pairs %[11]

    U = double( image_sets{im,1} );
    V = double( image_sets{im,2} );

    %% Initialization and Parameter

    dt = 1;
    iter =  500;
    lam = 0.02;
    beta = 0.006;
    alpha = 0.1;
    F_momentum = 0;
    Z = (U+V)/2;
    fai = Z - V;
    [nx,ny] = size(Z);
    momentum = 0.9;
    K_gus = 0.4;
    K = fspecial('gaussian', 3 ,K_gus);
    num_lam = num_lam + 1;
    disp(['No.image : ',num2str(im),' dt=',num2str(dt),' iter=',num2str(iter),' lam=',num2str(lam),' beta=',num2str(beta),' alpha=',num2str(alpha)]);

    Ck_x  = Ck_alpha_X( nx , alpha );
    Ck_x = fliplr(rot90(Ck_x,2));
    Ck_y  = Ck_alpha_Y( ny , alpha );
    Ck_y = fliplr(Ck_y);

    %% iteration

    for it=1:iter

        %%  Fidelity
        Constraint1 = fai - U + V;
        Constraint2 = fai;
        Constraint1 = conv2 (Constraint1 , K ,'same') ./ sqrt ( conv2(Constraint1.^2 , K ,'same') + eps) ;
        Constraint2 = conv2 (Constraint2 , K ,'same') ./ sqrt ( conv2(Constraint2.^2 , K ,'same') + eps) ;
        Constraint3 = beta*(Z);

        F_fai = Constraint1 + Constraint2 - Constraint3;

        %%   Factional variation
        Z_x = FranctionX( Z , Ck_x );
        Z_y = FranctionY( Z , Ck_y );
        Den = sqrt( Z_x.^2 + Z_y.^2 ) + eps;
        F_Z_x =  FranctionX( ( Z_x ./Den )  , Ck_x);
        F_Z_y =  FranctionY( ( Z_y ./Den )  , Ck_y);
        F_t = F_fai + lam .*  ( F_Z_x + F_Z_y );

        F_momentum = momentum.*F_momentum + (1-momentum).*F_t;
        fai = fai - dt * F_momentum ;
        Z = fai + V;
        Z(Z>255)=255;
        Z(Z<0)=0;
    end

    savepath = ['.\result\'];
    if isdir(savepath)==0
        mkdir(savepath)
    end
    imwrite(Z/255,[savepath,'Our',num2str(im),'-lam=',num2str(lam),'-beta=',num2str(beta),'-alpha=',num2str(alpha),'.tif']);

    %%  计算指标
    addpath(genpath(strcat(pwd,'\','fusion_metrix'))); %%

    metri_name =  {'im','lam','beta','alpha','MIN','Qsi','QABF','VIFP','ME','IFC'};
    len_metri_name = length(metri_name);
    j=1;
    for ii=1:len_metri_name
        metri(j,ii) = fusion_metrix(U,V,uint8(Z),metri_name{ii});
        metri(j,1) = im;
        metri(j,2) = lam;
        metri(j,3) = beta;
        metri(j,4) = alpha;
    end
    metri = real(metri);

    A(num_lam,:) = metri;
    T = array2table(A,'VariableNames',metri_name) %转换为表

    rmpath(genpath(strcat(pwd,'\','fusion_metrix')));
end



