% Summarized statistical processing includes: averaging and boxplot skills
%%
a1 = [702 726 700 732.2 732.3 702.4 700.3 978.2 600.3 680.8];
a2 = [153.1 159.2 365.2 150.1 153.2 120.4 460.2 235.4 237.2 170.4];
b1 = [536.2 514 519.8 512.3 520.2 504.6 422.7 405.8 393.4 702.3 687.6];
b2 = [203 0.628 17.68 13.16 11.38 22.83 14.50 98.45 11.38 28.87 10.47];
c1 = [650.7 606.8 523.7 484.6 648 622.3 642.8 595.6 744 781];
c2 = [1.63 1.824 1.472 2.301 2.302 13.20 14.76 5.643 0.418 2.343];
d1 = [1400 1106 1043 1120 955 1106 1046 1080 1430 1108];
d2 = [0.038 0.026 0.012 0.016 0.011 0.023 0.01 0.023 0.028 0.012];
a3 = log(a2./a1);
b3 = log(b2./b1);
c3 = log(c2./c1);
d3 = log(d2./d1);

%% Image Post-Processing for Scattering Map
usp_p = usp;
usp_p(usp_p<=0) = -1;
usp_p(usp_p>20) = 20;
figure,imagesc(usp_p);colormap(jet);colorbar;

%% Jet Colormap
uspf = medfilt2(usp_p,[5 5]);
figure,imagesc(uspf);colormap(jet);colorbar;%caxis([-1 20]);
set(gca,'fontsize',20);

%%
partTiO2(1:500,:) = usp_p(501:1000,:);
aveTiO2 = sum(partTiO2)./500;
figure,plot(aveTiO2);set(gca,'fontsize',20)

%%
part13 = usp_p(1:500,:); part11 = usp_p(501:1000,:); part31 = usp_p(1001:1500,:);
ave13 = sum(part13)./500;
figure,plot(ave13);set(gca,'fontsize',20)
mean13all_nf = mean(part13(:));
ave11 = sum(part11)./500;
figure,plot(ave11);set(gca,'fontsize',20)
mean11all_nf = mean(part11(:));
ave31 = sum(part31)./500;
figure,plot(ave31);set(gca,'fontsize',20)
mean31all_nf = mean(part31(:));

%%
ave = sum(apart13(:,1:1000))'./500; noth = sum(npart13(:,1:1000))'./500; wave = sum(wpart13(:,1:1000))'./500;
%%
csvwrite('part13.csv',[measure13,wave13,ave13,noth13]);
%%
wave = NaN(1000,4); ave = NaN(1000,4); noth = NaN(1000,4);
%%
position_ave = [1.5251 3.462 5.8091 11.3716]-0.54;
box_measure = boxplot(ave,'colors','m','positions',position_ave,'width',0.3);
h=findobj(gca,'tag','Outliers');
delete(h);
set(gca,'XTickLabel',{' '})  % Erase xlabels   
hold on 

position_wave = position_ave+0.36;
box_wavelet = boxplot(wave,'colors','b','positions',position_wave,'width',0.3);
h=findobj(gca,'tag','Outliers');
delete(h)
set(gca,'XTickLabel',{' '})  % Erase xlabels   
hold on 

position_noth = position_ave+1.08;
box_nothing = boxplot(noth,'colors','k','positions',position_noth,'width',0.3);
h=findobj(gca,'tag','Outliers');
delete(h)
set(gca,'XTickLabel',{' '})  % Erase xlabels   
hold on

position_measure = position_ave+0.72;
box_average = boxplot(measure,'colors','r','positions',position_measure,'width',0.3);
h=findobj(gca,'tag','Outliers');
delete(h)
set(gca,'XTickLabel',{' '})  % Erase xlabels   
hold on 

axis([0 15 0 20])
xlabel('True extinction coeff, mu_t (mm^{-1})')
ylabel('Extinction coeff, mu_t (mm^{-1})')

text('Position',[1.5251,-0.5],'String','1.5251','FontSize',20,'FontWeight','bold') 
text('Position',[3.462,-0.5],'String','3.462','FontSize',20,'FontWeight','bold') 
text('Position',[5.8091,-0.5],'String','5.8091','FontSize',20,'FontWeight','bold') 
text('Position',[11.3716,-0.5],'String','11.3716','FontSize',20,'FontWeight','bold') 

set(gca, 'ActivePositionProperty', 'position', 'FontWeight','bold','FontSize',20,'LineWidth',2);
set(findobj(gca,'type','line'),'linew',2); %set(gca,'fontsize',10);
legend([box_measure(5,1),box_wavelet(5,1),box_average(5,1),box_nothing(5,1)], {'Average','Wavelet','Measurement','Rawdata'},'Location','northwest','FontSize',20)
hline = refline([1 0]);
set(hline,'LineStyle','--','linew',2)
hline.Color='r';
%%
g = [ones(size(measure13)); 2*ones(size(wave13)); 3*ones(size(ave13)); 4*ones(size(noth13))];
x = [measure13;wave13;ave13;noth13];

% figure, boxplot(x,g,'labels',{'measurement','wavelet','average','rawdata'});
% figure, boxplot(x,g,'labels',{'measurement','wavelet','average','rawdata','measurement','wavelet','average','rawdata','measurement','wavelet','average','rawdata','measurement','wavelet','average','rawdata'});
figure, boxplot(x,g,'labels',{'1','1','1','1','2','2','2','2','3','3','3','3','4','4','4','4'});
set(gca, 'ActivePositionProperty', 'position', 'FontWeight','bold','FontSize',20,'LineWidth',2);
set(findobj(gca,'type','line'),'linew',3); %set(gca,'fontsize',10);

a = get(get(gca,'children'),'children');   % Get the handles of all the objects
t = get(a,'tag');   % List the names of all the objects 
box1 = a(36:4:48);
set(box1, 'Color', 'g');   % Set the color of the first box to green
box2 = a(34:4:46); set(box2, 'Color', 'm');
box3 = a(33:4:45); set(box3, 'Color', 'c');

hLegend = legend(findall(gca,'Tag','Box'), {'Raw Data','Average','Wavelet','Measurement'}, 'Location', 'northwest', 'FontSize', 20);