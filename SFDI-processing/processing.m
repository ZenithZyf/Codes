function[Mua_result, Musp_result] = processing(folder_name)
%%% This is the processing code for calculation of mua & mus
% folder_name should be the folder on the higher level of 'Cancer', 'Normal', 'Phantom' etc.
% please name the folder that contain the phantom data as 'Phantom' so that this code can recognize it.
% please name the other folder as the diagnose name that you want to present

    % frequencies of our modality
    mod_freq = ["0","120","240"];
    freq_num = size(mod_freq,2);
    % wavelengths of our modality
    wavelengths = [];
    wavelength_num = 3;
    
    % load lookup table and parameters
%     load 'F:\Projects\SFDI\MuaI.mat'
%     load 'F:\Projects\SFDI\MuspI.mat'
    load 'F:\Projects\SFDI\fsolveTable.mat'
%     load 'F:\Projects\SFDI\interPara.mat'

    % load name of the processing list from the folder
    list      = dir(folder_name);
    size_list = size(list,1);
    for i = 3:size_list
        category_case(i-2) = string(list(i).name);
    end
    category_case(category_case=='Phantom') = [];
    % the folder where the reference images locate
    folder_Phantom = [folder_name,'\','Phantom'];

    for i = 1:size(category_case,2)
        % the folder where the tissue images locate
        folder_tissue = fullfile(folder_name,category_case(i));
        for j = 1:wavelength_num
            for k = 1:freq_num
%                 img_name  = join(['__',mod_freq(k),' degrees_LED#',j,'_1.bmp'],'');
%                 pha = double(rgb2gray(imread(char(fullfile(folder_Phantom,img_name)))));
%                 tis = double(rgb2gray(imread(char(fullfile(folder_tissue, img_name)))));
                img_name  = join(['__',mod_freq(k),' degrees_LED#',j,'_1.tiff'],'');
%                 phantom(:,:,j,k) = imread(char(fullfile(folder_Phantom,img_name)));
%                 tissue(:,:,j,k)  = imread(char(fullfile(folder_tissue, img_name)));
                pha = double(imread(char(fullfile(folder_Phantom,img_name))));
                tis = double(imread(char(fullfile(folder_tissue, img_name))));
                phantom(:,:,j,k) = pha./mean2(pha);
                tissue(:,:,j,k)  = tis./mean2(tis);
            end
        end
%         phantom = double(phantom);
%         tissue  = double(tissue);

        % process phantom images
        mdcref   = sum(phantom,4)./freq_num;
        % macref_o only can be applied to 3 modulated frequencies.
        macref_o = (sqrt(2)./3).*(sqrt(sum((phantom-phantom(:,:,:,[2,3,1])).^2,4)));
        % normalization method to avoid line (modulation) artifact
%         for j = 1:wavelength_num
%             mod_ref(:,:,j) = ones(size(mdcref(:,:,1))).*mean2(mdcref(:,:,j))./mean2(macref_o(:,:,j));
%         end
%         macref   = macref_o.*mod_ref;
        macref    = macref_o;

        % process tissue images
        mdctis   = sum(tissue,4)./freq_num;
        mactis_o = (sqrt(2)./3).*(sqrt(sum((tissue-tissue(:,:,:,[2,3,1])).^2,4)));
%         for j = 1:wavelength_num
%             mod_tis(:,:,j) = ones(size(mdctis(:,:,1))).*mean2(mdctis(:,:,j))./mean2(mactis_o(:,:,j));
%         end
%         mactis   = mactis_o.*mod_tis;
        mactis   = mactis_o;

        % calculate corresponding Rd_DC and Rd_AC
        % 0.7530 is the theoretical phantom Rd_DC from diffuse_equa.m
        Rd_DC = (mdctis./mdcref).*0.7530;
%         Rd_DC = (mdctis./mdcref);
%         Rd_DC = Rd_DC./max(max(Rd_DC)).*0.7530;
        % 0.2255 is the theoretical phantom Rd_AC from diffuse_equa.m
        Rd_AC = (mactis./macref).*0.2255;
%         Rd_AC = (mactis./macref);
%         Rd_AC = Rd_AC./max(max(Rd_AC)).*0.2255;

        row_image     = size(Rd_DC, 1);
        column_image  = size(Rd_DC, 2);
        Mua_result    = zeros(row_image, column_image);
        Musp_result   = zeros(row_image, column_image);

        beyond_counter = 0;

%         for wl = 1:wavelength_num
%             for r = 1:row_image
%                 for c = 1:column_image
%                     Rdc = Rd_DC(r,c,wl);
%                     Rac = Rd_AC(r,c,wl);
%                     col = fix((Rdc-DCMin)./inter_step+1);
%                     row = fix((Rac-ACMin)./inter_step+1);
% 
%                     if(row>0 && row<=size(MuaI,1) && col>0 && col<=size(MuaI,2))
%                         Mua  = MuaI(row,col);
%                         Musp = MuspI(row,col);
% 
%                         Mua_result(r,c,wl)  = Mua;
%                         Musp_result(r,c,wl) = Musp;
%                     else
%                         beyond_counter = beyond_counter+1;
%                     end
%                 end
%             end
%         end

        for wl = 1:wavelength_num
            for c = 1:column_image
                for r = 1:row_image
                    Rdc = Rd_DC(r,c,wl);
                    Rac = Rd_AC(r,c,wl);
                    col = fix((Rac-0.05)./step+1);
                    row = fix((Rdc-Rac-step)./step+1);

                    if(row>0 && row<=size(MuaF,1) && col>0 && col<=size(MuaF,2))
                        Mua  = MuaF(row,col);
                        Musp = MuspF(row,col);

                        Mua_result(r,c,wl)  = Mua;
                        Musp_result(r,c,wl) = Musp;
                    else
                        beyond_counter = beyond_counter+1;
                    end
                end
            end
        end
        
        Mua_savename  = fullfile(folder_name,category_case(i),'Mua.mat');
        Musp_savename = fullfile(folder_name,category_case(i),'Musp.mat');
        save(Mua_savename,'Mua_result');
        save(Musp_savename,'Musp_result');
    end
end


% % read phantom SFDI images
% a = imread('D:\SFDI\Patient5\Phantom\530\0.tiff');
% b = imread('D:\SFDI\Patient5\Phantom\530\120.tiff');
% c = imread('D:\SFDI\Patient5\Phantom\530\240.tiff');
% % d=imread('F:\Ovary_study\WashU_Ovary_Study\WashU_Ovary_SFD\SFD\Phantom\460\dc.tiff');

% % read patient SFDI images
% e = imread('D:\SFDI\Patient5\530\0.tiff');
% f = imread('D:\SFDI\Patient5\530\120.tiff');
% g = imread('D:\SFDI\Patient5\530\240.tiff');
% % h=imread('F:\Ovary_study\WashU_Ovary_Study\WashU_Ovary_SFD\SFD\Patient5\left\460\dc.tiff');

% % a1=double(a(10:800,100:1000));                     %convert to grayscale and crop%
% % b1=double(b(10:800,100:1000));
% % c1=double(c(10:800,100:1000));
% % % d1=double(d(10:100,100:1000));
% % e1=double(e(10:800,100:1000));
% % f1=double(f(10:800,100:1000));
% % g1=double(g(10:800,100:1000));
% a1=double(a);                     %convert to grayscale and crop%
% b1=double(b);
% c1=double(c);
% g1=double(g);
% e1=double(e);
% f1=double(f);


% figure,imshow(a1,[]);axis on;

%  % figure,imshow(b1,[]);
% % figure,imshow(c1,[]);
% %  figure,imshow(d1,[]);axis on;
% % figure,imshow(e1,[]);
% % figure,imshow(f1,[]);


 

% Mdcref=((a1)+(b1)+(c1))./3;                                                     %calculate ac & dc image%
% Macref1= (sqrt(2)./3).*(sqrt((((a1-b1).^2)+((b1-c1).^2)+((c1-a1).^2)))); %ac image containing modulation artifacts

% Modfref=mean2(Mdcref)./mean2(Macref1);                        %calculate to remove modulation artifact

% Macref=Mdcref./Modfref;                                      
% Mdc=((e1)+(f1)+(g1))./3;
% Mac1= (sqrt(2)./3).*(sqrt(double(((e1-f1).^2)+((f1-g1).^2)+((g1-e1).^2))));

% Modsampl= mean2(Mdc)./mean2(Mac1);
% Mac=Mdc./Modsampl;

% figure,imshow(Mdcref,[]);colormap hot;
% figure,imshow(Macref,[]);colormap hot;
% figure,imshow(Mdc,[]);colormap hot;
% figure,imshow(Mac,[]);colormap hot;
% Rd1=(Mdc./Mdcref);
% Rd1=Rd1./(max(max(Rd1))).*0.7643;
% % Rd1=Rd1.*1.1094;
% % Rd1=Rd1./max(max(Rd1));
% figure,imshow(Rd1,[]);colormap jet;
% Rd2=(Mac./Macref);
% Rd2=Rd2./(max(max(Rd2))).*0.2293;
% % Rd2=Rd2./max(max(Rd1));
% % Rd2=Rd2.*0.2796;
% figure,imshow(Rd2,[]);colormap jet;
% % phiref1=(sqrt(3).*(a1-c1)./(2.*b1-a1-c1));
% % phiref=atan2d(imag(phiref1),real(phiref1));
% % figure,imshow(phiref,[]);colormap hsv;

%     row_image = size(Rd1, 1);
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
% beyond_counter

% beyond_counter/row_image/column_image
% % Mua_result530=medfilt2(Mua_result530,[2 2]);
% % Musp_result530=medfilt2(Musp_result530,[2 2]);

% figure,imshow(Mua_result530,[]);colormap jet; 
% figure,imshow(Musp_result530,[]);colormap jet;

% save Mua530.mat Mua_result530;
% save Mus530.mat Musp_result530;