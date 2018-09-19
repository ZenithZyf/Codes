% Data Extraction and Formatting

%%% Creat a 2*n cell structure, 1*n is name, 2*n is data
%%% Scattering maps from which patients are we need?

%%% What size of the data we want?

% Radon Projection

%%% What angles we need?

%% Image Post-Processing for Scattering Map
usp_p = usp;
usp_p(usp_p<=0) = -1;
usp_p(usp_p>20) = 20;
% figure,imagesc(usp_p);colormap(jet);colorbar;

% uspf = medfilt2(usp_p,[5 5]);
figure,imagesc(usp_p);colormap(jet);colorbar;caxis([-1 20]);
set(gca,'fontsize',20);

%% Crop Sections
us1p1 = usp_p(603:1115,103:534); us1p2 = usp_p(507:1081,610:1000); 
us1p3 = usp_p(1:400,300:699);
% us9n4 = usp_p(600:800,300:500);
%% Fill holes with average.
us = us1p3; 
ust = us(:); a = ust>0&ust<20; ust = ust.*a; ust(ust==0) = []; aave = mean(ust); astd = std(ust);
us(us<0.000001) = aave; us(us==20) = aave;

%%
name = 'E:\Yifeng Zeng\!PhD Work\Projects\OCT\Colon-Data-Processing\! Final-Processing\~Scattering Map\heterogeneity2';
listing = dir(name);
sizeListing = size(listing,1);
figure;
fpath = [name,'\processedMaps'];
for i = 5:sizeListing
    index = listing(i).name;
    load(index); dataname = [index(1:5),'.tif'];
    
    imageSizeX = size(us,1);
    imageSizeY = size(us,2);
    [columnsInImage rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
    % Next create the circle in the image.
    centerX = imageSizeX/2;
    centerY = imageSizeY/2;
    radius = min(centerX,centerY);
    circlePixels = (rowsInImage - centerY).^2 ...
        + (columnsInImage - centerX).^2 <= radius.^2;
    circleMask = double(circlePixels);
    us = us.*circleMask;
    
    imagesc(us); colormap(jet); colorbar; caxis([0 20]);
    if str2double(dataname(3)) == 5
        caxis([0 10]);
    end
    set(gca,'fontsize',20);
    tightInset = get(gca, 'TightInset');
    position(1) = tightInset(1);
    position(2) = tightInset(2);
    position(3) = 1 - tightInset(1) - tightInset(3);
    position(4) = 1 - tightInset(2) - tightInset(4);
    set(gca, 'Position', position);
%     title('');
    saveas(gcf,fullfile(fpath,dataname));
end

%%
name = 'E:\Yifeng Zeng\!PhD Work\Projects\OCT\Colon-Data-Processing\! Final-Processing\~Scattering Map\heterogeneity2';
listing = dir(name);
sizeListing = size(listing,1);
figure;
fpath = [name,'\processedMaps\fourAngles'];
for i = 5:sizeListing
    index = listing(i).name;
    load(index); dataname = [index(1:5),'.tif'];
    
    if dataname(4) == 'n'
        figTitle = ['patient',dataname(3),' normal part',dataname(5)];
    else
        figTitle = ['patient',dataname(3),' cancer part',dataname(5)];
    end
    
    imageSizeX = size(us,1);
    imageSizeY = size(us,2);
    [columnsInImage rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
    % Next create the circle in the image.
    centerX = imageSizeX/2;
    centerY = imageSizeY/2;
    radius = min(centerX,centerY);
    circlePixels = (rowsInImage - centerY).^2 ...
        + (columnsInImage - centerX).^2 <= radius.^2;
    circleMask = double(circlePixels);
    us = us.*circleMask;
    
    [R,xp] = radon(us,[0 45 90 135]);
    figure, 
    subplot(2,2,1); plot(xp,R(:,1)./(max(R(:,1)))); title([figTitle, ' 0 degree']); %set(gca,'fontsize',20);
    subplot(2,2,2); plot(xp,R(:,2)./(max(R(:,2)))); title([figTitle, ' 45 degree']); %set(gca,'fontsize',20);
    subplot(2,2,3); plot(xp,R(:,3)./(max(R(:,3)))); title([figTitle, ' 90 degree']); %set(gca,'fontsize',20);
    subplot(2,2,4); plot(xp,R(:,4)./(max(R(:,4)))); title([figTitle, ' 135 degree']); %set(gca,'fontsize',20);
    
%     imagesc(us); colormap(jet); colorbar; caxis([0 20]);
%     if str2double(dataname(3)) == 5
%         caxis([0 10]);
%     end
%     set(gca,'fontsize',20);
%     tightInset = get(gca, 'TightInset');
%     position(1) = tightInset(1);
%     position(2) = tightInset(2);
%     position(3) = 1 - tightInset(1) - tightInset(3);
%     position(4) = 1 - tightInset(2) - tightInset(4);
%     set(gca, 'Position', position);
%     title('');
    saveas(gcf,fullfile(fpath,dataname));
    close
end

%% Creat a circle mask for Radon Transform.
% Create a logical image of a circle with specified
% diameter, center, and image size.
% First create the image.
imageSizeX = 500;
imageSizeY = 500;
[columnsInImage rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
% Next create the circle in the image.
centerX = imageSizeX/2;
centerY = imageSizeY/2;
radius = min(centerX,centerY);
circlePixels = (rowsInImage - centerY).^2 ...
    + (columnsInImage - centerX).^2 <= radius.^2;
circleMask = double(circlePixels);
% circlePixels is a 2D "logical" array.
% Now, display it.
% image(circlePixels) ;
% colormap([0 0 0; 1 1 1]);
% title('Binary image of a circle');

%%
name = 'E:\Yifeng Zeng\!PhD Work\Projects\OCT\Colon-Data-Processing\! Final-Processing\~Scattering Map\heterogeneity2';
% name = '/Users/ZenithZeng/Documents/!PhD Work/Projects/OCT/OCT/Colon-Data-Processing/OCT Colon Publication/~Scattering Map/heterogeneity2/CodeTest';
listing = dir(name);
sizeListing = size(listing,1);
% figure;
% fpath = [name,'\processedMaps'];
for i = 5:sizeListing
    index = listing(i).name;
    load(index); dataname = [index(1:5)];
    patientNum = str2double(dataname(3)); partNum = str2double(dataname(5));
    if dataname(4) == 'c'
        saveCol = 2*patientNum-1;
    else
        saveCol = 2*patientNum;
    end
    
    imageSizeX = size(us,1);
    imageSizeY = size(us,2);0
    [columnsInImage,rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
    % Next create the circle in the image.
    centerX = imageSizeX/2;
    centerY = imageSizeY/2;
    radius = min(centerX,centerY);
    circlePixels = (rowsInImage - centerY).^2 ...
        + (columnsInImage - centerX).^2 <= radius.^2;
    circleMask = double(circlePixels);
    us = us.*circleMask;
    [R,xp] = radon(us,0:179);

    for i = 1:180
        radonTemp = R(:,i); xTemp = xp;
        a = radonTemp > 50; radonTemp = radonTemp.*a; xTemp = xTemp.*a;
        radonTemp(radonTemp==0)=[]; xTemp(xTemp==0)=[];
        insertPoint=floor(size(xTemp,1)/2);
        xTemp = [xTemp(1:insertPoint);0;xTemp(insertPoint+1:size(xTemp,1))];
        radonTemp = radonTemp./max(radonTemp);
        
        f = fit(xTemp,radonTemp,'gauss1');
        gFitted = f(xTemp);
        rmseFit(i) = sqrt(immse(gFitted,radonTemp));
        meanGaussian(i) = f.b1;
        sigmaGaussian(i) = f.c1;
        
        Smooth = 0;
        for j = 1:size(xTemp,1)-1
            Smooth = Smooth + abs(radonTemp(j+1)-radonTemp(j));
        end
        SmoothAve(i) = Smooth/(size(xTemp,1)-1);
    end
    radonPro{partNum,saveCol} = R;
    smoothRes{partNum,saveCol} = SmoothAve;
    rmseFitRes{partNum,saveCol} = rmseFit;
    meanGaussianRes{partNum,saveCol} = meanGaussian;
    sigmaGaussianRes{partNum,saveCol} = sigmaGaussian;
    
%     gFitted = [];
    rmseFit(i) = [];
    meanGaussian(i) = [];
    sigmaGaussian(i) = [];
    SmoothAve = [];
end