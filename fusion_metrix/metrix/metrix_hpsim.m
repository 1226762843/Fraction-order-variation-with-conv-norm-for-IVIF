function metrix_value = metrix_hpsim(imgRef,imgDist)
%HaarPSI Computes the perceptual similarity between a reference image and its
%distorted version based on the discrete Haar wavelet transform. The code
%implements the method proposed in "Reisenhofer, Bosse, Kutyniok and Wiegand
%'A Haar Wavelet-Based Perceptual Similarity Index for Image Quality Assessment', 2016".
%
%Please make sure that grayscale and color values are given in the [0,255]
metrix_value =hpsim(imgRef,imgDist);