function metrix_value = fusion_metrix(A,B,F,name)
%%%  NOTES:     
%%%
%%%             algorithm                       indicator string 
%%%             ---------------------------     ---------------- 
%%%             shannon entropy                 'SEN'   ��ũ��             
%%%             mean value                      'ME'    ƽ��ֵ          
%%%             average gradient                'AVG'   ƽ���ݶ�
%%%             standard deviation              'STD'   ��׼ƫ��
%%%
%%%             mean-squared error              'MSE'   �������        
%%%             peak signal-to-noise ratio      'PSNR'  ��ֵ�����        
%%%             structural similarity index     'SSIM'  �ṹ������ָ��
%%%             visual information fidelity     'VIF'   �Ӿ���Ϣ�����
%%%             pixel-based VIF                 'VIFP'  ��������    
%%%             universal quality index         'UQI'   ͨ������ָ��       
%%%             image fidelity criterion        'IFC'   ͼ����ȱ�׼   
%%%             noise quality measure           'NQM'   ������������    
%%%             weighted signal-to-noise ratio  'WSNR'  ��Ȩ�����  
%%%             signal-to-noise ratio           'SNR'   �����
%%%             cross entropy                   'CEN'   ������
%%%             mutual inforamtion              'MIN'   �໥��Ϣ
%%%             Q0 index                        'Q0I'   
%%%             Qabf index                      'QABF'
metrix_name = lower(name);
reference_imageA = double(A);
reference_imageB = double(B);
distorted_image = double(F);
switch metrix_name
    case 'sen'
        metrix_value = one_image_metrix(distorted_image,metrix_name);
    case 'me'
        metrix_value = one_image_metrix(distorted_image,metrix_name); 
    case 'avg'
        metrix_value = one_image_metrix(distorted_image,metrix_name);    
    case 'std'
        metrix_value = one_image_metrix(distorted_image,metrix_name);    
 %----------------------------------------------------------------------       
    case 'mse'
        metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
        metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
    case 'psnr'
        metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
        metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
    case 'ssim'
        metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
        metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
    case 'vif'
        metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
        metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
    case 'vifp'
        metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
        metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
    case 'uqi'
        metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
        metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
    case 'ifc'
        metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
        metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
    case 'nqm'
        metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
        metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
    case 'wsnr'
        metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
        metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
    case 'snr'
        metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
        metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
    case 'cen'
        metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
        metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
    case 'min'
        metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
        metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
   case 'nmin'
       metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
       metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
       metrix_value = (metrix_value_AF + metrix_value_BF).*2;
   case 'fsim'
       metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
       metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
       metrix_value = (metrix_value_AF + metrix_value_BF)./2;
   case 'hpsim'
       metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
       metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
       metrix_value = (metrix_value_AF + metrix_value_BF)./2;
    case 'q0i'
        metrix_value_AF = two_image_metrix(reference_imageA,distorted_image,metrix_name);
        metrix_value_BF = two_image_metrix(reference_imageB,distorted_image,metrix_name);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
    case 'qabf'
        metrix_value = Qabf1(reference_imageA,reference_imageB,distorted_image);
    case 'niqe'
        metrix_value = niqe(distorted_image);
    case 'gsm'
        metrix_value_AF =metrix_gsm(reference_imageA,distorted_image);
        metrix_value_BF =metrix_gsm(reference_imageB,distorted_image);
        metrix_value = (metrix_value_AF + metrix_value_BF)/2;
    case 'q'
        metrix_value = metrix_Q(distorted_image,reference_imageA,reference_imageB);
    case 'qw'
        metrix_value = metrix_Qw(distorted_image,reference_imageA,reference_imageB);
    case 'qe'
        metrix_value = metrix_Qe(distorted_image,reference_imageA,reference_imageB);
    case 'qsi'
        metrix_value = metrix_Qsi(distorted_image,reference_imageA,reference_imageB);
    case 'qsff'
        metrix_value = metrix_gsff(reference_imageA,reference_imageB,distorted_image);
    otherwise
        metrix_value = NaN;
end