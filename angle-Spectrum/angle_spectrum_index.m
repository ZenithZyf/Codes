% Main code for angular spectrum calculation

% input data should have the form of: us3i2xxxxxx.mat
    % us stands for scattering coefficient
    % 3 stands for patient number
    % i: 'n' for normal, 'c' for cancer, 'p' for polyp
    % 2: part 2 
% result of polyp will need to save manually
% result of cancer and normal will be saved automatically
% result: each 2 columns are result from one patient
    % odd columns stand for cancer and even columns are normal

% =====================================================================================
%                               Variables Initialization
% =====================================================================================

% saving path for angular spectrum
fpathfft = '/Users/ZenithZeng/Documents/!PhD Work/Projects/OCT/OCT/Colon-Data-Processing/OCT Colon Publication/~Scattering Map/heterogeneity2/AngleSpectrum/AfterFFT';
% saving path for angular spectrum with two ellipses
fpathTE = '/Users/ZenithZeng/Documents/!PhD Work/Projects/OCT/OCT/Colon-Data-Processing/OCT Colon Publication/~Scattering Map/heterogeneity2/AngleSpectrum/TwoEllipse';
% select input data and load it
[File_Name,PathName] = uigetfile('*.mat*','Select Input Data');
load([PathName,File_Name]);
% creat image names for saving
tifname = [File_Name(1:5),'.tif']; jpgname = [File_Name(1:5),'.jpg'];
% extract patient number and part number
patientNum = str2double(File_Name(3)); partNum = str2double(File_Name(5));
% if cancer, save to odd columns
if File_Name(4) == 'c'
    saveCol = 2*patientNum-1;
    diagnose = 'Cancer';
% if polyp, save result manually please
elseif File_Name(4) == 'p'
    diagnose = 'Polyp';
% if normal, save to even columns
else
    saveCol = 2*patientNum;
    diagnose = 'Normal';
end

% record image widths and lengths for future ellipse filtering
imageWidth = size(us,1);
imageLength = size(us,2);

% =====================================================================================
%                              Angular Spectrum Generation
% =====================================================================================

% 2-D Fourier transform of the scattering map
fftuso = fft2(us);
fftus = abs(fftshift(fftuso));

% generate angular spectrum and save it
figure, imagesc(fftus); colormap('gray'); caxis([1 10000]);
title(['Patient',File_Name(3),' ',diagnose,' Part',File_Name(5)]);
set(gca,'fontsize',20,'xtick',[],'ytick',[]);
tightInset = get(gca, 'TightInset');
position(1) = tightInset(1);
position(2) = tightInset(2);
position(3) = 1 - tightInset(1) - tightInset(3);
position(4) = 1 - tightInset(2) - tightInset(4);
set(gca, 'Position', position);
saveas(gcf,fullfile(fpathfft,tifname));
saveas(gcf,fullfile(fpathfft,jpgname));
hold on;
fontSize = 20;

% =====================================================================================
%                                    Edge Detection
% =====================================================================================

% use edge and the Sobel operator to calculate the threshold value
[~, threshold] = edge((fftus), 'sobel');
% tune the threshold value
fudgeFactor = .5;
% use edge again to obtain a binary mask that contains most angular spectrum signals
BWs = edge((fftus),'sobel', threshold * fudgeFactor);
% figure, imshow(BWs), title('binary gradient mask');
% dilate the Sobel image using linear structuring elements
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
% figure, imshow(BWsdil), title('dilated gradient mask');
% fill the dilated Sobel image
BWdfill = imfill(BWsdil, 'holes');
% figure, imshow(BWdfill), title('binary image with filled holes');
% (optional) remove objects connected to the border
BWnobord = imclearborder(BWdfill, 4);
% figure, imshow(BWnobord), title('cleared border image');
% smoothen the object by eroding the image with a diamond structuring element
% the eroding times depend on how well the ellipse is fitted
seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
% BWfinal = imerode(BWfinal,seD);
% figure, imshow(BWfinal); %title('segmented image');
% generate the outline of detected border
BWoutline = bwperim(BWfinal);

% =====================================================================================
%                                    Ellipse Fitting
% =====================================================================================

% find the coordinates of the border for fitting
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
% fit the ellipse using 'fit_ellipse' function
% we will get major and minor axis length, center location, and phase
ellipsePara = fit_ellipse(xElpFit, yElpFit);

% parameterize the equation for plotting the ellipse
% and selecting the pixels within
t = linspace(0, 360, 1000);
phaseShift = ellipsePara.phi;
xCenter = ellipsePara.X0_in; yCenter = ellipsePara.Y0_in;

% show the ellipses if the major axis is along x
% a = 0.5 * ellipsePara.long_axis;
% b = 0.5 * ellipsePara.short_axis;
% x = xCenter + a * sin(t - phaseShift);
% y = yCenter + b * cos(t);
% a2 = 0.5*a;
% b2 = 0.5*b;
% x2 = xCenter + a2 * sin(t - phaseShift);
% y2 = yCenter + b2 * cos(t);
% show the ellipse if the major axis is along y
a = 0.5 * ellipsePara.short_axis;
b = 0.5 * ellipsePara.long_axis;
x = xCenter + a * sin(t);
y = yCenter + b * cos(t - phaseShift);
a2 = 0.5*a;
b2 = 0.5*b;
x2 = xCenter + a2 * sin(t);
y2 = yCenter + b2 * cos(t - phaseShift);

% plot the rotated ellipses and save the images
plot(x, y, 'b-', 'LineWidth', 2); hold on;
plot(x2, y2, 'r-', 'LineWidth', 2); hold off;
saveas(gcf,fullfile(fpathTE,tifname));
saveas(gcf,fullfile(fpathTE,jpgname));

% =====================================================================================
%                               Angular Spectrum Index
% =====================================================================================

% extract coordinates of the boundary
xt = floor(x); xt2 = floor(x2);
yt = floor(y); yt2 = floor(y2);
% reflect the boundary to a 2-D image
imaget = zeros(imageWidth,imageLength);
imaget2 = imaget;
for i = 1:1000
    imaget(yt(i),xt(i)) = 1;
    imaget2(yt2(i),xt2(i)) = 1;
end
% fill the ellipses
imagef = imfill(imaget,'holes');
imagefcenter = imfill(imaget2,'holes');
imagefouter = imagef - imagefcenter;
% figure,imagesc(imagefouter);
% figure,imagesc(imagefcenter);

% get the center and outer part of the angular spectrum
fftuscenter = fftus .* imagefcenter;
fftusouter = fftus .* imagefouter;
% calculate the angular spectrum index
angleSpectrumIndex(partNum,saveCol) = sum(sum(fftusouter))/(sum(sum(fftuscenter))+sum(sum(fftusouter)));