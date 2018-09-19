% Main funtion for fitting a C-scan and saving results

% =====================================================================================
%                               Variables Initialization
% =====================================================================================

% load all B-scans
load imgm;
% load the detected surface
load surface;
% load the depth compensation parameter
load depthpara;
% initialize the pixel-level thickness of the tissue
%%%
thickness = 150;
%%%
% usp - scattering coefficient
usp = zeros(size(imgm,3),1000); 
% err - 95% fitting error
err = zeros(size(imgm,3),1000);

% =====================================================================================
%                           Scattering Coefficeint Mapping
% =====================================================================================

for slicenum = 1:size(imgm,3)
    % read each B-scan for processing
    imgo = imgm(:,:,slicenum);
    % compensate the signal roll-off over depth
    img = double(imgo)./depthpara;
    
    % extract the tissue areas 
    for i = 1:1000
        img(1:surface(slicenum,i),i)=0;
        img(surface(slicenum,i)+thickness:1000,i)=0;
    end
    % get the filtered image
    % Notice: This filtered image is only used for finding image suitable for fitting
    img_f = medfilt2(img,[10 10]);

    % Moving Window for Scattering Coefficient Extraction
    % windowsize is 0 - I fit each solid A-line
    halfwindowsize = 0;
    % use MWSC for scatter coeff fitting
    % img is used for fitting; img_f is used for locating suitable fitting pixels
    [usp(slicenum,:),err(slicenum,:)] = MWSC(img,img_f,surface(slicenum,:),halfwindowsize);
end

% =====================================================================================
%                                   Saving Results
% =====================================================================================

%%%
save sc800to1299raw usp;
save err800to1299raw err;
%%%