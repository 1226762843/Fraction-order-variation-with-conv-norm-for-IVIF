function [metrix_value] = metrix_gsff(reference_imageA,reference_imageB,distorted_image)
% ========================================================================
% FSIM Index with automatic downsampling, Version 1.0
% Copyright(c) 2010 Lin ZHANG, Lei Zhang, Xuanqin Mou and David Zhang
% All Rights Reserved.
metrix_value = Qsff_index(reference_imageA,reference_imageB,distorted_image);
return;