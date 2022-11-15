function out = LC(img)
[nx,ny] = size(img);
% img=uint8(255*img1);
[count, ~] = imhist(img);
P = count./(nx.*ny);
Sal_Tab = zeros(256,1);
    for j=0:255
        for i=0:255
        Sal_Tab(j+1) = Sal_Tab(j+1)+P(i+1)*abs(j-i);      
        end 
    end
    out=zeros(size(img));
    for i=0:255
    out(img==i)=Sal_Tab(i+1);
    end
end