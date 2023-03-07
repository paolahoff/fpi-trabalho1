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

