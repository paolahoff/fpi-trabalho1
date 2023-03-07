function nn_img = resize_nn(sx,sy,fac,img)

nn_img = uint8(zeros(size(img).* [fac,fac,1]));
    for x = 1:sx
        for y = 1:sy

            nn_img(fac*x,fac*y-1,:) = img(x,y,:);

            nn_img(fac*x-1,fac*y,:) = img(x,y,:);

            nn_img(fac*x,fac*y,:) = img(x,y,:);

            nn_img(fac*x-1,fac*y-1,:) = img(x,y,:);

        end
    end
end