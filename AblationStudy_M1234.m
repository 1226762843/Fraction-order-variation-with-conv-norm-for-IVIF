close all;
clear all;
clc;
%% input images

load('TNO_dataset.mat');

%% %%%%%%%%%% %%
%% Ablation Study M1 %%
%% %%%%%%%%%% %%
%% Fusion
disp(['------ Ablation Study M1 ------']);
num_lam = 0;
for im = 1:i_pairs
    U = double( image_sets{im,1} );
    V = double( image_sets{im,2} );
    %% Initialization and Parameter
    dt = 1;
    iter =  500;
    lam = 0.02;
    beta = 0.006;
    alpha = 0.1 ;
    F_momentum = 0;
    Z = (U+V)/2;
    fai = Z - V;
    [nx,ny] = size(Z);
    momentum = 0.9;
    K_gus = 0.4;
    K = fspecial('gaussian', 3 ,K_gus);
    num_lam = num_lam + 1;

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

        %%  Total variation
        if lam ~= 0
        [ Zx , Zy ] = gradient(Z);
        Z_grad = sqrt( Zx.^2 + Zy.^2 ) + eps;
        [ Zxx , Zyy ] = gradient(Z_grad);
        F_t = F_fai + lam .*  ( Zxx + Zyy )./Z_grad;
        else
            F_t = F_fai ;
        end
        F_momentum = momentum.*F_momentum + (1-momentum).*F_t;
        fai = fai - dt * F_momentum ;
        Z = fai + V;
        Z(Z>255)=255;
        Z(Z<0)=0;
    end
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
    AM1(im,:) = metri;
    T = array2table(AM1,'VariableNames',metri_name); %转换为表
    rmpath(genpath(strcat(pwd,'\','fusion_metrix')));
end
AM1_avg = mean(AM1);

%% %%%%%%%%%% %%
%% Ablation Study M2 %%
%% %%%%%%%%%% %%
%% Fusion
disp(['------ Ablation Study M2 ------']);
num_lam = 0;
for im = 1:i_pairs
    U = double( image_sets{im,1} );
    V = double( image_sets{im,2} );
    %% Initialization and Parameter
    dt = 1;
    iter =  500;
    lam = 0.02;
    beta = 0.006;
    alpha = 0.1 ;
    F_momentum = 0;
    Z = (U+V)/2;
    fai = Z - V;
    [nx,ny] = size(Z);
    momentum = 0.9;
    K_gus = 0.4;
    K = fspecial('gaussian', 3 ,K_gus);
    num_lam = num_lam + 1;

    Ck_x  = Ck_alpha_X( nx , alpha );
    Ck_x = fliplr(rot90(Ck_x,2));
    Ck_y  = Ck_alpha_Y( ny , alpha );
    Ck_y = fliplr(Ck_y);

    %% iteration
    for it=1:iter

        %%  Fidelity
        Constraint1 = fai - U + V;
        Constraint2 = fai;
        Constraint3 = beta*(Z);
        F_fai = Constraint1 + Constraint2 - Constraint3;

        %%   Factional variation
        if lam ~= 0
            Z_x = FranctionX( Z , Ck_x );
            Z_y = FranctionY( Z , Ck_y );
            Den = sqrt( Z_x.^2 + Z_y.^2 ) + eps;
            F_Z_x =  FranctionX( ( Z_x ./Den )  , Ck_x);
            F_Z_y =  FranctionY( ( Z_y ./Den )  , Ck_y);
            F_t = F_fai + lam .*  ( F_Z_x + F_Z_y );
        else
            F_t = F_fai ;
        end
        F_momentum = momentum.*F_momentum + (1-momentum).*F_t;
        fai = fai - dt * F_momentum ;
        Z = fai + V;
        Z(Z>255)=255;
        Z(Z<0)=0;
    end
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
    AM2(im,:) = metri;
    T = array2table(AM2,'VariableNames',metri_name); %转换为表
    rmpath(genpath(strcat(pwd,'\','fusion_metrix')));
end
AM2_avg = mean(AM2);

%% %%%%%%%%%% %%
%% Ablation Study M3 %%
%% %%%%%%%%%% %%
%% Fusion
disp(['------ Ablation Study M3  ------']);
num_lam = 0;
for im = 1:i_pairs
    U = double( image_sets{im,1} );
    V = double( image_sets{im,2} );
    %% Initialization and Parameter
    dt = 1;
    iter =  500;
    lam = 0.02;
    beta = 0;
    alpha = 0.1 ;
    F_momentum = 0;
    Z = (U+V)/2;
    fai = Z - V;
    [nx,ny] = size(Z);
    momentum = 0.9;
    K_gus = 0.4;
    K = fspecial('gaussian', 3 ,K_gus);
    num_lam = num_lam + 1;

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
        if lam ~= 0
            Z_x = FranctionX( Z , Ck_x );
            Z_y = FranctionY( Z , Ck_y );
            Den = sqrt( Z_x.^2 + Z_y.^2 ) + eps;
            F_Z_x =  FranctionX( ( Z_x ./Den )  , Ck_x);
            F_Z_y =  FranctionY( ( Z_y ./Den )  , Ck_y);
            F_t = F_fai + lam .*  ( F_Z_x + F_Z_y );
        else
            F_t = F_fai ;
        end
        F_momentum = momentum.*F_momentum + (1-momentum).*F_t;
        fai = fai - dt * F_momentum ;
        Z = fai + V;
        Z(Z>255)=255;
        Z(Z<0)=0;
    end
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
    AM3(im,:) = metri;
    T = array2table(AM3,'VariableNames',metri_name); %转换为表
    rmpath(genpath(strcat(pwd,'\','fusion_metrix')));
end
AM3_avg = mean(AM3);


%% %%%%%%%%%% %%%%%%
%% Ablation Study M4 (ours) %%%
%% %%%%%%%%%% %%%%%%
%% Fusion
disp(['------ Ablation Study M4 (ours) ------']);
num_lam = 0;
for im = 1:i_pairs
    U = double( image_sets{im,1} );
    V = double( image_sets{im,2} );
    %% Initialization and Parameter
    dt = 1;
    iter =  500;
    lam = 0.02;
    beta = 0.006;
    alpha = 0.1 ;
    F_momentum = 0;
    Z = (U+V)/2;
    fai = Z - V;
    [nx,ny] = size(Z);
    momentum = 0.9;
    K_gus = 0.4;
    K = fspecial('gaussian', 3 ,K_gus);
    num_lam = num_lam + 1;

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
        if lam ~= 0
            Z_x = FranctionX( Z , Ck_x );
            Z_y = FranctionY( Z , Ck_y );
            Den = sqrt( Z_x.^2 + Z_y.^2 ) + eps;
            F_Z_x =  FranctionX( ( Z_x ./Den )  , Ck_x);
            F_Z_y =  FranctionY( ( Z_y ./Den )  , Ck_y);
            F_t = F_fai + lam .*  ( F_Z_x + F_Z_y );
        else
            F_t = F_fai ;
        end
        F_momentum = momentum.*F_momentum + (1-momentum).*F_t;
        fai = fai - dt * F_momentum ;
        Z = fai + V;
        Z(Z>255)=255;
        Z(Z<0)=0;
    end
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
    AM4(im,:) = metri;
    T = array2table(AM4,'VariableNames',metri_name); %转换为表
    rmpath(genpath(strcat(pwd,'\','fusion_metrix')));
end
AM4_avg = mean(AM4);

ablation_avg = [AM1_avg;AM2_avg;AM3_avg;AM4_avg];


save Ablationstudy1234_minor_RR.mat









