function [NameNumFiles,ForcastValueMean]=forecast(Dir_data,Dir_Net)
% 暂时冻结提取特征值
if ~exist([Dir_data,'eigenvalue\Eigenvalue.csv'],'file')
   eigenvalueExtract(Dir_data);
end
% -------------------------------------
numMeasurementFiles=[Dir_data,'labels/LabelsToFiles.xlsx'];
numMeasurement=xlsread(numMeasurementFiles,2);
ForcastValueMean=[];
NameNumFiles=[];
load([Dir_Net,'Net/ForcastNet.mat']);
toForecastFile=[Dir_data,'eigenvalue/Eigenvalue.csv'];
data_toForecast=dlmread(toForecastFile);
for i = 2:length(numMeasurement)
    str=numMeasurement(i,1)*10;
    End=(numMeasurement(i,2)+1)*10-1;
    data_seg=data_toForecast(data_toForecast(:,1)>=str&data_toForecast(:,1)<=End,2:end);
% x_toForecast=data_toForecast(:,2:end);

% normInput_toForecast=x_toForecast';
    normInput_toForecast=mapminmax.apply(data_seg',ps_x);
    normForecastValue=sim(net,normInput_toForecast);
% ForcastValue=normForecastValue;
    ForcastValue=mapminmax('reverse',normForecastValue,ps_y);
%     a=ones(1,length(ForcastValue))*mean(ForcastValue');
    ForcastValueMean=[ForcastValueMean,ones(1,length(ForcastValue))*mean(ForcastValue')];
    NameNumFiles=[NameNumFiles;data_toForecast(data_toForecast(:,1)>=str&data_toForecast(:,1)<=End,1)];
end
ForcastValueMean=ForcastValueMean';
% NameNumFiles=data_toForecast(:,1);
end