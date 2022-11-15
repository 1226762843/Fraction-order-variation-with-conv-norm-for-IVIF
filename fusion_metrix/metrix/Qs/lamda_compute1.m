function lamd = lamda_compute1(img1,img2,block_size)
[sa,~] = topleft_var1(img1,block_size);
[sb,~] = topleft_var1(img2,block_size);
index = (sa==0&sb==0);
lamd = sa./(sa + sb);
lamd(index) = 0.5;