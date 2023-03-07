function [bilinear_img] = resize_bilinear(sx,sy,fac,img)

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