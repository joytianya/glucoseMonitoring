
function [net,tr]=trainNet(normInput,normTarget)
net=feedforwardnet([70,70]);
net.divideParam.trainRatio=0.8;
net.divideParam.testRatio=0.1;
net.divideParam.valRatio=0.1;
net.trainFcn='trainlm';
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn= 'tansig';
net.layers{3}.transferFcn= 'tansig';
net.trainParam.goal=1e-6;
net.trainParam.epochs=20;
net.trainParam.mu=0.01;
net.trainParam.max_fail=100;
[net,tr]=train(net,normInput,normTarget);
end







