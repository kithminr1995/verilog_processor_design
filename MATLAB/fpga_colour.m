instrreset;

%% Load Assembly Code to the IRAM

% fileID = fopen('C:\Users\D I B Wickremasinghe\Desktop\Processor Design\Assembler\decimal_sequence.txt');
% assem_code = textscan(fileID,'%s');
% fclose(fileID);
% length_ac = length(assem_code{1});
% 
% UART= serial('COM14', 'BaudRate', 9600);
% 
% disp('To transfer instructions.. Press Space bar.....');
% pause;
% disp('Flip swtch to start transmit process.....');
% 
% fopen(UART);
% disp('Serial Port is Open!');
% disp('Writing instructions to IRAM.....');
% 
% for (i=1:length_ac)
%    n = strfind(assem_code{1}{i},'d'); 
%    l = length(assem_code{1}{i});
%    fwrite(UART,assem_code{1}{i}(n+1:l),'uint16');
% end
% fclose(UART);
% disp('Writing process is now complete.....');

%% Create 256 by 256 Original Image

a = 256;
original_im = imread('C:\Users\D I B Wickremasinghe\Desktop\Processor Design\MATLAB\FPGA_256.jpg');
original_im = original_im(1:a,1:a,:);

%RED
inverted_R = original_im(:,:,1)';
imageRow_R= inverted_R(:);
length_im1=length(imageRow_R);
%GREEN
inverted_G = original_im(:,:,2)';
imageRow_G= inverted_G(:);
length_im2=length(imageRow_G);
%BLUE
inverted_B = original_im(:,:,3)';
imageRow_B= inverted_B(:);
length_im3=length(imageRow_B);

%% Send Original Image
disp('To downsample image R matrix.. Press Space bar.....');
pause;
disp('Wait to start transmit process.....');

UART= serial('COM14', 'BaudRate', 9600);

fopen(UART);
disp('Serial Port is Open!');
disp('Writing Pixel Data.....');

%writing data in the FPGA
for (i=1:length_im1)
   i;
   fwrite(UART,imageRow_R(i),'uint8');
end

disp('Writing process is now complete.....');

downPixels = 16130; 
recieve1=zeros(downPixels,1);

disp('Wait to start receiving process.....');

for (j=1:downPixels)
  j;
  recieve1(j,1)=fread(UART,1);
end
disp('All operations successful');
disp('Down-sampling process completed!');
fclose(UART);

received1 = uint8(recieve1(2:end));
small_fpga_R = reshape(received1,127,127);    %--------------- reshape(byte_stream, width, height

disp('To downsample image G matrix.. Press Space bar.....');
pause;
disp('Wait to start transmit process.....');

fopen(UART);
disp('Serial Port is Open!');
disp('Writing Pixel Data.....');

%writing data in the FPGA
for (i=1:length_im2)
   i;
   fwrite(UART,imageRow_G(i),'uint8');
end

disp('Writing process is now complete.....');

downPixels = 16130; 
recieve2=zeros(downPixels,1);


disp('Wait to start receiving process.....');


for (j=1:downPixels)
  j;
  recieve2(j,1)=fread(UART,1);
end
disp('All operations successful');
disp('Down-sampling process completed!');
fclose(UART);

received2 = uint8(recieve2(2:end));
small_fpga_G = reshape(received2,127,127);    %--------------- reshape(byte_stream, width, height

disp('To downsample image B matrix.. Press Space bar.....');
pause;
disp('Wait to start transmit process.....');

fopen(UART);
disp('Serial Port is Open!');
disp('Writing Pixel Data.....');

%writing data in the FPGA
for (i=1:length_im3)
   i;
   fwrite(UART,imageRow_B(i),'uint8');
end

disp('Writing process is now complete.....');

downPixels = 16130; 
recieve3=zeros(downPixels,1);

disp('Flip switch to start receiving process.....');

for (j=1:downPixels)
  j;
  recieve3(j,1)=fread(UART,1);
end
disp('All operations successful');
disp('Down-sampling process completed!');
fclose(UART);

received3 = uint8(recieve3(2:end));
small_fpga_B = reshape(received3,127,127);    %--------------- reshape(byte_stream, width, height

disp('To see FINAL outputs... Press Space bar.....');
pause;

small_fpga = cat(3,small_fpga_R',small_fpga_G',small_fpga_B');

%% Expected Image Downsampled by Matlab 

ker = [1,3,1;...
      3,16,3;...
      1,3,1];

result = floor(conv2(original_im(:,:,1),ker)./32);
result = result(3:a,3:a);

small_1 = zeros(a/2-1);

i=1;
j=1;
rowcount = 1;
while i <= (((a-2)*(a-2)) - (a-1))
    
    small_1(j) =  result(i);
    j = j+1;
    if rowcount == (a-2-1);
    i = i+a;
    rowcount = 1;
    else
    rowcount = rowcount + 2; 
    i = i+2;
    end  
end

small_1 = uint8(small_1);

result = floor(conv2(original_im(:,:,2),ker)./32);
result = result(3:a,3:a);

small_2 = zeros(a/2-1);

i=1;
j=1;
rowcount = 1;
while i <= (((a-2)*(a-2)) - (a-1))
    
    small_2(j) =  result(i);
    j = j+1;
    if rowcount == (a-2-1);
    i = i+a;
    rowcount = 1;
    else
    rowcount = rowcount + 2; 
    i = i+2;
    end  
end

small_2 = uint8(small_2);

result = floor(conv2(original_im(:,:,3),ker)./32);
result = result(3:a,3:a);

small_3 = zeros(a/2-1);

i=1;
j=1;
rowcount = 1;
while i <= (((a-2)*(a-2)) - (a-1))
    
    small_3(j) =  result(i);
    j = j+1;
    if rowcount == (a-2-1);
    i = i+a;
    rowcount = 1;
    else
    rowcount = rowcount + 2; 
    i = i+2;
    end  
end

small_3 = uint8(small_3);

small = cat(3,small_1,small_2,small_3);

%% Results

figure;
imshow(original_im);
title('Original Image');

figure
imshow(small)
title('Matlab Downsampled')

figure
imshow(small_fpga)
error = small_1(:,:,1)-small_fpga(:,:,1);
title('FPGA Downsampled')

figure
imshow(error);
title('Error')

sumError = sum(sum(error.^2));
disp('Final Error in Operation: ');
sumError