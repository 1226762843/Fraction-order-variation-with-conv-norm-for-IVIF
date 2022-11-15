function Qw = Qw_index(img1,img2,imgf,block_size)
[~,Qmap] = Q_index(img1,img2,imgf,block_size);
[~,sa,sb] = lamda_compute(img1,img2,block_size);
Cw = max(sa,sb);
% Cw = sa+sb;
cw = Cw./sum(Cw(:));
T= cw.*Qmap;
Qw = sum(T(:));