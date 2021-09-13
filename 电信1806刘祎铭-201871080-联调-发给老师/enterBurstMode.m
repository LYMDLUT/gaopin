function enterBurstMode(dg, channel, num_cycles, idle_level, trig_source)
%writeCommand(dg,sprintf(':AUTOSCALE', channel));
% lll=sprintf(strcat(':CHANnel1:OFFSet',' -2.2'));
% writeCommand(dg,lll);
%writeCommand(dg,sprintf(':TLHAlf', channel));
%writeCommand(dg,sprintf(':CHANnel<n>:COUPling', channel));
writeCommand(dg,':TIMebase:OFFSet -0.01');

end