clear all;
close all;
clc;

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

%% Numbers we will send

a = 16;
b = 32;

%% Sending and Receiving

disp('To send.. Press Space bar.....');
pause;
disp('Wait to start transmit process.....');

UART= serial('COM14', 'BaudRate', 9600);

fopen(UART);
disp('Serial Port is Open!');
disp('Writing Data.....');

%writing data in the FPGA
fwrite(UART,a,'uint8');
a
fwrite(UART,b,'uint8');
b

disp('Writing process is now complete.....');
disp('Wait to start receiving process.....');

recieve = fread(UART,1);
disp('All operations successful');
disp('Process completed!');
fclose(UART);

receive
