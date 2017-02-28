%读取脉搏波数字信号（4路）
%data是十进制数，其中一个数据点包括连续两个数
function []=eigenvalueExtract(Dir)
% Dir='C:\Users\xuanwei\Desktop\实验室项目\data\20160528lyy\';

listFile=dir([Dir,'*.txt']);
disp(['there are ',int2str(length(listFile)),' files'])
if ~exist([Dir,'eigenvalue'],'dir')
    mkdir([Dir,'eigenvalue']);
end
SaveFile=[Dir,'eigenvalue\Eigenvalue.csv'];
if exist(SaveFile,'file')
    delete(SaveFile);
end
for i =1:length(listFile)
    NowFileName=listFile(i).name;
    file=[Dir,'\', NowFileName];
% 显示处理的文件名字
disp(['processing file :', NowFileName]);
% file='0010.txt';
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
eachLengthV=floor(length(VoltageValue)/4);
nExpOf2_int=floor(log2(eachLengthV));
VoltageValueMatrixDen=zeros(4,2^nExpOf2_int);
for j =1:4
    VoltageValueMatrixDen(j,:)=wden(VoltageValueMatrix(j,1:2^nExpOf2_int),'modwtsqtwolog','s','mln',3,'sym8');
end
% plot(VoltageValueMatrixDen(1,:))
Eigenvalue=[];
for k=1:4
SignalEach=VoltageValueMatrixDen(k,:);
nOfLevel=5;
[swa,swd]=swt(SignalEach,nOfLevel,'bior6.8');
SwaPeak=wave_peakbottom(swa(5,:));
MaxSwaPeak=max(SwaPeak);
shiftYDistance=MaxSwaPeak/1000;
Threshold=shiftYDistance;
NoZeroOfSwaPeakIndex=find(SwaPeak~=0);
subSwaPeakIndex=NoZeroOfSwaPeakIndex(1,2:end);
MinXDistance=min(subSwaPeakIndex-NoZeroOfSwaPeakIndex(1,1:end-1));
while Threshold<=MaxSwaPeak
    NoZeroOfSwaPeakIndex=find(SwaPeak>=Threshold);
    if length(NoZeroOfSwaPeakIndex)>1
        subSwaPeakIndex=NoZeroOfSwaPeakIndex(1,2:end);
        NowMinXDistance=min(subSwaPeakIndex-NoZeroOfSwaPeakIndex(1,1:end-1));
    else
        break;
    end
    if(NowMinXDistance/MinXDistance<1.7)
        MinXDistance=NowMinXDistance;
        Threshold=Threshold+shiftYDistance;
    else
        break;
    end 
end
HighSwaPeakIndex=find(SwaPeak~=0&SwaPeak>=Threshold);
SwaPeakIndex=find(SwaPeak~=0);
StartN=(SwaPeakIndex(1)==HighSwaPeakIndex(1))*2+...
    (SwaPeakIndex(1)~=HighSwaPeakIndex(1));
EndN=(SwaPeakIndex(end)==HighSwaPeakIndex(end))*...
    (length(SwaPeakIndex)-1)+...
    (SwaPeakIndex(end)~=HighSwaPeakIndex(end))*...
    length(SwaPeakIndex);
SwaPeakIndex=SwaPeakIndex(StartN:EndN);
SwdValid=swd(4,:);
NumsOfWave=floor((length(SwaPeakIndex)-1)/2);
FrontEigenvalue=zeros(NumsOfWave,8);
BackEigenvalue=zeros(NumsOfWave,8);
% TempEigenvalue=zeros(NumsOfWave,14);
for j=1:2:(2*NumsOfWave-1)
    tempSwdValid=SwdValid(max(1,(SwaPeakIndex(j)-3)):...
        min((SwaPeakIndex(j+1)+3),length(SwdValid)));
    tempSignalEach=SignalEach(max(1,(SwaPeakIndex(j)-3)):...
        min((SwaPeakIndex(j+1)+3),length(SignalEach)));
%     TempEigenvalue((j+1)/2,:)=findOppsiteIndexInOneWave(tempSwdValid,tempSignalEach);
    FrontEigenvalue((j+1)/2,:)=findOppsiteIndex(tempSwdValid,tempSignalEach);
    tempSwdValid=SwdValid(max(1,(SwaPeakIndex(j+1)-3)):...
        min((SwaPeakIndex(j+2)+3),length(SwdValid)));
    tempSignalEach=SignalEach(max(1,(SwaPeakIndex(j+1)-3)):...
        min((SwaPeakIndex(j+2)+3),length(SignalEach)));
    BackEigenvalue((j+1)/2,:)=findOppsiteIndex(tempSwdValid,tempSignalEach);
end
TempEigenvalue=[FrontEigenvalue,BackEigenvalue];
preEigenvalueSize=size(Eigenvalue);
TempEigenvalueSize=size(TempEigenvalue);
EigenvalueSize=max(preEigenvalueSize,TempEigenvalueSize);
if (preEigenvalueSize(1)<EigenvalueSize(1))&&(~isempty(Eigenvalue))
    PadZeros=zeros(EigenvalueSize(1)-preEigenvalueSize(1),EigenvalueSize(2));
    Eigenvalue=[Eigenvalue;PadZeros];
end
if TempEigenvalueSize(1)<EigenvalueSize(1)
    PadZeros=zeros(EigenvalueSize(1)-TempEigenvalueSize(1),TempEigenvalueSize(2));
    TempEigenvalue=[TempEigenvalue;PadZeros];
end
Eigenvalue=[Eigenvalue,TempEigenvalue];
% 显示处理的信号来源
% disp(['already processed ',int2str(k),'th finger'])
end
NameNumFile=ones(EigenvalueSize(1),1)*(str2double(NowFileName(1,1:end-4))+1);

Eigenvalue=[NameNumFile,Eigenvalue];
if exist(SaveFile,'file')
    dlmwrite(SaveFile,Eigenvalue,'delimiter','\t','precision','%.6f','-append');
else
%     Header=char();
%     for m=1:4
%         for n=1:16
%            Header(m*n,:)=char([int2str(m),'-',int2str(n)]);
%         end
%     end
%     Eigenvalue=[Header;Eigenvalue];
    dlmwrite(SaveFile,Eigenvalue,'delimiter','\t','precision','%.6f');
end
end
end

