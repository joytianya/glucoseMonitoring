function [net,tr,ps_x,ps_y]=train(Dir)
% trainFile='C:\Users\xuanwei\Desktop\论文编写参看文献\建模+预测\建模\0528实验数据_林于悦\eigenvalue\Eigenvalue.csv';
fclose('all');
%暂时不进行提取特征值
if ~exist([Dir,'eigenvalue\Eigenvalue.csv'],'file')
   eigenvalueExtract(Dir);
end
% -----------------------------
trainFile=[Dir,'eigenvalue\Eigenvalue.csv'];
LabelsFiles=[Dir,'labels\LabelsToFiles.xlsx'];
data_train=dlmread(trainFile);
NameNumFiles=data_train(:,1);
x_train=data_train(:,2:end);
%--------------------------------------------------------------
LabelsToFiles=xlsread(LabelsFiles,1);
LabelsArray=[];
LabelsArray(LabelsToFiles(2:end,1))=LabelsToFiles(2:end,2);
y_train=LabelsArray(NameNumFiles(:,1));
%--------------------------------------------------------------
[normInput_train,ps_x]=mapminmax(x_train');
[normTarget_train,ps_y]=mapminmax(y_train);
% normInput_train=x_train';
% normTarget_train=y_train;
[net,tr]=trainNet(normInput_train,normTarget_train);
save([Dir,'Net\ForcastNet'],'net','tr','ps_x','ps_y');
% save([Dir,'ForcastNet'],'net','tr');
end