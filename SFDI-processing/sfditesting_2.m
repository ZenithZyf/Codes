for i = 1:3
    for j = 1:3
        figure, imagesc(phantom(:,:,i,j)); colormap('jet'); colorbar;
%         figure, imagesc(tissue(:,:,i,j)); colormap('jet'); colorbar;
    end
end

%%
tissue_temp = tissue(1:700,250:1049,:,:);
tissue = tissue_temp;

%%
phantom_temp = phantom(1:700,250:1049,:,:);
phantom = phantom_temp;

%%
for i = 1:3
%     figure, imagesc(mdcref(:,:,i)); colormap('jet'); colorbar;
%     figure, imagesc(macref(:,:,i)); colormap('jet'); colorbar;
%     figure, imagesc(mdctis(:,:,i)); colormap('jet'); colorbar;
%     figure, imagesc(mactis(:,:,i)); colormap('jet'); colorbar;
%     figure, imagesc(Rd_DC(:,:,i)); colormap('jet'); colorbar;
%     figure, imagesc(Rd_AC(:,:,i)); colormap('jet'); colorbar;
end

%%
for i = 1:9
    figure, imagesc(Mua_result(:,:,i)), colormap('jet'), colorbar; caxis([0,0.08]);
    figure, imagesc(Musp_result(:,:,i)), colormap('jet'), colorbar; caxis([0,2]);
end

%%
figure, imagesc(MuaI);colormap('jet');colorbar;
figure, imagesc(MuspI);colormap('jet');colorbar;

%%
account = 1;
for Rac = 0.05:0.01:0.65
    dccount = 1;
    for Rdc = Rac+0.01:0.01:1.86
        ref(1,1) = Rdc; ref(2,1) = Rac;
        fun = @(mu) root2d(mu,ref);
        x0 = [0.0000000000001,0.0000001];
        x = fsolve(fun,x0);
        MuaF(dccount,account)  = x(1);
        MuspF(dccount,account) = x(2);
        dccount = dccount+1;
    end
    account = account+1;
end
save('fsolveTable.mat','MuaF','MuspF');

%%
for wl = 1:wavelength_num
    for c = 1:column_image
        for r = 1:row_image
            Rdc = Rd_DC(r,c,wl);
            Rac = Rd_AC(r,c,wl);
            col = fix((Rac-0.05)./0.01+1);
            row = fix((Rdc-Rac-0.01)./0.01+1);

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

%%
mac_test = Rd_AC(:,:,1);
figure, imagesc(mac_test); colormap('jet');
mac_test(isnan(mac_test)) = 0;
mac_test(isinf(mac_test)) = 0;
z = fft2(mac_test);
figure, imagesc(abs(fftshift(z))); colormap('jet');
k = fftshift(z);

%  % Create a logical image of a ring with specified
% % inner diameter, outer diameter center, and image size.
% % First create the image.
% [imageSizeY, imageSizeX] = size(k);
% [columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
% % Next create the circle in the image.
% centerX = imageSizeX/2;
% centerY = imageSizeY/2;
% innerRadius = 40;
% outerRadius = 239;
% array2D = (rowsInImage - centerY).^2 ...
%     + (columnsInImage - centerX).^2;
% ringPixels = array2D >= innerRadius.^2 & array2D <= outerRadius.^2;
% % ringPixels is a 2D "logical" array.
% % Now, display it.
% figure, image(ringPixels) ;
% colormap([0 0 0; 1 1 1]);
% title('Binary Image of a Ring', 'FontSize', 25);


k(235:245, 384:end) = 0;
k(235:245, 1:368) = 0;
% k = k - k.*ringPixels;
figure, imagesc(abs(k)); colormap('jet')
kback = fftshift(k);
ki = ifft2(k);
kbacki = ifft2(kback);
figure, imagesc(abs(ki)); colormap('jet'); caxis([0,2])
% figure, imagesc(abs(kbacki));
%%
for i = 1:3
    Racp(:,:,i) = medfilt2(Rd_AC(:,:,i),[10,10]);
    figure, imagesc(Racp(:,:,i)); colormap('jet');
end