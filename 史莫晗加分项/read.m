%����VISA����'ni'Ϊ�����̲���������Ϊagilent��NI��tek��'USB0::0x1AB1::0x04B0::DS2A0000000000::INSTR'Ϊ�豸����Դ���������������������豸�����ԣ��������������뻺��ĳ���Ϊ2048
MSO2000A = visa( 'ni','USB0::0x1AB1::0x04B0::DS2D223401453::INSTR' );
MSO2000A.InputBufferSize =2048*5000;
%���Ѵ�����VISA����
fopen(MSO2000A);
%��ȡ����
fprintf(MSO2000A, ':wav:data?' );
%��������
[data,len]= fread(MSO2000A,2048*5000);
%�ر��豸
fclose(MSO2000A);
delete(MSO2000A);
clear MSO2000A;
%���ݴ�����ȡ�Ĳ������ݺ���TMCͷ������Ϊ11���ֽڣ�����ǰ2���ֽڷֱ�ΪTMCͷ��־��#�Ϳ��������9�����ŵ�9���ֽ�Ϊ���ݳ��ȣ�Ȼ���ǲ������ݣ����һ���ֽ�Ϊ������0x0A�����ԣ���ȡ����Ч�������ݵ�Ϊ12��������2���㡣
wave = data(12:len-1);
wave = wave'; 
wave= wave-mean(wave);
subplot(221); 
plot(wave); 
axis( [0,500,-40,40] );
title('��������ͼ');
fftSpec = fft(wave',2048*5000); 
fftRms = abs( fftSpec');
fftLg = 20*log(fftRms); 
subplot(222); 
plot(fftLg);
axis( [0,1200000,0,300] ); 
title('������Ƶ��ͼ');
f2=pout(wave);
am = abs(wave+j*f2);
am=am-mean(am);
subplot(223); 
plot(am); 
axis( [0,500,-40,40] );
title('�����');
fftSpec2 = fft(f2',2048*5000); 
fftRms2 = abs( fftSpec2');
fftLg = 20*log(fftRms2); 
subplot(224); 
plot(fftLg);
axis( [0,200000,0,300] ); 
title('�����Ƶ��ͼ');