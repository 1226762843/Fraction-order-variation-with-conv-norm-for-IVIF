function quality = gsm_index(img1, img2)
I1 = double(img1);
I2 = double(img2);
quality = GSM(I1,I2);
