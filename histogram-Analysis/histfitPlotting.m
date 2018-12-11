% select input data and load it
[File_Name,PathName] = uigetfile('*.mat*','Select Input Data');
load([PathName,File_Name]);

us_cal = us(:);
us_cal(us_cal<0.5|us_cal>19.5) = [];

figure,histfit(us_cal);
title('Benign');
xlabel('Scattering coefficient (mm^{-1})'); ylabel('Probability density');
xlim([0,20]);
set(gca,'fontsize',20);
yt = get(gca, 'YTick');
digits(2);
set(gca, 'YTick', yt, 'YTickLabel', single(vpa(yt/numel(us_cal))));