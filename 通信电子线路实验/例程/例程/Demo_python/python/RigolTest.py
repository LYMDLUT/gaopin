#__author__ = 'sn01309'
#coding=utf-8

if __name__ == '__main__' :


    import visa;
    rm = visa.ResourceManager();
   # reslist = rm.list_resources();
    inst = rm.open_resource('USB0::0x1AB1::0x099C::DSG8A170200001::INSTR');
    inst.write("*IDN?");
    print(inst.read());
    inst.write(":SOURce:FREQuency 1GHz");#设置频率
    inst.write(":SOURce:LEVel -10dBm");#设置幅度
    inst.write(":OUTPut:STATe ON");#打开RF开关
    rm.close();
    
    

