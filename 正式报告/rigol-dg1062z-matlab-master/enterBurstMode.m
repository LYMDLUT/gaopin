function enterBurstMode(dg, channel, num_cycles, idle_level, trig_source)

% writeCommand(dg,sprintf(':SOURCE%d:APPLy:SINusoid 2.455MHz,200mVrms,0,0', channel));
% writeCommand(dg,sprintf(':SOURCE%d:MOD ON', channel));
% writeCommand(dg,sprintf(':SOURCE%d:MOD:TYPe AM', channel));
% writeCommand(dg,sprintf(':SOURCE%d:MOD:AM 80', channel));
% writeCommand(dg,sprintf(':SOURCE%d:MOD:AM:INTernal:FREQuency 25kHz', channel));
% writeCommand(dg,sprintf(':SOURCE%d:MOD:AM:INTernal:FUNCtion SINusoid', channel));


% writeCommand(dg,sprintf(':SOURCE%d:APPLy:SINusoid 2.455MHz,200mVrms,0,0', channel));
% writeCommand(dg,sprintf(':SOURCE%d:MOD ON', channel));
% writeCommand(dg,sprintf(':SOURCE%d:MOD:TYPe FM', channel));
% writeCommand(dg,sprintf(':SOURCE%d:MOD:FM 26KHZ', channel));
% writeCommand(dg,sprintf(':SOURCE%d:MOD:FM:INTernal:FREQuency 1KHZ', channel));
% writeCommand(dg,sprintf(':SOURCE%d:MOD:FM:INTernal:FUNCtion SINusoid', channel));

writeCommand(dg,sprintf(':SOURCE%d:APPLy:SINusoid 2.455MHz,200mVrms,0,0', channel));
writeCommand(dg,sprintf(':SOURCE%d:MOD ON', channel));
writeCommand(dg,sprintf(':SOURCE%d:MOD:TYPe PM', channel));
writeCommand(dg,sprintf(':SOURCE%d:MOD:PM 180', channel));
writeCommand(dg,sprintf(':SOURCE%d:MOD:PM:INTernal:FREQuency 1KHZ', channel));
writeCommand(dg,sprintf(':SOURCE%d:MOD:PM:INTernal:FUNCtion SINusoid', channel));
end