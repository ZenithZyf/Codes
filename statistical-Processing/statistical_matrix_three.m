% statistical analysis and box plot for matrix-structure-input with two different status

% =====================================================================================
%                               Variables Initialization
% =====================================================================================

%%%
% input parameter for statistical analysis
% the input should be formatted under the rule of:
    % 1. columns represent the parts cropped from the patient of the corresponding row
    % 2. cancer information saved to row 2*patientID-1 and benign saved to the others
    % 3. it should be matrix but not cell structure
input_arg = us_ave;

% name for the figure, please capitalize all characters 
fig_name = 'Average us';

% path for saving the final box plot
fpath = 'E:\Yifeng Zeng\!PhD Work\Projects\OCT\Ovary-Data-Processing\! Final-Processing\~Scattering-Map\quantification';

% name of the saved boxplot
jpgname = [lower(fig_name),' with tube.jpg'];
%%%

% =====================================================================================
%                    Sort Data to Two Status from the Formatted Input
% =====================================================================================

% get the size of the input, representing cropped parts and patient status
a = size(input_arg,2);
b = size(input_arg,1);

% get the information of cancerous samples
    % if the sample is cancer, it will be saved to the corresponding row of statC
    % otherwise, it will be saved as empty vector
for i = 1:3:a
    usProcess = [];
    for j = 1:b
        testData = input_arg(j,i);
        if testData == 0
            continue;
        else
            usProcess(j)=testData;
        end
    end
    statC{fix(i/2)+1} = usProcess;
end
nonEmptyIndex = find(~cellfun(@isempty,statC));
stat_cancer = [];
for index = 1:size(nonEmptyIndex,2)
    stat_cancer = [stat_cancer,statC{nonEmptyIndex(index)}];
end
stat_cancer = stat_cancer';


% get the information of benign samples
    % if the sample is benign, it will be saved to the corresponding row of statB
    % otherwise, it will be saved as empty vector
for i = 2:3:a
    usProcess = [];
    for j = 1:b
        testData = input_arg(j,i);
        if testData == 0
            continue;
        else
            usProcess(j)=testData;
        end  
    end
    statB{fix(i/2)+1} = usProcess;
end
nonEmptyIndex = find(~cellfun(@isempty,statB));
stat_benign = [];
for index = 1:size(nonEmptyIndex,2)
    stat_benign = [stat_benign,statB{nonEmptyIndex(index)}];
end
stat_benign = stat_benign';

% get the information of tube samples
    % if the sample is tube, it will be saved to the corresponding row of statB
    % otherwise, it will be saved as empty vector
for i = 3:3:a
    usProcess = [];
    for j = 1:b
        testData = input_arg(j,i);
        if testData == 0
            continue;
        else
            usProcess(j)=testData;
        end  
    end
    statT{fix(i/2)+1} = usProcess;
end
nonEmptyIndex = find(~cellfun(@isempty,statT));
stat_tube = [];
for index = 1:size(nonEmptyIndex,2)
    stat_tube = [stat_tube,statT{nonEmptyIndex(index)}];
end
stat_tube = stat_tube';

% calculate the p-value
[h,p_value] = ttest2(stat_cancer,stat_benign);
s_p_value = num2str(p_value);

% =====================================================================================
%                            Generate the Final Plot
% =====================================================================================

% initialization for two status
g = [ones(size(stat_cancer)); 2*ones(size(stat_benign)); 3*ones(size(stat_tube))];
x = [stat_cancer; stat_benign; stat_tube];

% plot the box plot
figure, 
boxplot(x,g,'labels',{'cancer','benign','tube'});

% plot the data points of each case
hold on; 
plot(1,stat_cancer,'x','MarkerSize',20); 
hold on; 
plot(2,stat_benign,'o','MarkerSize',20);
hold on; 
plot(3,stat_tube,'s','MarkerSize',20);

% label the plot
yMin = min([min(stat_benign)-1,min(stat_cancer)-1,min(stat_tube)-1]);
yMax = max([max(stat_benign)+1,max(stat_cancer)+1,max(stat_tube)+1]);
% yMin = 0; yMax = 0.3;
ylabel(lower(fig_name)); ylim([yMin yMax]);
set(gca, 'ActivePositionProperty', 'position', 'FontWeight','bold',...
    'FontSize',20,'LineWidth',2);
set(findobj(gca,'type','line'),'linew',3); %set(gca,'fontsize',10);
text('Position',[1.38,yMax*19/20],'String',['p = ',s_p_value],...
    'FontSize',20,'FontWeight','bold');
% hline = refline([0 0.5]); set(hline,'LineStyle','--','linew',2); hline.Color = 'black';
% hline = refline([0 6.1]); set(hline,'LineStyle','--','linew',2); hline.Color = 'black';
title(fig_name);

pause(0.00001);
frame_h = get(handle(gcf),'JavaFrame');
set(frame_h,'Maximized',1);
saveas(gcf,fullfile(fpath,jpgname));