
function [Z]=findOppsiteIndexInOneWave(X,Y)
Z_temp=zeros(1,14);
j=1;
NumsofOppsite=0;
for i=1:length(X)-1
    if (X(i)+0.01)*(X(i+1)+0.01)<0
        NumsofOppsite=NumsofOppsite+1;
        Z_temp(j)=i+1;
        Z_temp(j+1)=Y(i+1);
        j=j+2;
    end
    if NumsofOppsite>=length(Z_temp)/2
        break
    end
end
Z=Z_temp;
end