clear all;
close all;
clc;

original_im = imread('C:\Users\D I B Wickremasinghe\Desktop\Processor Design\MATLAB\Lena_512.png');
im = imresize(original_im, 0.25);
imshow(im);

imwrite(im,'C:\Users\D I B Wickremasinghe\Desktop\Processor Design\MATLAB\Lena_128.jpg');
