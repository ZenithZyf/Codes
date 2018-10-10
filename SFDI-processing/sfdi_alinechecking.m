phantom1 = phantom(240,:,1,1);
phantom2 = phantom(240,:,1,2);
phantom3 = phantom(240,:,1,3);

figure, plot(phantom1); hold on
plot(phantom2); hold on
plot(phantom3); hold off

%%
phantom_DC = (phantom1+phantom2+phantom3)./3;
figure, plot(phantom_DC);

phantom_AC = (sqrt(2)./3).*sqrt((phantom1-phantom2).^2+(phantom2-phantom3).^2+(phantom3-phantom1).^2);
figure, plot(phantom_AC);

%%
tissue1 = tissue(240,:,1,1);
tissue2 = tissue(240,:,1,2);
tissue3 = tissue(240,:,1,3);

figure, plot(tissue1); hold on
plot(tissue2); hold on
plot(tissue3); hold off

%%
tissue_DC = (tissue1+tissue2+tissue3)./3;
figure, plot(tissue_DC);

tissue_AC = (sqrt(2)./3).*sqrt((tissue1-tissue2).^2+(tissue2-tissue3).^2+(tissue3-tissue1).^2);
figure, plot(tissue_AC);

%%
rd_dc = tissue_DC./phantom_DC.*0.7530;
rd_ac = tissue_AC./phantom_AC.*0.2255;

figure, plot(rd_dc); hold on
plot(rd_ac);

%%
figure, plot(phantom_DC); hold on
plot(tissue_DC); hold on;

figure, plot(phantom_AC); hold on
plot(tissue_AC); hold on;
plot(rd_ac*100);

%%
tissue_DC_crop = tissue_DC(1,41:end);
phantom_DC_crop = phantom_DC(1,1:end-40);
rd_dc_crop = tissue_DC_crop./phantom_DC_crop.*0.7530;

figure, plot(tissue_DC_crop); hold on
plot(phantom_DC_crop);
figure, plot(rd_dc_crop);

%%
[up, low] = envelope(phantom1,300);
phantom1_cal = phantom1./up;
tissue1_cal = tissue1./up;
[up, low] = envelope(phantom2,300);
phantom2_cal = phantom2./up;
tissue2_cal = tissue2./up;
[up, low] = envelope(phantom3,300);
phantom3_cal = phantom3./up;
tissue3_cal = tissue3./up;

figure, plot(phantom1_cal); hold on
plot(phantom2_cal); hold on
plot(phantom3_cal); hold off

figure, plot(tissue1_cal); hold on
plot(tissue2_cal); hold on
plot(tissue3_cal); hold off

%%
phantom_DC_cal = (phantom1_cal+phantom2_cal+phantom3_cal)./3;
phantom_AC_cal = (sqrt(2)./3).*sqrt((phantom1_cal-phantom2_cal).^2+(phantom2_cal-phantom3_cal).^2+(phantom3_cal-phantom1_cal).^2);

tissue_DC_cal = (tissue1_cal+tissue2_cal+tissue3_cal)./3;
tissue_AC_cal = (sqrt(2)./3).*sqrt((tissue1_cal-tissue2_cal).^2+(tissue2_cal-tissue3_cal).^2+(tissue3_cal-tissue1_cal).^2);


figure, plot(phantom_DC_cal); hold on
plot(tissue_DC_cal); hold off
figure, plot(phantom_AC_cal); hold on
plot(tissue_AC_cal); hold off

%%
rd_dc_cal = tissue_DC_cal./phantom_DC_cal.*0.7530;
rd_ac_cal = tissue_AC_cal./phantom_AC_cal.*0.2255;

figure, plot(rd_dc_cal); hold on
plot(rd_ac_cal);
