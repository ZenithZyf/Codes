mean_velocity = [0.2574, 0.1225, 0.1787]; % mean velocity
mean_velocity2 = [0.5, 0.6, 0.7];
std_velocity = [0.3314, 0.2278, 0.2836];  % standard deviation of velocity
figure
hold on
bar(1:3,mean_velocity,'r')
bar(7:9,mean_velocity2)
errorbar(1:3,mean_velocity,std_velocity,'.')
errorbar(7:9,mean_velocity2,std_velocity,'.')

%%
ave_m = mean(ave);
ave_s = std(ave);
not_m = mean(nothing);
not_s = std(nothing);
wlt_m = mean(wave);
wlt_s = std(wave);
mea_m = nanmean(measure);
mea_s = nanstd(measure);

%%
y = [ave_m,wlt_m,mea_m',not_m];
z = [ave_s,wlt_s,mea_s',not_s];
x = [1.5251,3.462,5.8091,11.0443];
x0 = [0.62,3.22,6.41,8.03];

figure,
% Creating axes and the bar graph
ax = axes;
h = bar(x0-0.352+0.1761,y,'BarWidth',1,'LineWidth',2);
h(1).FaceColor = [0.75,0.75,0.75];
h(2).FaceColor = [117/255,187/255,253/255];
h(3).FaceColor = 'r';
h(4).FaceColor = [0.61,0.51,0.74];
hold on;

% hline = refline([1 0]);
% set(hline,'LineStyle','--','linew',2)
% hline.Color='r';

% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';
set(gca,'XTick',x0,'FontSize',25);
ylabel('Scattering coefficient \mu_s (mm^{-1})');
xlabel('True scattering coefficient \mu_s (mm^{-1})');

% Finding the number of groups and the number of bars in each group
ngroups = size(y, 1);
nbars = size(y, 2);

% Creating a legend and placing it outside the bar plot
lg = legend('Average','Wavelet','Measurement','Rawdata','AutoUpdate','off');
lg.Location = 'NorthWest';
lg.Orientation = 'Vertical';

% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
% Set the position of each error bar in the centre of the main bar
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x_pos = h(i).XData+h(i).XOffset;
    errorbar(x_pos, y(:,i), z(:,i), 'k', 'linestyle', 'none', 'linewidth', 2);
end

%%
figure,
hold on

bar(1:5:16, ave_m, 'r');
errorbar(1:5:16, ave_m, ave_s, '.');

bar(2:5:17, not_m, 'b');
errorbar(2:5:17, not_m, not_s, '.');

bar(3:5:18, wlt_m, 'y');
errorbar(3:5:18, wlt_s, '.');

bar(4:5:19, mea_m, 'm');
errorbar(4:5:19, mea_s, '.');