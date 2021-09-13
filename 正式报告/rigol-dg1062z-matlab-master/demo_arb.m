
%Connect to funciton generator. The resource name will change with each
%func gen. 
resource_name='USB0::0x1AB1::0x0641::DG4E183802425::INSTR';
dg = dgConnect(resource_name);
enterBurstMode(dg, 1, 3, 'CENTER', 'MANUAL');
enableOutput(dg, 1);
% triggerOutput(dg, 1);
% pause(0.5);
%disableOutput(dg, 1);
dgDisconnect(dg);