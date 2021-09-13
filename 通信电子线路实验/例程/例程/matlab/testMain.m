
clc

% ------------------------打开仪器资源--------------------------------------
DSG800 = instrfind('Type', 'visa-usb', 'RsrcName', 'USB0::0x1AB1::0x04B0::DS2D223401453::INSTR', 'Tag', '');
if isempty(DSG800)
    DSG800 = visa('NI', 'USB0::0x1AB1::0x04B0::DS2D223401453::INSTR');
else
    fclose(DSG800);
    DSG800 = DSG800(1);
end


fopen(DSG800);%打开设备

fprintf(DSG800, '*IDN?');%设置命令
pause(1); 
DataBack = fscanf(DSG800);%读取数据

fprintf(DSG800, ':SOURce:FREQuency 1GHz');%设置频率
pause(1); 
fprintf(DSG800, ':SOURce:LEVel -10dBm');%设置幅度
pause(1); 
fprintf(DSG800, ':OUTPut:STATe ON');%设置RF开关
pause(1); 

%--------------------------关闭仪器资源-------------------------------------
fclose(DSG800);
%-----------------------------显示返回结果----------------------------------
disp(DataBack);
