function cubic_img = resize_bicubic(sx,sy,fac,img)
    cubic_img = uint8(zeros(size(img).* [fac,fac,1]));
    for i=1:(sx*fac)-6    
        for j=1:(sy*fac)-6
           inx = ceil(i/fac);
           iny = ceil(j/fac);
           interp = double(zeros(4,4,3)); 
           for polx = -1:2
               for poly = -1:2
                   interp(polx+2,poly+2,:) = double(img((inx+polx)+1,(iny+poly)+1,:));
               end
           end

           for channel = 1:3
               cubic_img(i,j,channel) = BicubicInterpolate(interp(:,:,channel),1,1);
           end



        end
    end
end