function Ck_y  = Ck_alpha_Y(ny,alpha)
Ck_y = zeros(ny,ny);
cka_y = zeros(1,ny);
cka_y(1) = 1;
for k=1:ny-1
    cka_y(k+1) = cka_y(k)*(1-(alpha+1)/(k));
end
ckaf_y = fliplr(cka_y);

for i = 1:ny
    ckaf_CIRy = circshift(ckaf_y,-(i-1)).';
    Ck_y( 1: end-i+1 , i ) = ckaf_CIRy( 1: end-i+1 ) ;
end

end