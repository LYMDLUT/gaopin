% InitialtionEquip ���ƺ�����ʼ����
%ʾ��������豸��Ϣ��ֱ�Ӳ����豸
DSG800 = instrfind('Type', 'visa-usb', 'RsrcName', 'USB0::0x1AB1::0x04B0::DS2D223401453::INSTR', 'Tag', '');
if isempty(DSG800)
    DSG800 = visa('NI', 'USB0::0x1AB1::0x04B0::DS2D223401453::INSTR');
else
    fclose(DSG800);
    DSG800 = DSG800(1);
end



fprintf('InitialtionEquip ok!\n');