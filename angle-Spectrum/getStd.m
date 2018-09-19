for i = 1:2:18
    stdRmseC = [];
    for j = 1:4
%         testData = rmseFitRes{j,i};
        testData = angleSpectrumIndex(j,i);
%         if isempty(testData)
        if testData == 0
            continue;
        else
            stdRmseC(j)=testData;
        end
%         if i == 3
%             continue;
%         end
%         testData = testData./max(testData);
%         stdRmseC(j,i)=std(testData);
    end
    stdRmseAveC(i) = mean(stdRmseC);
end
stdCancer = stdRmseAveC(:);
stdCancer(stdCancer==0)=[];

%%
for i = 2:2:18
    stdRmseN = [];
    for j = 1:4
        testData = angleSpectrumIndex(j,i);
%         testData = rmseFitRes{j,i};
%         if isempty(testData)
        if testData == 0
            continue;
        else
            stdRmseN(j)=testData;
        end
%         if i == 10 && j == 2
%             continue;
%         end
%         testData = testData./max(testData);
%         stdRmseN(j,i)=std(testData);     
    end
    stdRmseAveN(i) = mean(stdRmseN);
end
stdNormal = stdRmseAveN(:);
stdNormal(stdNormal==0)=[];

%%
g = [ones(size(stdCancer)); 2*ones(size(stdNormal)); 3*ones(size(stdPolyp))];
x = [stdCancer; stdNormal; stdPolyp];
% figure, boxplot(x);
figure, boxplot(x,g,'labels',{'cancer','normal','polyp'});
hold on; plot(1,stdCancer,'o','MarkerSize',20); hold on; plot(2,stdNormal,'x','MarkerSize',20);
hold on; plot(3,stdPolyp,'+','MarkerSize',20);
ylabel('ASI'); ylim([0.2 0.8]);
set(gca, 'ActivePositionProperty', 'position', 'FontWeight','bold','FontSize',20,'LineWidth',2);
set(findobj(gca,'type','line'),'linew',3); %set(gca,'fontsize',10);
text('Position',[1.38,0.76],'String','p=7.2348e-12','FontSize',20,'FontWeight','bold');
hline = refline([0 0.5]); set(hline,'LineStyle','--','linew',2); hline.Color = 'black';
hline = refline([0 0.6]); set(hline,'LineStyle','--','linew',2); hline.Color = 'black';
title('Angle Spectrum Index');

% j = [ones(size(sdcancer)); 2*ones(size(sdnormal))];
% y = [sdcancer; sdnormal];
% % figure, boxplot(x);
% figure, boxplot(y,j,'labels',{'cancer','normal'});
% set(gca, 'ActivePositionProperty', 'position', 'FontWeight','bold','FontSize',20,'LineWidth',2);
% set(findobj(gca,'type','line'),'linew',3); %set(gca,'fontsize',10);
% text('Position',[1.4,237],'String','p=0.1497','FontSize',20,'FontWeight','bold');
% title('Gaussian fitting standard deviation');