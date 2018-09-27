%%this code is for getting the R1 & R2 values for the phantom
%%Multiply with these two values in the processing code
clc
clear all
% % mua & musp are the pre-determined phantom values in mm-1
mua=0.003;
musp=0.8;
% % R1 is for zero frequency & R2 is for the other frequency (0.1 mm-1 in this example)
R1= (3.*.1792.*(musp/(mua+musp)))./((((sqrt(mua./(1./(3*(mua+musp)))))./(mua+musp))+1).*(((sqrt(mua./(1./(3*(mua+musp)))))./(mua+musp))+3.*.1792));
R2 = (3.*0.1792.*(musp/(mua+musp)))./((((sqrt((sqrt(mua./(1./(3*(mua+musp))))).^2+(2.*pi.*0.1).^2))./(mua+musp))+1).*(((sqrt((sqrt(mua./(1./(3*(mua+musp))))).^2+(2.*pi.*0.1).^2))./(mua+musp))+3.*0.1792));