function wpeak_bottom=wave_peakbottom(signal)
% �ú��������ź�������ģ����ֵ����
warning off;
%��С���任��ģ����ֵ����λ��
points=length(signal);
ddw=zeros(size(signal));
Peak=ddw;
peak=ddw;
Bottom=ddw;
bottom=ddw;
peak=((signal(:,1:points-1)-signal(:,2:points))<0);
Peak(:,2:points-1)=((peak(:,1:points-2)-peak(:,2:points-1))>0);%���д�ŵ������з��λ��
bottom=((signal(:,1:points-1)-signal(:,2:points))>0);
Bottom(:,2:points-1)=((bottom(:,1:points-2)-bottom(:,2:points-1))>0);%���д�ŵ������йȵ�λ��
Peak_Bottom=Peak|Bottom;
Peak_Bottom(:,1)=0;%��ͷ����
Peak_Bottom(:,points)=0;
wpeak_bottom=Peak_Bottom.*signal;