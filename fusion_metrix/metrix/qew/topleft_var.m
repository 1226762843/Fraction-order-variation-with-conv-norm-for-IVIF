function img_var = topleft_var(img,block_size)
img = double(img);
filter_K = ones(block_size);
N = block_size.^2;
% N = block_size;
% [m,n] = size(img);
% img_var =zeros(m-N+1,n-N+1);
% for i=1:m-N+1
%     for j=1:n-N+1
%         im = img(i:i+N-1,j:j+N-1);
%         s = mean(im(:));
%         s1=(im-s).^2;
%         img_var(i,j) = mean(s1(:));
% %         img_var(i,j) = (im-s).^2;
%     end
% end
me1 = 1./N.*filter2(filter_K, img, 'valid');
% [m,n]=size(me1);
% img2 = (img(1:m,1:n) - me1).^2;
% img_var = 1./N.*filter2(filter_K, img2, 'valid');
me2 = 1./N.*filter2(filter_K, img.*img, 'valid');
% img_var = sqrt(me2 - me1.^2);
img_var = me2 - me1.^2;

