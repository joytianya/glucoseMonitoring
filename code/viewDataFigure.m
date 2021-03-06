file='C:\Users\xuanwei\Desktop\ʵ������Ŀ\data\20160530lyy\0011.txt';
fid=fopen(file,'r');
data=fread(fid);
LowBitValue=data(1:2:length(data));
HighBitValue=data(2:2:length(data));

Value=HighBitValue*256+LowBitValue;
VoltageValue=Value/4096*3.3;

VoltageValueMatrix=zeros(4,floor(length(VoltageValue)/4));
for j = 1:4
    VoltageValueMatrix(j,:)=VoltageValue(j:4:end);
end
sig1=VoltageValueMatrix(1,:);
len=length(VoltageValueMatrix(1,:));
figure(1);
plot(sig1);
figure(2);
subplot(4,1,1),plot(sig1);
nOfLevel=7;
[swa,swd]=swt(sig1,nOfLevel,'db5');
subplot(4,1,2),plot(swa(7,:));
[C1,L1] = wavedec(sig1,nOfLevel,'db5');
A7=wrcoef('a',C1,L1,'db5',7);
subplot(4,1,3),plot(A7);
sigProcessed=wavelet(sig1);
subplot(4,1,4),plot(sigProcessed);
figure(3)
plot(sigProcessed);

[C1,L1] = wavedec(sig1,8,'db4');
c1A12 = appcoef(C1,L1,'db4',8);
c1D12 = detcoef(C1,L1,8);
% c1D11 = detcoef(C1,L1,7);
% c1D10 = detcoef(C1,L1,10);
for i=1:length(c1A12)
    C1(i)=mean(c1A12);
end
for i=1+length(c1A12):length(c1A12)+length(c1D12)
    C1(i)=mean(c1D12);
end
for i=1+length(c1A12)+length(c1D12):length(c1A12)+length(c1D12)+length(c1D11)
    C1(i)=mean(c1D11);
end
S11=waverec(C1,L1,'db4');
figure(4);
plot(S11);
nOfLevel=5;
[swa,swd]=swt(S11,nOfLevel,'bior6.8');
SwaPeak=wave_peakbottom(swa(5,:));
plot(SwaPeak)

