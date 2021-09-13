% InitialtionEquip 控制函数初始化；
%示例，填好设备信息后直接查找设备
DSG800 = instrfind('Type', 'visa-usb', 'RsrcName', 'USB0::0x1AB1::0x04B0::DS2D223401453::INSTR', 'Tag', '');
if isempty(DSG800)
    DSG800 = visa('NI', 'USB0::0x1AB1::0x04B0::DS2D223401453::INSTR');
else
    fclose(DSG800);
    DSG800 = DSG800(1);
end



fprintf('InitialtionEquip ok!\n');