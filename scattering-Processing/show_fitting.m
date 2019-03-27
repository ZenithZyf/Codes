figure,imshow(imgo(:,1:815));hold on
plot(surface(i,1:635)'+5,'Linewidth',3,'Color','r'); hold on;
plot(surface(i,1:635)'+55,'Linewidth',3,'Color','r'); hold on;
plot([73,73],[surface(i,73)+5,surface(i,73)+50],'Linewidth',3,'Color','b')
hold off; 

%%
figure,imshow(imgo(:,1:752));hold on
plot(surface(i,1:815)'+5,'Linewidth',3,'Color','r'); hold on;
plot(surface(i,1:815)'+55,'Linewidth',3,'Color','r'); hold on;
% plot([73,73],[surface(i,73)+5,surface(i,73)+50],'Linewidth',3,'Color','b')
hold off; 

%%
figure, plot(imgo(surface(i,73):surface(i,73)+260,73));
hold on;
% plot(coef);

%%
pixel = 1000; % pixel numbers per A-line
depth = 1.8; % mm
depth_step = double(depth/pixel);
z = ((1:size(fitrange,1)).*depth_step)';
img_p = 10.^(((double(fitrange)./10)+60)./20); 
logiz = log(img_p);
coef = fit(z(fitpoint),logiz(fitpoint),'poly1');
-coef.p1

%%
figure, plot(logiz);
hold on;
plot(fitpoint,coef.p1*z(fitpoint)+coef.p2);
xlabel('Depth(\mum)'); xlim([0 250]);
ylabel('Relative OCT Signal');
set(gca, 'ActivePositionProperty', 'position', 'FontWeight','bold','FontSize',25,'LineWidth',3);
set(findobj(gca,'type','line'),'linew',3); %set(gca,'fontsize',10);
legend({'Denoised A-line','Fitted Curve'},'Location','northeast','FontSize',25)