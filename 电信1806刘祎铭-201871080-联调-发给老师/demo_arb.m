
%Connect to funciton generator. The resource name will change with each
%func gen. 
resource_name='USB0::0x1AB1::0x04B0::DS2D223401453::INSTR';
dg = dgConnect(resource_name);
enterBurstMode(dg, 1, 3, 'CENTER', 'MANUAL');
%enableOutput(dg, 1);
% triggerOutput(dg, 1);
% pause(0.5);
%disableOutput(dg, 1);
dgDisconnect(dg);