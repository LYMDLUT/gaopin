%  clear;
% 创建 VISA 对象�?ni'为销售商参数，可以为 agilent、NI �?tek�?
% 'USB0::0x1AB1::0x04B0::DS2A0000000000::INSTR'为设备的资源描述符�?创建后需设置设备的属性，
% 本例中设置输入缓存的长度�?2048
% MSO2000A = visa( 'ni','USB0::0x1AB1::0x04B0::DS2A0000000000::INSTR' );
MSO2000A = visa( 'ni','USB0::0x1AB1::0x04B0::DS2F210800029::INSTR' );
MSO2000A.InputBufferSize = 2048;
N = MSO2000A.InputBufferSize;
%打开已创建的 VISA 对象
fopen(MSO2000A);
%读取波形
fprintf(MSO2000A, ':wav:data?' );
%请求数据
[data,len]= fread(MSO2000A,N);

% ------------------自加部分------------------

% 获取周期
fprintf(MSO2000A,':MEASure:PERiod? <CHANnel1>');
T = fscanf(MSO2000A);
T = str2num(T);
F = 1/T             % 计算频率

% 获取采样频率
fprintf(MSO2000A,':ACQuire:SRATe?');
Fs = fscanf(MSO2000A);
Fs = str2num(Fs)
% 计算采样总时�?
Tmax = N/Fs

% ------------------自加部分------------------

%关闭设备
fclose(MSO2000A);
delete(MSO2000A);
clear MSO2000A;
% 数据处理。读取的波形数据含有 TMC 头，长度�?11 个字节，其中�?2 个字节分别为 TMC 头标志符
% #和宽度描述符 9，接�?�� 9 个字节为数据长度，然后是波形数据，最后一个字节为结束�?0x0A。所
% 以，读取的有效波形数据点�?12 到�?数第 2 个点�?
wave = data(12:len-1);
wave = wave';
subplot(211);
plot(wave);

