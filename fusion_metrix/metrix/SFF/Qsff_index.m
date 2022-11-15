function score = Qsff_index(img1,img2,imgf)
load('W.mat');
n=size(img1);
if  numel(n)==2
    ref1(:,:,1)=img1;
    ref1(:,:,2)=img1;
    ref1(:,:,3)=img1;
end
n=size(img2);
if  numel(n)==2
    ref2(:,:,1)=img2;
    ref2(:,:,2)=img2;
    ref2(:,:,3)=img2;
end
n=size(imgf);
if  numel(n)==2
    res(:,:,1)=imgf;
    res(:,:,2)=imgf;
    res(:,:,3)=imgf;
end
score1 = SFF(ref1,res,W);
score2 = SFF(ref2,res,W);
score = (score1 + score2)./2;
