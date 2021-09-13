
clc

% ------------------------��������Դ--------------------------------------
DSG800 = instrfind('Type', 'visa-usb', 'RsrcName', 'USB0::0x1AB1::0x04B0::DS2D223401453::INSTR', 'Tag', '');
if isempty(DSG800)
    DSG800 = visa('NI', 'USB0::0x1AB1::0x04B0::DS2D223401453::INSTR');
else
    fclose(DSG800);
    DSG800 = DSG800(1);
end


fopen(DSG800);%���豸

fprintf(DSG800, '*IDN?');%��������
pause(1); 
DataBack = fscanf(DSG800);%��ȡ����

fprintf(DSG800, ':SOURce:FREQuency 1GHz');%����Ƶ��
pause(1); 
fprintf(DSG800, ':SOURce:LEVel -10dBm');%���÷���
pause(1); 
fprintf(DSG800, ':OUTPut:STATe ON');%����RF����
pause(1); 

%--------------------------�ر�������Դ-------------------------------------
fclose(DSG800);
%-----------------------------��ʾ���ؽ��----------------------------------
disp(DataBack);
