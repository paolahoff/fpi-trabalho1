close all;


filename = 'titan';
img = imread(strcat(filename,'.jpg'));
[sx,sy,ch] = size(img);
fac = 2;

nn_img = resize_nn(sx,sy,fac,img);
bilinear_img = resize_bilinear(sx,sy,fac,img);
cubic_img  = resize_bicubic(sx,sy,fac,img);

imwrite(nn_img, strcat(filename,'_nn.jpg'));
imwrite(bilinear_img,strcat(filename,'_bilinear.jpg'));
imwrite(cubic_img,strcat(filename,'_cubic.jpg'));

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


function bilinear_img = resize_bilinear(sx,sy,fac,img)

bilinear_img = uint8(zeros(size(img).* [fac,fac,1]));

for i=1:sx
    for j=1:sy
      bilinear_img(1+(i-1)*fac,1+(j-1)*fac,:)=img(i,j,:); 
    end
end

    for i=1:1+(sx-2)*fac     
        for j=1:1+(sy-2)*fac 

           if not(((rem(i-1,fac)==0) && (rem(j-1,fac)==0)) )
               %calcula os 4 pixeis mais próximos para interpolação
               inx = ceil(i/fac);
               iny = ceil(j/fac);

               interp00=double(bilinear_img( inx*fac-1,iny*fac-1,:)); 
               interp10=double(bilinear_img( inx*fac+1,iny*fac-1,:));
               interp01=double(bilinear_img( inx*fac-1,iny*fac+1,:));
               interp11=double(bilinear_img( inx*fac+1,iny*fac+1,:));

               x=rem(i-1,fac); %coordenadas do pixel interpolado
               y=rem(j-1,fac);  

               dx=x/fac; %
               dy=y/fac;

               c1=interp00;    %constantes da interpolação
               c2=interp10-interp00;
               c3=interp01-interp00;
               c4=interp00-interp10-interp01+interp11;           
               bilinear_img(i,j,:)=c1+c2*dx+c3*dy+c4*dx*dy; %pixel resultante
            end
        end
    end
end
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

function [output] = BicubicInterpolate(points, coefx, coefy)
    x1 = CubicInterpolate( points(1,1), points(2,1), points(3,1), points(4,1), coefx );
    x2 = CubicInterpolate( points(1,2), points(2,2), points(3,2), points(4,2), coefx );
    x3 = CubicInterpolate( points(1,3), points(2,3), points(3,3), points(4,3), coefx );
    x4 = CubicInterpolate( points(1,4), points(2,4), points(3,4), points(4,4), coefx );

    output = CubicInterpolate( x1, x2, x3, x4, coefy );
end


function [output] = CubicInterpolate(v0, v1, v2, v3, coef )
    A = (v3-v2)-(v0-v1);
    B = (v0-v1)-A;
    C = v2-v0;
    D = v1;
    output =  D + coef * (C + coef * (B + coef * A));
end

