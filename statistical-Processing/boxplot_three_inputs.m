% statistical analysis and box plot for matrix-structure-input with two different status

% =====================================================================================
%                               Variables Initialization
% =====================================================================================

% creat the string of the features names
figure_name = ["Average \mu_s", 'Standard Deviation \mu_s', 'Scattering Map Entropy', ...
            'Histogram Skewness', 'Histogram Kurtosis', 'Histogram Energy'];

load('E:\Projects\OCT\Ovary-Data-Processing\! Final-Processing\~Scattering-Map\benign_features.mat');
load('E:\Projects\OCT\Ovary-Data-Processing\! Final-Processing\~Scattering-Map\cancer_features.mat');
load('E:\Projects\OCT\Ovary-Data-Processing\! Final-Processing\~Scattering-Map\tube_features.mat');

% 6 featrues
for ff = 4:9
%%
    index = ff-3;

    %%%
    % input parameter for statistical analysis
    % the input should be formatted under the rule of:
        % 1. first three rows represent patients' info and label: ID, cropped part, diagnose
        % 2. other rows saved the features for box plot
        % 3. it should be matrix
    benign_arg = benign_features(:,ff);
    cancer_arg = cancer_features(:,ff);
    tube_arg   = tube_features(:,ff);

    % remove outliers based on quartiles rule
    TF = isoutlier(benign_arg,'quartiles');
    benign_arg(TF) = [];
    TF = isoutlier(cancer_arg,'quartiles');
    cancer_arg(TF) = [];
    TF = isoutlier(tube_arg,'quartiles');
    tube_arg(TF) = [];
    
    TF = isoutlier(benign_arg,'quartiles');
    benign_arg(TF) = [];
    TF = isoutlier(cancer_arg,'quartiles');
    cancer_arg(TF) = [];
    TF = isoutlier(tube_arg,'quartiles');
    tube_arg(TF) = [];

    % name for the figure
    fig_name = figure_name(index);
    %%%

    % calculate the p-value
    [h,p_value] = ttest2(cancer_arg,benign_arg);
    s_p_value = num2str(p_value);
    [hc,p_valuec] = ttest2(cancer_arg,tube_arg);
    [hb,p_valueb] = ttest2(tube_arg,benign_arg);

% =====================================================================================
%                            Generate the Final Plot
% =====================================================================================

    % initialization for two status
    g = [ones(size(cancer_arg)); 2*ones(size(benign_arg)); 3*ones(size(tube_arg))];
    x = [cancer_arg; benign_arg; tube_arg];

    % plot the box plot
    figure, 
    boxplot(x,g,'labels',{'Cancer','Benign','Tube'});

    % plot the data points of each case
    hold on; 
    plot(1,cancer_arg,'x','MarkerSize',20); 
    hold on; 
    plot(2,benign_arg,'o','MarkerSize',20);
    hold on;
    plot(3,tube_arg,'+','MarkerSize',20);

    % label the plot
    if fig_name == "Histogram Energy"
        yMin = 0; yMax = 0.3;
    elseif fig_name == "Histogram Skewness"
        yMin = min(benign_arg)*(1/0.8);
        yMax = max([max(benign_arg)*1.2,max(cancer_arg)*1.2,max(tube_arg)*1.2]);
    else
        yMin = min([min(benign_arg)*0.8,min(cancer_arg)*0.8,min(tube_arg)*0.8]);
        yMax = max([max(benign_arg)*1.2,max(cancer_arg)*1.2,max(tube_arg)*1.2]);
    end

    ylabel(fig_name); ylim([yMin yMax]);
    set(gca, 'ActivePositionProperty', 'position', 'FontWeight','bold',...
        'FontSize',20,'LineWidth',2);
    set(findobj(gca,'type','line'),'linew',3); %set(gca,'fontsize',10);
    if p_value >= 0.001
        text('Position',[1.38,yMax*19/20],'String',['p = ',s_p_value],...
            'FontSize',20,'FontWeight','bold');
    else
        text('Position',[1.38,yMax*19/20],'String',['p << 0.001'],...
            'FontSize',20,'FontWeight','bold');
    end
    % hline = refline([0 0.5]); set(hline,'LineStyle','--','linew',2); hline.Color = 'black';
    % hline = refline([0 6.1]); set(hline,'LineStyle','--','linew',2); hline.Color = 'black';
    title(fig_name);
%%
end