% get the names of all the cropped images
name = 'E:\Projects\OCT\Ovary-Data-Processing\! Final-Processing\~Scattering-Map\usCropped_2.0';
listing = dir(name);
sizeListing = size(listing,1);
% folder to save the fitted histogram
fpath = 'E:\Projects\OCT\Ovary-Data-Processing\! Final-Processing\~Scattering-Map\histogram_Gaussian_fitting_2.0';
% folder to save the features
spath = 'E:\Projects\OCT\Ovary-Data-Processing\! Final-Processing\~Scattering-Map';

% three infos + six features:
% infos: patient numbers; cropped parts; diagnose labelling.
% features: ave; std; entropy; skewness; kurtosis; energy.
numFeatures = 6;
features = zeros(sizeListing-2,3+numFeatures);
% counters for benign and cancer parts
benignParts = 0;
cancerParts = 0;

for i = 3:sizeListing
    % counter for how many feature saved in one round
    count = 1;
    % get info of the cropped data (image)
    File_Name = listing(i).name;
    seqInfo = regexp(File_Name,'\d*','Match');
    matchStr = regexp(File_Name,'[a-z]','match','dotexceptnewline');
    % extract patient number and part number
    patientNum = str2double(seqInfo{1}); 
    partNum = str2double(seqInfo{2});
    % record patient number and part number
    features(i-2,count) = patientNum;
    count = count + 1;
    features(i-2,count) = partNum;
    count = count + 1;

    % if cancer
    if matchStr{1} == 'c'
        cancerParts = cancerParts+1;
        diagnose = 'Cancer';
        % labelling the data based on Eghbal's training and testing
        features(i-2,count) = 1;
        count = count + 1;
    % if benign
    else
        benignParts = benignParts+1;
        diagnose = 'Benign';
        % labelling the data based on Eghbal's training and testing
        features(i-2,count) = 0;
        count = count + 1;
    end

    % load the data
    load([name,'\',File_Name]);
    % vectorize all scattering coefficient
    us_cal = us(:);
    % remove unreasonable data points
    us_cal(us_cal<0.5|us_cal>19.5) = [];
    % remove outliers based on quartiles rule
    TF = isoutlier(us_cal,'quartiles');
    us_cal(TF) = [];

    % calculate average scattering coefficient
    features(i-2,count) = mean(us_cal);
    count = count + 1;

    % calculate standard deviation
    features(i-2,count) = std(us_cal);
    count = count + 1;

    % fit histogram to a normal distribution
    figure, histfit(us_cal);
    % save the figure
    fpathH = fpath;
    tifname = [File_Name(1:end-4),'.tif'];
    title(['Patient',seqInfo{1},' ',diagnose,' Part',seqInfo{2}]);
    set(gca,'fontsize',20,'xtick',[],'ytick',[]);
    tightInset = get(gca, 'TightInset');
    position(1) = tightInset(1);
    position(2) = tightInset(2);
    position(3) = 1 - tightInset(1) - tightInset(3);
    position(4) = 1 - tightInset(2) - tightInset(4);
    set(gca, 'Position', position);
    saveas(gcf,fullfile(fpathH,tifname));

    % calculate the entropy of the whole image
    us_gray = mat2gray(us,[0.5,19.5]);
    features(i-2,count) = entropy(us_gray);
    count = count + 1;

    % calculate other histogram features
    % us_cal2 = us(:);
    % us_cal2(us_cal2<1|us_cal2>19) = [];
    fitoutput = chip_histogram_features(us_cal,'NumLevels',19,'G',[]);
    % save skewness, kurtosis, and energy of the image
    features(i-2,count:count+2) = fitoutput(3:5);
    count = count + 3;
end

% sort out the benign and cancer features
benign_features = features(1:benignParts,:);
cancer_features = features(end-cancerParts+1:end,:);

% save both featrues
save(fullfile(spath,'benign_features'), 'benign_features');
save(fullfile(spath,'cancer_features'), 'cancer_features');

% % sorting fitting result using the outside function
% a = size(hist_stat,2);
% b = size(hist_stat,1);
% for i = 1:a
%     for j = 1:b
%         if isempty(hist_stat{j,i})
%             continue;
%         else
%             hist_temp          = hist_stat{j,i};
%             hist_mean(j,i)     = hist_temp(1);
%             hist_variance(j,i) = hist_temp(2);
%             hist_skewness(j,i) = hist_temp(3);
%             hist_kurtosis(j,i) = hist_temp(4);
%             hist_energy(j,i)   = hist_temp(5);
%             hist_entropy(j,i)  = hist_temp(6);
%         end
%     end
% end
