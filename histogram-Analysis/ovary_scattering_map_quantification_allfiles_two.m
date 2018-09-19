name = 'E:\Yifeng Zeng\!PhD Work\Projects\OCT\Ovary-Data-Processing\! Final-Processing\Ovary Parts\~Scattering-Map\usCropped';
listing = dir(name);
sizeListing = size(listing,1);
fpath = 'E:\Yifeng Zeng\!PhD Work\Projects\OCT\Ovary-Data-Processing\! Final-Processing\Ovary Parts\~Scattering-Map\histogram_Gaussian_fitting';

for i = 3:sizeListing
    File_Name = listing(i).name;
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

    load([name,'\',File_Name]);
    us_cal = us(:);
    us_cal(us_cal<0.5|us_cal>19.5) = [];

    % calculate average scattering coefficient
    us_ave(partNum,saveCol) = mean(us_cal);

    % calculate standard deviation
    us_std(partNum,saveCol) = std(us_cal);

    % fit histogram to a normal distribution
    figure, histfit(us_cal);
    fpathH = fpath;
    jpgname = [File_Name(1:end-4),'.jpg'];
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
    us_gray = mat2gray(us,[0.5,19.5]);
    us_entropy(partNum,saveCol) = entropy(us_gray);

    % calculate other histogram features using a function
    us_cal2 = us(:);
    us_cal2(us_cal2<1|us_cal2>19) = [];

    hist_stat{partNum,saveCol} = chip_histogram_features(us_cal2,'NumLevels',19,'G',[]);
end

% sorting fitting result using the outside function
a = size(hist_stat,2);
b = size(hist_stat,1);
for i = 1:a
    for j = 1:b
        if isempty(hist_stat{j,i})
            continue;
        else
            hist_temp          = hist_stat{j,i};
            hist_mean(j,i)     = hist_temp(1);
            hist_variance(j,i) = hist_temp(2);
            hist_skewness(j,i) = hist_temp(3);
            hist_kurtosis(j,i) = hist_temp(4);
            hist_energy(j,i)   = hist_temp(5);
            hist_entropy(j,i)  = hist_temp(6);
        end
    end
end
