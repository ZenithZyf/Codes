% Surface Detection with Potential Energy idea -- Version 1.2

% potential = columndiff + alp*(icl pixels before- icl pixels after); 
% columndiff stands for the position difference 
% sum(intensity(icl pixels before)) - sum(intensity(icl pixels after)) stands for 
    % intensity difference and alp is an customized parameter


% =====================================================================================
%                               Variables Initialization
% =====================================================================================

% load the all images as a matrix
load imgm;
% replace the horizotal lines on the top
%%%
imgm(1:125,:,:) = 10; % this number needs to be adjusted according to samples
%%%
% a represents the number of B-scans waiting for processing
a = size(imgm,3);

% record the path with the lowest cost to each pixel
% 11 stands for 11 potential start points of each B-scan
% theorietically, we can use all 1000 pixels as startpoint
% 11 is just for efficiency
traces = zeros(1000,1000,11); 
% record the lowest cost it takes to go to each pixel
costs = zeros(1000,1000,11);
% temporary cost variable for processing convenience
costTemp = zeros(1000,1);
% temporarily save the minimum cost of 11 startpoints of all B-scans
minCostLocal = zeros(11,a);
% delineated surface using 11 startpoints of all B-scans
tempsurface = zeros(1000,11,a);

% final surface (with globally minimum costs)
surface = zeros(a,1000);
% final startpoint for each surface
startpoint = zeros(a,1);

% =====================================================================================
%                                 Surface Delineation
% =====================================================================================

for number = 1:a
    % read the B-scan
    slicenum = number;
    imgo = imgm(:,:,slicenum);

    % preprocess the image
    imgo = double(medfilt2(imgo,[5 5]));
    % decide the intensity comparison length icl
    icl = 10; 
    % flip the image to compensate the boundary problem
    img = [flipud(imgo(1:icl,:));imgo;flipud(imgo((1000-icl+1):999,:))];

    % customized parameter
    alp = 0.01;

    % surface start points initialization
    % each scan contains 100 B-scans so that I initialize the start piont of each section
    %%%
    if number == 1
        tempstart = 532;
    elseif number == 101
        tempstart = 606;
    elseif number == 201
        tempstart = 694;
    elseif number == 301
        tempstart = 605;
    elseif number == 401
        tempstart = 492;
    end
    %%%
    
    % surface delineation of a startpoint window with the tempstart in the middle
    for startPoint = tempstart-5:tempstart+5
        % Initialization of costs and traces for the first two columns
        costs(:,1,startPoint-tempstart+6) = 0; 
        traces(:,1:2,startPoint-tempstart+6) = startPoint;
        for ii = (1:1000)+icl
            intenDiff = alp*(sum(img(ii-icl:ii-1,2))-sum(img(ii:ii+icl-1,2)));
            costs(ii-icl,2,startPoint-tempstart+6) = abs(ii-startPoint-icl)+intenDiff;
        end

        % iteration for optimization
        for i = 3:1000
            for ii = (1:1000)+icl
                intenDiff = alp*(sum(img(ii-icl:ii-1,i))-sum(img(ii:ii+icl-1,i)));
                costTemp = abs((1:1000)-ii+icl)+intenDiff+costs(:,i-1,startPoint-tempstart+6)';
                index = find(costTemp==min(costTemp),1);
                traces(ii-icl,i,startPoint-tempstart+6) = index;
                costs(ii-icl,i,startPoint-tempstart+6) = costTemp(index);
            end
        end

        % find the trace with the minimum costs of this startPoint
        endPoint = find(costs(:,1000,startPoint-tempstart+6)==min(costs(:,1000,startPoint-tempstart+6)),1);
        minCostLocal(startPoint-tempstart+6,slicenum) = min(costs(:,1000,startPoint-tempstart+6));
        tempsurface(1000,startPoint-tempstart+6,slicenum) = endPoint;
        for ss = 1:999
            tempsurface(1000-ss,startPoint-tempstart+6,slicenum) = traces(tempsurface(1000-ss+1,startPoint-tempstart+6,slicenum),1000-ss+1,startPoint-tempstart+6);
        end
    end
    % minCost(slicenum) = min(minCostLocal(:,slicenum));

    % record the surface with the minimum cost globally
    startpoint(slicenum) = find(minCostLocal(:,slicenum)==min(minCostLocal(:,slicenum)),1);
    surface(slicenum,:) = tempsurface(:,startpoint(slicenum),slicenum)';

    % use the start point of this B-scan as the middle of the startpoint window for next B-scan
    tempstart = startpoint(slicenum)+tempstart-6;
end

% =====================================================================================
%                                   Saving Results
% =====================================================================================

save startpoint startpoint;
save surface surface;