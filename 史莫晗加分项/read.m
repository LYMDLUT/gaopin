%创建VISA对象。'ni'为销售商参数，可以为agilent、NI或tek，'USB0::0x1AB1::0x04B0::DS2A0000000000::INSTR'为设备的资源描述符。创建后需设置设备的属性，本例中设置输入缓存的长度为2048
MSO2000A = visa( 'ni','USB0::0x1AB1::0x04B0::DS2D223401453::INSTR' );
MSO2000A.InputBufferSize =2048*5000;
%打开已创建的VISA对象
fopen(MSO2000A);
%读取波形
fprintf(MSO2000A, ':wav:data?' );
%请求数据
[data,len]= fread(MSO2000A,2048*5000);
%关闭设备
fclose(MSO2000A);
delete(MSO2000A);
clear MSO2000A;
%数据处理。读取的波形数据含有TMC头，长度为11个字节，其中前2个字节分别为TMC头标志符#和宽度描述符9，接着的9个字节为数据长度，然后是波形数据，最后一个字节为结束符0x0A。所以，读取的有效波形数据点为12到倒数第2个点。
wave = data(12:len-1);
wave = wave'; 
wave= wave-mean(wave);
subplot(221); 
plot(wave); 
axis( [0,500,-40,40] );
title('调幅波形图');
fftSpec = fft(wave',2048*5000); 
fftRms = abs( fftSpec');
fftLg = 20*log(fftRms); 
subplot(222); 
plot(fftLg);
axis( [0,1200000,0,300] ); 
title('调幅波频谱图');
f2=pout(wave);
am = abs(wave+j*f2);
am=am-mean(am);
subplot(223); 
plot(am); 
axis( [0,500,-40,40] );
title('解调波');
fftSpec2 = fft(f2',2048*5000); 
fftRms2 = abs( fftSpec2');
fftLg = 20*log(fftRms2); 
subplot(224); 
plot(fftLg);
axis( [0,200000,0,300] ); 
title('解调波频谱图');