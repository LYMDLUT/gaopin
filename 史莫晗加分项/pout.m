function pout=envelop(pin,varargin)
k=1;
switch numel(varargin)
case 0
k=1;
case 1
k=varargin{1};
if ~isscalar(k),
error '����ϵ�������Ǳ���'
return;
end
otherwise
error 'too many params';
return;
end
ph=hilbert(pin);
pout=k*abs(ph);