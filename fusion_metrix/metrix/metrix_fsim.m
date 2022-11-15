function [metrix_value] = metrix_fsim(imageRef, imageDis)
% ========================================================================
% FSIM Index with automatic downsampling, Version 1.0
% Copyright(c) 2010 Lin ZHANG, Lei Zhang, Xuanqin Mou and David Zhang
% All Rights Reserved.
metrix_value = fsim(imageRef, imageDis);
return;