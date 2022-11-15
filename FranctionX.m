function nabla_x = FranctionX(U,Ck_x)
nabla_x = Ck_x * U;
nabla_x = flipud(rot90(fliplr(nabla_x),2)); 
end


