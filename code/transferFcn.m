x=-10:0.001:10;
sigmoid=1./(1+exp(-x));
sigmoidDer=exp(-x)./(1+exp(-x).^2);
figure;
plot(x,sigmoid,'r',x,sigmoidDer,'b--');
axis([-10 10 -1 1]);
grid on;
title('Sigmoid������ʵ�ߣ����䵼�������ߣ�');
legend('Sigmoidԭ����','Sigmoid����');
set(gcf,'NumberTitle','off');
set(gcf,'Name','Sigmoid������ʵ�ߣ����䵼�������ߣ�');

x=-10:0.001:10;
tanh=(exp(x)-exp(-x))./(exp(x)+exp(-x));
tanhDer=1-tanh.^2;
figure;
plot(x,tanh,'r',x,tanhDer,'b--');
grid on;
title('tanh������ʵ�ߣ����䵼�������ߣ�');
legend('tanhԭ����','tanh����');
set(gcf,'NumberTitle','off');
set(gcf,'Name','tanh������ʵ�ߣ����䵼�������ߣ�');

x=-10:0.001:10;
relu=max(0,x);
reluDer=0.*(x<0)+1.*(x>=0);
figure;
plot(x,relu,'r',x,reluDer,'b--');
title('Relu����max(0,x)(ʵ�ߣ����䵼��0,1��������');
legend('Reluԭ����','Relu����');
set(gcf,'NumberTitle','off');
set(gcf,'Name','Relu������ʵ�ߣ����䵼�������ߣ�');

