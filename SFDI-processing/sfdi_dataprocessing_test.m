folder_ovary = 'C:\Users\OCT-PC\Desktop\SFDI-TEST\patient5ovary';
folder_colon2 = 'C:\Users\OCT-PC\Desktop\SFDI-TEST\patientcolon';
folder_colon = 'C:\Users\OCT-PC\Desktop\SFDI-TEST\20180926-Colon-Patient152';

folder_name = folder_ovary;
% frequencies of our modality
mod_freq = ["0","120","240"];
freq_num = size(mod_freq,2);
% wavelengths of our modality
wavelengths = [];
wavelength_num = 3;
% load lookup table
load 'C:\Users\OCT-PC\Desktop\SFDI-TEST\MuaI.mat'
load 'C:\Users\OCT-PC\Desktop\SFDI-TEST\MuspI.mat'
% load lookup table parameters
load 'C:\Users\OCT-PC\Desktop\SFDI-TEST\interPara.mat'
% load name of the processing list from the folder
list      = dir(folder_name);
size_list = size(list,1);
for i = 3:size_list
    category_case(i-2) = string(list(i).name);
end
category_case(category_case=='Phantom') = [];
% the folder where the reference images locate
folder_Phantom = [folder_name,'\','Phantom'];

i = 1;
folder_tissue = fullfile(folder_name,category_case(i));

for j = 1:wavelength_num
    for k = 1:freq_num
%         img_name  = join(['__',mod_freq(k),' degrees_LED#',j,'_1.bmp'],'');
%         phantom(:,:,j,k) = rgb2gray(imread(char(fullfile(folder_Phantom,img_name))));
%         tissue(:,:,j,k)  = rgb2gray(imread(char(fullfile(folder_tissue, img_name))));
% 
        img_name  = join(['__',mod_freq(k),' degrees_LED#',j,'_1.tiff'],'');
%         phantom(:,:,j,k) = imread(char(fullfile(folder_Phantom,img_name)));
%         tissue(:,:,j,k)  = imread(char(fullfile(folder_tissue, img_name)));

                pha = double(imread(char(fullfile(folder_Phantom,img_name))));
                tis = double(imread(char(fullfile(folder_tissue, img_name))));
                phantom(:,:,j,k) = pha./mean2(pha);
                tissue(:,:,j,k)  = tis./mean2(tis);
    end
end
phantom = double(phantom);
tissue  = double(tissue);

% process phantom images
mdcref   = sum(phantom,4)./freq_num;
% macref_o only can be applied to 3 modulated frequencies.
macref_o = (sqrt(2)./3).*(sqrt(sum((phantom-phantom(:,:,:,[2,3,1])).^2,4)));
% normalization method to avoid line (modulation) artifact
for j = 1:wavelength_num
    mod_ref(:,:,j) = ones(size(mdcref(:,:,1))).*mean2(mdcref(:,:,j))./mean2(macref_o(:,:,j));
end
% macref    = mdcref./mod_ref;
macref    = macref_o;

% process tissue images
mdctis   = sum(tissue,4)./freq_num;
mactis_o = (sqrt(2)./3).*(sqrt(sum((tissue-tissue(:,:,:,[2,3,1])).^2,4)));
for j = 1:wavelength_num
    mod_tis(:,:,j) = ones(size(mdctis(:,:,1))).*mean2(mdctis(:,:,j))./mean2(mactis_o(:,:,j));
end
% mactis   = mdctis./mod_tis;
mactis   = mactis_o;

% calculate corresponding Rd_DC and Rd_AC
% 0.7530 is the theoretical phantom Rd_DC from diffuse_equa.m
% Rd_DC = (mdctis./mdcref_mean).*0.7530;
Rd_DC = (mdctis./mdcref).*0.7530;
%         Rd_DC = (mdctis./mdcref);
%         Rd_DC = Rd_DC./max(max(Rd_DC)).*0.7530;
% 0.2255 is the theoretical phantom Rd_AC from diffuse_equa.m
% Rd_AC = (mactis./macref_mean).*0.2255;
Rd_AC = (mactis./macref).*0.2255;
%         Rd_AC = (mactis./macref);
%         Rd_AC = Rd_AC./max(max(Rd_AC)).*0.2255;

row_image     = size(Rd_DC, 1);
column_image  = size(Rd_DC, 2);
Mua_result    = zeros(row_image, column_image);
Musp_result   = zeros(row_image, column_image);

beyond_counter = 0;

for wl = 1:wavelength_num
    for r = 1:row_image
        for c = 1:column_image
            Rdc = Rd_DC(r,c,wl);
            Rac = Rd_AC(r,c,wl);
            col = fix((Rdc-DCMin)./inter_step+1);
            row = fix((Rac-ACMin)./inter_step+1);

            if(row>0 && row<=size(MuaI,1) && col>0 && col<=size(MuaI,2))
                Mua  = MuaI(row,col);
                Musp = MuspI(row,col);

                Mua_result(r,c,wl)  = Mua;
                Musp_result(r,c,wl) = Musp;
            else
                beyond_counter = beyond_counter+1;
            end
        end
    end
end

% Rd1 = Rd_DC;
% Rd2 = Rd_AC;
% row_image = size(Rd1, 1);
% column_image = size(Rd1, 2);
% Mua_result530 = zeros(row_image, column_image);
% Musp_result530 = zeros(row_image, column_image);
% beyond_counter = 0;
% for i = 1:row_image
%     for j = 1:column_image
%         r1 = Rd1(i,j);
%         r2 = Rd2(i,j);
%         column =  fix((r1-0.0001)/0.001 + 1);
%         row = fix((r2-0.0001)/0.001 + 1);
%         
%         if((row>0 && row <= size(Muaq,1))&&(column > 0 && column <= size(Muaq, 2)))
%             Mua = Muaq(row, column);
%             Musp = Muspq(row, column);
%             Mua_result530(i,j) = Mua;
%             Musp_result530(i,j) = Musp;
%         else
%             beyond_counter = beyond_counter + 1;
%        end
%     end
% end

figure, imagesc(Mua_result(:,:,1)), colormap('jet'), colorbar;
figure, imagesc(Musp_result(:,:,1)), colormap('jet'), colorbar;
% figure, imagesc(Mua_result530), colormap('jet'), colorbar;
% figure, imagesc(Musp_result530), colormap('jet'), colorbar;