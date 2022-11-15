function metrix_value = metrix_Q(imageRef, imageDis1,imageDis2)
% ========================================================================
% FSIM Index with automatic downsampling, Version 1.0
% Copyright(c) 2010 Lin ZHANG, Lei Zhang, Xuanqin Mou and David Zhang
% All Rights Reserved.
block_size = 8;
[metrix_value,~ ] = Q_index(imageDis1,imageDis2,imageRef,block_size);
return;