x=-10:0.001:10;
sigmoid=1./(1+exp(-x));
sigmoidDer=exp(-x)./(1+exp(-x).^2);
figure;
plot(x,sigmoid,'r',x,sigmoidDer,'b--');
axis([-10 10 -1 1]);
grid on;
title('Sigmoid函数（实线）及其导数（虚线）');
legend('Sigmoid原函数','Sigmoid导数');
set(gcf,'NumberTitle','off');
set(gcf,'Name','Sigmoid函数（实线）及其导数（虚线）');

x=-10:0.001:10;
tanh=(exp(x)-exp(-x))./(exp(x)+exp(-x));
tanhDer=1-tanh.^2;
figure;
plot(x,tanh,'r',x,tanhDer,'b--');
grid on;
title('tanh函数（实线）及其导数（虚线）');
legend('tanh原函数','tanh导数');
set(gcf,'NumberTitle','off');
set(gcf,'Name','tanh函数（实线）及其导数（虚线）');

x=-10:0.001:10;
relu=max(0,x);
reluDer=0.*(x<0)+1.*(x>=0);
figure;
plot(x,relu,'r',x,reluDer,'b--');
title('Relu函数max(0,x)(实线）及其导数0,1（函数）');
legend('Relu原函数','Relu导数');
set(gcf,'NumberTitle','off');
set(gcf,'Name','Relu函数（实线）及其导数（虚线）');


