
tic;
Dir_data='C:\Users\xuanwei\Desktop\ʵ������Ŀ\data\20160530lyy\';
Dir_Net='C:\Users\xuanwei\Desktop\ʵ������Ŀ\data\20160528lyy\';
[NameNumFiles,ForecastValue]=forecast(Dir_Net,Dir_Net);

% ----------------
LabelsFiles=[Dir_Net,'labels/LabelsToFiles.xlsx'];

% y_real=NameNumFiles;
LabelsToFiles=xlsread(LabelsFiles,1);
% numMeasure=xlsread(LabelsFiles,2);
LabelsArray=[];
LabelsArray(LabelsToFiles(:,1)+1)=LabelsToFiles(:,2);
y_real=LabelsArray(NameNumFiles(:,1));
% ----------------

MSE=mean((y_real'-ForecastValue).^2);
plot(ForecastValue,'r');
hold on;
plot(y_real,'g');
legend('Ԥ��ֵ','��ʵֵ','Location','NorthWest');
toc;

