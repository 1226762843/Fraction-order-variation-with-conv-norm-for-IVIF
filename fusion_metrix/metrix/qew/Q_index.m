function [Q,Qmap] = Q_index(img1,img2,imgf,block_size)
img1 = double(img1);
img2 = double(img2);
imgf = double(imgf);
% [~, Q0a] = img_qi(img1, imgf, block_size);
% [~, Q0b] = img_qi(img2, imgf, block_size);
[~, Q0a] = img_qi(imgf,img1,block_size);
[~, Q0b] = img_qi(imgf,img2,block_size);
% sa = topleft_var(img1,block_size);
% sb = topleft_var(img2,block_size);
% index = (sa==0 &sb==0);
% lamd = sa./(sa + sb);
% lamd(index) = 0.5;
[lamd,~,~] = lamda_compute(img1,img2,block_size);
Qmap = lamd.*Q0a + (1-lamd).*Q0b;
Q = mean2(Qmap);
