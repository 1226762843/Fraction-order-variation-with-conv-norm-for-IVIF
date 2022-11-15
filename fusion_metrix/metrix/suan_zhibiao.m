image_dir ='C:/Users/Administrator/Desktop/source/';
map_dir = 'C:/Users/Administrator/Desktop/Multifocus/others_pic/CBF';
data=[];
for num=1:20
    if num<=9
        image_A=['lytro-0',num2str(num),'-A.jpg'];
        image_B=['lytro-0',num2str(num),'-B.jpg'];
    else
        image_A=['lytro-',num2str(num),'-A.jpg'];
        image_B=['lytro-',num2str(num),'-B.jpg'];
    end
   
    img_A=rgb2gray(imread(fullfile(image_dir,image_A)));
    U=img_A;
    img_B=rgb2gray(imread(fullfile(image_dir,image_B)));
    V=img_B;
    mask_name=[num2str(num),'.png'];
    mask_A=rgb2gray(imread(fullfile(map_dir,mask_name)));
    Z=mask_A;
    metri_name = {'ssim','psnr','vif','vifp','uqi','ifc','nqm','wsnr','snr','cen','q','qw','qe','qsi','Qabf','nmin'};
%     metri_name = {'Qabf','nmin'};
    a = fusion_metrix(U,V,Z,'wsnr')
    
    data = [data;a];

end