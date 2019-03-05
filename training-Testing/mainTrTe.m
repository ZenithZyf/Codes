feature_index = [4,5,6,7,8,9];
dFF2 = ff2n(6);
for i = 2:size(dFF2,1)
    use = dFF2(i,:);
    use_index = use.*feature_index;
    use_index(use_index==0) = [];
    for j = 1:100
        try
            [AUC_m_t(i-1,j), AUC_trm_t(i-1,j)] = TrainTest(use_index);
        catch ME
            AUC_m_t(i-1,j) = NaN;
            AUC_trm_t(i-1,j) = NaN;
            continue;
        end
    end
    AUC_m(i-1) = nanmean(AUC_m_t(i-1,:));
    AUC_trm(i-1) = nanmean(AUC_trm_t(i-1,:));
end
AUC = mean(AUC_m);
AUC_tr = mean(AUC_trm);