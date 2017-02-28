function wpeak_bottom=wave_peakbottom(signal)
% 该函数用于信号序列中模极大值序列
warning off;
%求小波变换的模极大值及其位置
points=length(signal);
ddw=zeros(size(signal));
Peak=ddw;
peak=ddw;
Bottom=ddw;
bottom=ddw;
peak=((signal(:,1:points-1)-signal(:,2:points))<0);
Peak(:,2:points-1)=((peak(:,1:points-2)-peak(:,2:points-1))>0);%其中存放的是所有峰的位置
bottom=((signal(:,1:points-1)-signal(:,2:points))>0);
Bottom(:,2:points-1)=((bottom(:,1:points-2)-bottom(:,2:points-1))>0);%其中存放的是所有谷的位置
Peak_Bottom=Peak|Bottom;
Peak_Bottom(:,1)=0;%两头清零
Peak_Bottom(:,points)=0;
wpeak_bottom=Peak_Bottom.*signal;