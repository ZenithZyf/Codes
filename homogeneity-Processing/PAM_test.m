clc;clear all;
close all;

[File_Name1,PathName] = uigetfile('*.jpg*','Select an input file')
oi = imread([PathName File_Name1]);   %Importing the image 

soi = size(oi);
itern = 300;

    
%%%%%%%%%%%%%%%%%%%%%%%%%%2D FFT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
oi1g = rgb2gray(oi);   %Converting the co-reg image to grayscale
oi1gw = fftshift(fft2(oi1g(:,:),1024,1024));  % Finding the 2D FFT
oi1gw = oi1gw*1024/max(max(abs(oi1gw))); % Normalizing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Wavelet Compression%%%%%%%%%%%%%%%%%%%%%%%%%
w = 'db1'; 
[cA,cH,cV,cD] = dwt2(oi1g,w);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%Mean Radon transform%%%%%%%%%%%%%%%%%%%%%%%%%%%
mrad = 0;
for i = 0:90;   % Radon transform for each angle from 0deg to 90deg
    m3 = mean(imrotate(cA,i,'bilinear','crop')); 
    % Rotating the matrix then finding mean (Radon transform)
    m3 = m3/max(m3); %Normalizing
    mrad = mrad + m3;
    %Adding the normalized Radon transforms for all the angles
end
mrad = mrad/max(mrad); %Mean Radon transform for 91 angles

pix = 1:1:length(mrad);
cof3 = zeros(1,2);
[cof3(1) cof3(2) m3f err3] = gaussfit(pix',mrad',itern); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%Gamma Distribution Parameter Estimation%%%%%%%%%%%%%%%
par1 = [0 0];
for i = 1:length(double(oi1g(:,1)))
    gf = double(oi1g(i,:));
    gf = gamfit(gf);
    if(isfinite(gf(1)*gf(2)))
        par1 = par1  + gf;
    end
end
par1 = par1/length(oi1g(:,1));
mPA = par1(1)*par1(2);
varPA = par1(1)*par1(2)^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%Calculating the judging factors%%%%%%%%%%%%%%%%%%%%%%
f = mean(mean(abs(oi1gw(256:1024-256,256:1024-256))));
%1 Low frequency components of the coregistered image
f = [f (mean(mean(abs(oi1gw(1:256,:))))... 
+ mean(mean(abs(oi1gw(1024-256:1024,:))))...
+ mean(mean(abs(oi1gw(:,1:256))))...
+ mean(mean(abs(oi1gw(:,1024-256:1024)))))/4];
%2 High frequency components of the coregistered image

f = [f fix(sqrt(2)*cof3(2))]; %5 standard deviation of 
                              %the fitted mean Radon transform ********
f = [f err3]; %6 Squared Error of the fitting of the Gaussain curve

f = [f mean(mean(double(oi1g))) mean(var(double(oi1g)))];   
%7 Mean statistical variance of the photoacoustic image **************

f = [f mPA varPA]; %8-9 Mean and variance of the fitted Gamma Distribution
                   % to the PA part of the image ****************

f = round(f*100); %rounding to two decimal points
f = f/100


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Ploting and Viewing%%%%%%%%%%%%%%%%%%%%%%%
close all
figure, imshow(oi1g,'Border','loose')

figure, imshow(oi1gw)


x3 = 0:2:length(mrad)*2-1;
figure,plot(x3,mrad,'+'); xlabel('Pixel Number'), ylabel('Radon Transform Output')
hold on, plot(x3,m3f,'-')
hold off
legend('Mean Radon transform','Fitted Gaussian function')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%