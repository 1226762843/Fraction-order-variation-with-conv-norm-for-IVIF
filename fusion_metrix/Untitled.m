image_dir ='C:/Users/Administrator/Desktop/source/';
map_dir = 'C:/Users/Administrator/Desktop/fused_image/';
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
    mask_name=[num2str(num),'.jpg'];
    mask_A=rgb2gray(imread(fullfile(map_dir,mask_name)));
    Z=mask_A;
    a = Qabf(U,V,Z);
    
    data = [data;a]
end