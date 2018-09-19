fftus = fft2(us);
figure, imagesc(abs(fftshift(fftus))); colormap('gray'); caxis([1 10000]);
title('patient3 normal1');

%%
[a3n1,b3n1] = MinVolEllipse(test,0.5);

%%
name = '/Users/ZenithZeng/Documents/!PhD Work/Projects/OCT/OCT/Colon-Data-Processing/OCT Colon Publication/~Scattering Map/heterogeneity2/usCroped';
% name = '/Users/ZenithZeng/Documents/!PhD Work/Projects/OCT/OCT/Colon-Data-Processing/OCT Colon Publication/~Scattering Map/heterogeneity2/CodeTest';
listing = dir(name);
sizeListing = size(listing,1);
fpath = '/Users/ZenithZeng/Documents/!PhD Work/Projects/OCT/OCT/Colon-Data-Processing/OCT Colon Publication/~Scattering Map/heterogeneity2/EllipseFit';

figure;

for i = 4:sizeListing
    %%
    figure;
    index = listing(i).name;
    load(index); dataname = index(1:5); 
    tifname = [dataname,'.tif']; jpgname = [dataname,'.jpg'];
    patientNum = str2double(dataname(3)); partNum = str2double(dataname(5));
    if dataname(4) == 'c'
        saveCol = 2*patientNum-1;
        diagnose = 'Cancer';
    else
        saveCol = 2*patientNum;
        diagnose = 'Normal';
    end
    
    fftuso = fft2(us);
    fftus = abs(fftshift(fftuso));

    [~, threshold] = edge((fftus), 'sobel');
    fudgeFactor = .5;
    BWs = edge((fftus),'sobel', threshold * fudgeFactor);
%     figure, imshow(BWs), title('binary gradient mask');
    se90 = strel('line', 3, 90);
    se0 = strel('line', 3, 0);
    BWsdil = imdilate(BWs, [se90 se0]);
%     figure, imshow(BWsdil), title('dilated gradient mask');
    BWdfill = imfill(BWsdil, 'holes');
%     figure, imshow(BWdfill);
    title('binary image with filled holes');
    BWnobord = imclearborder(BWdfill, 4);
%     figure, imshow(BWnobord), title('cleared border image');
    seD = strel('diamond',1);
    BWfinal = imerode(BWnobord,seD);
    BWfinal = imerode(BWfinal,seD);
%     figure, imshow(BWfinal), title('segmented image');
    BWoutline = bwperim(BWfinal);
    % Segout = abs(fftshift(p3n1test)); 
    % Segout(BWoutline) = 10000; 
    % figure, imagesc(Segout), colormap('jet'), caxis([1 10000]), title('outlined original image');

    xElpFit = [];
    yElpFit = [];
    for xTemp = 1:size(BWoutline,2)
        yTemp = find(BWoutline(:,xTemp)==1);
        if isempty(yTemp)
            continue;
        elseif size(yTemp,1)==1
            xElpFit = [xElpFit;xTemp];
            yElpFit = [yElpFit;yTemp];
        else
            xElpFit = [xElpFit;xTemp;xTemp];
            yElpFit = [yElpFit;yTemp(1);yTemp(size(yTemp,1))];
        end
    end

    ellipsePara = fit_ellipse(xElpFit, yElpFit);

    imagesc(fftus); colormap('gray'); caxis([1 10000]);
    hold on

    fontSize = 20;
    % Parameterize the equation.
    t = linspace(0, 360,1000);
    phaseShift = ellipsePara.phi * 2 * pi;
    xCenter = ellipsePara.X0_in; yCenter = ellipsePara.Y0_in;
    xAmplitude = 0.5 * ellipsePara.long_axis;
    yAmplitude = 0.5 * ellipsePara.short_axis;
    x = xCenter + xAmplitude * sind(t + phaseShift);
    y = yCenter + yAmplitude * cosd(t);% + phaseShift);
    % Now plot the rotated ellipse.
    plot(x, y, 'b-', 'LineWidth', 2); hold off;

%     title(['Patient',dataname(3),' ',diagnose,' Part',dataname(5)]);
%     set(gca,'fontsize',20,'xtick',[],'ytick',[]);
%     tightInset = get(gca, 'TightInset');
%     position(1) = tightInset(1);
%     position(2) = tightInset(2);
%     position(3) = 1 - tightInset(1) - tightInset(3);
%     position(4) = 1 - tightInset(2) - tightInset(4);
%     set(gca, 'Position', position);
%     saveas(gcf,fullfile(fpath,tifname));
%     saveas(gcf,fullfile(fpath,jpgname));
    
%     ellipseLong(partNum,saveCol) = ellipsePara.long_axis / size(us,1);
%     ellipseShort(partNum,saveCol) = ellipsePara.short_axis / size(us,1);
%%
end
%%
figure, hold('on');
plot(sigmaGaussianRes{1,17});
plot(sigmaGaussianRes{2,17});
plot(sigmaGaussianRes{1,18},'o');
plot(sigmaGaussianRes{2,18},'o');
plot(sigmaGaussianRes{3,18},'o');
plot(sigmaGaussianRes{4,18},'o');

%%
figure, hold('on');
plot(meanGaussianRes{1,11});
plot(meanGaussianRes{2,11});
plot(meanGaussianRes{1,17});
plot(meanGaussianRes{2,17});
plot(meanGaussianRes{1,18},'o');
plot(meanGaussianRes{2,18},'o');
plot(meanGaussianRes{3,18},'o');
plot(meanGaussianRes{4,18},'o');