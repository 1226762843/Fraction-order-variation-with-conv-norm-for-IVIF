function [lamd,sa,sb] = lamda_compute(img1,img2,block_size)
sa = topleft_var(img1,block_size);
sb = topleft_var(img2,block_size);
index = (sa==0&sb==0);
lamd = sa./(sa + sb);
lamd(index) = 0.0;