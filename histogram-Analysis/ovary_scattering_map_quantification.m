% select input data and load it
[File_Name,PathName] = uigetfile('*.mat*','Select Input Data');
load([PathName,File_Name]);
seqInfo = regexp(File_Name,'\d*','Match');
matchStr = regexp(File_Name,'[a-z]','match','dotexceptnewline');
% extract patient number and part number
patientNum = str2double(seqInfo{1}); partNum = str2double(seqInfo{2});
% if cancer, save to odd columns
if matchStr{3} == 'c'
    saveCol = 2*patientNum-1;
    diagnose = 'Cancer';
% if benign, save to even columns
else
    saveCol = 2*patientNum;
    diagnose = 'Benign';
end

us_cal = us(:);
us_cal(us_cal<0.5|us_cal>19.5) = [];

% calculate average scattering coefficient
us_ave(partNum,saveCol) = mean(us_cal);

% calculate standard deviation
us_std(partNum,saveCol) = std(us_cal);

% % calculate the radon transformation for heterogeneity test
% imageSizeX = size(us,1);
% imageSizeY = size(us,2);
% [columnsInImage,rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
% % Next create the circle in the image
% centerX = imageSizeX/2;
% centerY = imageSizeY/2;
% radius = min(centerX,centerY);
% circlePixels = (rowsInImage - centerY).^2 ...
%     + (columnsInImage - centerX).^2 <= radius.^2;
% circleMask = double(circlePixels);
% us_circle = us.*circleMask;
% [R,xp] = radon(us_circle,0:179);
% for i = 1:180
%     radonTemp = R(:,i); xTemp = xp;
%     a = radonTemp > 50; radonTemp = radonTemp.*a; xTemp = xTemp.*a;
%     radonTemp(radonTemp==0)=[]; xTemp(xTemp==0)=[];
%     insertPoint=floor(size(xTemp,1)/2);
%     xTemp = [xTemp(1:insertPoint);0;xTemp(insertPoint+1:size(xTemp,1))];
%     radonTemp = radonTemp./max(radonTemp);
% 
%     f = fit(xTemp,radonTemp,'gauss1');
%     gFitted = f(xTemp);
%     rmseFit(i) = sqrt(immse(gFitted,radonTemp));
%     meanGaussian(i) = f.b1;
%     sigmaGaussian(i) = f.c1;
% 
%     Smooth = 0;
%     for j = 1:size(xTemp,1)-1
%         Smooth = Smooth + abs(radonTemp(j+1)-radonTemp(j));
%     end
%     SmoothAve(i) = Smooth/(size(xTemp,1)-1);
% end
% radonPro{partNum,saveCol} = R;
% smoothRes{partNum,saveCol} = SmoothAve;
% rmseFitRes{partNum,saveCol} = rmseFit;
% meanGaussianRes{partNum,saveCol} = meanGaussian;
% sigmaGaussianRes{partNum,saveCol} = sigmaGaussian;

% creat the histogram of the scattering map
fpathH = 'E:\Yifeng Zeng\!PhD Work\Projects\OCT\Ovary-Data-Processing\! Final-Processing\Ovary Parts\~Scattering-Map\histogram';
jpgname = [File_Name(1:end-4),'.jpg'];
figure,histogram(us_cal);
title(['Patient',seqInfo{1},' ',diagnose,' Part',seqInfo{2}]);
set(gca,'fontsize',20,'xtick',[],'ytick',[]);
tightInset = get(gca, 'TightInset');
position(1) = tightInset(1);
position(2) = tightInset(2);
position(3) = 1 - tightInset(1) - tightInset(3);
position(4) = 1 - tightInset(2) - tightInset(4);
set(gca, 'Position', position);
saveas(gcf,fullfile(fpathH,jpgname));

% calculate the entropy of the whole image
us_gray = mat2gray(us,[0.5,19.5],[1 10]);
us_entropy(partNum,saveCol) = entropy(us_gray);
