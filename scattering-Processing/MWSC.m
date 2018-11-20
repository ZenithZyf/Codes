% This is the funtion for scattering coefficient fitting
function [us,error] = MWSC(img,img_f,surfrow,halfwindowsize)

% =====================================================================================
%                            Input and Output of this Function
% =====================================================================================

% img: B-scan matrix for quantification
% img_f: median filtered img for fitting points selection
% surfrow: surface of corresponding B-scan
% halfwindowsize: for moving window processing
% us: scattering acoefficient
% error: 95% fitting error

% =====================================================================================
%                               Variables Initialization
% =====================================================================================

% Load old-image parameters; These parameters are not used in the final processing;
% They are maintained for future potential update.
row = size(img_f,1); % row numbers per A-line
depth = 1.8; % mm
depth_step = double(depth/row); % mm.
zcf = depth_step*500; zr = 0.66; % mm. zcf: depth of focal gate; zr: rayleigh length.
z = ((1:size(img_f,1))*depth_step)'; % mm. Image depth vector.
epi_pixel_NO = floor(0.04/depth_step); % row. The depth of epithelium.
noiseline = 600; % row number. beneath which are all noises. It is different for different slices.

% Image pre-processing (flip at the edge).
% halfwindowsize = 0 for final processing, therefore, no need to flip.
% img_f = [fliplr(img_f(:,1:halfwindowsize)) img_f fliplr(img_f(:,1000-halfwindowsize+1:1000))];
% surfrow = [fliplr(surfrow(:,1:halfwindowsize)) surfrow fliplr(surfrow(:,1000-halfwindowsize+1:1000))];

col = size(img,2);
% us - scattering coefficient
us = zeros(1,col); 
% error - 95% fitting error
error = zeros(1,col);

% =====================================================================================
%   Moving window processing for scattering coefficient extraction of all the A-lines
% =====================================================================================

for aline = (1+halfwindowsize):(size(img_f,2)-halfwindowsize) % moving window 
    
    %%% Fitting Points Selection %%% 
    % Hole deletion.
    % setting threshold intensity for pixels in a hole
    threshold = 15;
    % loading the surface row of each aline
    temp = surfrow(aline);
    % used for saving the index of suitable pixels
    fitpoint = [];
    if temp == 0
        us(aline-halfwindowsize) = 0;
        error(aline-halfwindowsize) = 0;
        continue;
    end
    % record pixels whose intensity larger than threshold only
    while 1  
        if img_f(temp,aline)<threshold
            temp = find(img_f(temp:row,aline)>threshold,1,'first')+temp;
            if isempty(temp)==1
                break;
            end
        else
            tmp = find(img_f(temp:row,aline)<threshold,1,'first')+temp;
            fitpoint = [fitpoint temp:tmp-1];
            temp = find(img_f(tmp:row,aline)>threshold,1,'first')+tmp;
            if isempty(temp)==1
                break;
            end
        end
    end
    
    % If we have fitpoints, then perform further processing 
    if isempty(fitpoint)==0
        % thresholding for avoiding hyper-reflection surface
        hyper_Intensity = 200;
        fitpoint(img(fitpoint,aline-halfwindowsize)>hyper_Intensity) = [];
        % find the fitting start point
        % criteria 1: should have a large intensity
        % criteria 2: should have at least half of the fitting points left
        fitrange = fitpoint;
        while 1
            startpoint = fitpoint(find(img(fitrange,aline-halfwindowsize)==max(img(fitrange,aline-halfwindowsize)),1,'first'));
            pointleft = size(fitpoint,2)-find(fitpoint(1,:)==startpoint,1,'first');
            if pointleft < floor(size(fitpoint,2)/2)
                fitrange(find(fitpoint(1,:)==startpoint,1,'first'):size(fitrange,2)) = [];
            else
                break;
            end
        end

        % threshold for curve filtering 
        highthreshold = img(startpoint,aline-halfwindowsize);
        lowthreshold = highthreshold/2;

        % filtering the curve shape to avoid noise or hyper-reflection 
        fitpoint(fitpoint<startpoint-1)=[];
        useful = (img(fitpoint,aline-halfwindowsize)<5+highthreshold&img(fitpoint,aline-halfwindowsize)>lowthreshold)';
        fitpoint = fitpoint.*useful;
        fitpoint(find(fitpoint==0)) = [];
        
        % if we cannot find proper points for fitting (point left < 3), set us to -1        
        if size(fitpoint,2)<3
            us(aline-halfwindowsize) = -1;
            error(aline-halfwindowsize) = 0;
            continue;
        end

        % if there are enough fitting points left, continue to curve fitting
        % double the image to improve precision
        imgr = double(img(:,aline-halfwindowsize));
        % recover original i(z) (OCT signal)
        img_p = 10.^(((double(imgr)./10)+60)./20); 

        % Log the data for linear fitting
        logiz = log(img_p); % logiz ~ us*z

        % Linear fitting for scattering coefficient extraction and error caculating
        coef = fit(z(fitpoint),logiz(fitpoint),'poly1');
        us(aline-halfwindowsize) = -coef.p1;
        confident95 = confint(coef,.95);
        error(aline-halfwindowsize) = abs(coef.p1-confident95(1)); % Calcualte the standard errors based on the 95% confidence interval.
    
    % If at the very beginning we cannot find any fitpoints, then this is background     
    else
        us(aline-halfwindowsize) = 0;
        error(aline-halfwindowsize) = 0;
    end
end