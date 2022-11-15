function Ck_x  = Ck_alpha_X(nx,alpha)
Ck_x = zeros(nx,nx);
cka_x = zeros(1,nx);
cka_x(1) = 1;
for k=1:nx-1
    cka_x(k+1) = cka_x(k)*(1-(alpha+1)/(k));
end
ckaf_x = fliplr(cka_x);
for i = 1:nx
    ckaf_CIRx = circshift(ckaf_x,-(i-1));
    Ck_x( i , 1: end-i+1 ) = ckaf_CIRx( 1: end-i+1 ) ;
end
end