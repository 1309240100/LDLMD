function [ prediction ] = result( bata,k )
%RESULT ͨ��������ģ�ͣ���miRNA��L_D������Ԥ��
%   
load AML;
load AMD;
load SL;
load SD;
load lncRNA;
load disease;
A1=AML';
A2=AMD;
A=A1*A2;
if (k==2)
    S=bata*A+bata.^2*(SL*A+A*SD);
    else if (k==3)
        S=bata*A+bata.^2*(SL*A+A*SD)+bata.^3*(A*A'*A+SL*SL*A+SL*A*SD+A*SD*SD);
        else if (k==4)
            S=bata*A+bata.^2*(SL*A+A*SD)+bata.^3*(A*A'*A+SL*SL*A+SL*A*SD+A*SD*SD)+bata.^4*(SL^3*A+A*A'*SL*A+SL*A*A'*A+A*SD*A'*A)+bata.^2*(A*A'*A*SD+SL^2*A*SD+SL*A*SD^2+A*SD^3);
        end
    end
end
    prediction=[];%�������Ԥ��������һ����ÿһ��L_D�õ��ķ������ڶ�����lncRNA���±꣬�ڶ�����disease���±�
    [row,col]=size(S);
    for i=1:col
        prediction=[prediction;S(:,i)];
    end
    predictionlncRNA=[];
    for i=1:col
        predictionlncRNA=[predictionlncRNA,1:row];
    end
    prediction(:,2)=predictionlncRNA';
    predictiondisease=[];
    for i=1:col
        predictiondisease=[predictiondisease;i.*ones(row,1)];
    end
    prediction(:,3)=predictiondisease;
    prediction=sortrows(prediction,-1);
   
    save('prediction_result.mat','prediction');
end

