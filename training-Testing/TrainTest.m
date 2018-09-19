%%**** this code will generate sensitivity and specificity for different
%%combination of data. For each combination, it will also save AUC.
%%sensitivity_train_m, sensitivity_test_m, specificity_train_m,
%%specificity_test_m, AUC, AUCtr are the variables need to be saved. Except
%%AUC and AUCtr others are mean of sensitivity and specificity for the
%%number of crossvalidation you'll select. AUC and AUCtr is not mean. They
%%are left that way to calculate CI

clear all;close all;clc
include=0; %**** 1 will include all patient  0 will exclude low grade tumor data
Training_portion=2/3;
%classifier selector
selector=2; %GLM        =1
%SVM        =2
%Naive Bayes=3
%KNN        =4
threshold=0:0.01:1;
iteration=100; %%%**** here you need to mention the crossvalidation number

%%%**** here you need to insert the number of benign, highgrade and low
%%%grade tumor and how many from here will be used for training


filename='E:\Patient data\Ovary\InVivo\average_PAT_ImageFetures\All features_selected-4-21.xlsx';
sheet='independent frame';

features_wo=xlsread(filename,sheet,'F4:O50'); %%%%**** _wo means without low grade tumor
features_wo=[ features_wo(:,2) features_wo(:,3) features_wo(:,5)];

label_wo=xlsread(filename,sheet,'C4:C50');


total_highGrade=nnz(label_wo);
total_benign=length(label_wo)-total_highGrade;
total_lowGrade=0;

high_train=floor((Training_portion)*total_highGrade);
ben_train=floor((Training_portion)*total_benign);
low_train=0;

ben_test=total_benign-ben_train;
high_test=total_highGrade-high_train;
low_test=total_lowGrade-low_train;


if(~include) %%%**** here you need to uncomment the combination you like to select for high grade tumor data only
    data_wo=[ features_wo ];
    data=data_wo;
    label=label_wo;
    
else%%%**** here you need to uncomment the combination you like to select for all tumor data
    %%%CA-125
    data_w=[ SO2_w ];
    data=data_w;
    label=label_w;
    
end

clear succes_rate

for m=1:iteration
    
    if(~include)
        training = [sort(randperm(total_benign,ben_train)) sort(randperm(total_highGrade,high_train))+total_benign];% sort(randperm(8,5))+29]; %% select 6 malignant out of 9; select 12 benign out of 20; 5 out of 8 low grade
    else
        training = [sort(randperm(total_benign,ben_train)) sort(randperm(total_highGrade,high_train))+total_benign sort(randperm(total_lowGrade,low_train))+total_benign+total_highGrade]; %% select 6 malignant out of 9; select 12 benign out of 20; 5 out of 8 low grade
    end
    testing=[];
    for i=1:length(data)
        if(isempty(find(i==training)))
            testing=[testing i];
        end
    end
    
    if(selector==1)
        %%%%Logistic
        [B,DEV,STATS] = glmfit(data(training,:),label(training),'binomial','logit');
        
        ROC0_training_o= glmval(B,data(training,:), 'logit');
        ROC0_testing_o= glmval(B,data(testing,:), 'logit');
        % %
    else if (selector==2)
            %%%SVM TRAIN
            SVMModel = fitcsvm(data(training,:),label(training,:),'Standardize',1);
            CompactSVMModel = compact(SVMModel);
            CompactSVMModel = fitPosterior(CompactSVMModel,data(training,:),label(training,:));
            
            [PredLabels_train,ROC0_training_o] = predict(CompactSVMModel,data(training,:));
            [Predlabels_test,ROC0_testing_o] = predict(CompactSVMModel,data(testing,:));
            ROC0_training_o=ROC0_training_o(:,2);
            ROC0_testing_o=ROC0_testing_o(:,2);
        else if (selector==3)
                mdlNB = fitcnb(data(training,:),label(training,:));
                [PredLabels_train,ROC0_training_o] = predict(mdlNB,data(training,:));
                [Predlabels_test,ROC0_testing_o] = predict(mdlNB,data(testing,:));
                ROC0_training_o=ROC0_training_o(:,2);
                ROC0_testing_o=ROC0_testing_o(:,2);
                %             else
                %                 mdlKNN = fitcknn(data(training,:),label(training,:),'NumNeighbors',9,'Standardize',1);
                %                 [PredLabels_train,ROC0_training_o] = predict(mdlKNN,data(training,:));
                %                 [Predlabels_test,ROC0_testing_o] = predict(mdlKNN,data(testing,:));
                %                 ROC0_training_o=ROC0_training_o(:,2);
                %                 ROC0_testing_o=ROC0_testing_o(:,2);
            end
        end
        
        
    end
    
    
    %%%%ROC%%%%%%%
    [X1,Y1,~,AUC(m)] = perfcurve(label(testing),ROC0_testing_o,1);
    [X1tr,Y1tr,~,AUCtr(m)] = perfcurve(label(training),ROC0_training_o,1);
    %     plot (X1tr,Y1tr)
    for j=1:length(threshold)
        
        
        ROC0_training(find(ROC0_training_o<threshold(j)))=0;
        ROC0_training(find(ROC0_training_o>threshold(j)))=1;
        
        ROC0_testing(find(ROC0_testing_o<threshold(j)))=0;
        ROC0_testing(find(ROC0_testing_o>threshold(j)))=1;
        
        false_pos_train=length(find(ROC0_training(1:ben_train)==1));
        true_neg_train=ben_train- false_pos_train;
        if(~include)
            false_neg_train=length(find(ROC0_training(ben_train+1:ben_train+high_train)==0));
            true_pos_train=high_train- false_neg_train;
        else
            false_neg_train=length(find(ROC0_training(ben_train+1:ben_train+high_train+low_train)==0));
            true_pos_train=high_train+low_train- false_neg_train;
        end
        
        if(~include)
            sensitivity_train(j,m)=true_pos_train/high_train;
        else
            sensitivity_train(j,m)=true_pos_train/(high_train+low_train);
        end
        specificity_train(j,m)=true_neg_train/ben_train;
        PPV_train(j,m)=true_pos_train/length(find(ROC0_training==1));
        NPV_train(j,m)=true_neg_train/length(find(ROC0_training==0));
        
        
        false_pos_test=length(find(ROC0_testing(1:ben_test)==1));
        true_neg_test=ben_test- false_pos_test;
        if(~include)
            false_neg_test=length(find(ROC0_testing(ben_test+1:(ben_test+high_test))==0));
            true_pos_test=high_test- false_neg_test;
        else
            false_neg_test=length(find(ROC0_testing(ben_test+1:(ben_test+high_test+low_test))==0));
            true_pos_test=high_test+low_test- false_neg_test;
        end
        
        if(~include)
            sensitivity_test(j,m)=true_pos_test/high_test;
        else
            sensitivity_test(j,m)=true_pos_test/(high_test+low_test);
        end
        specificity_test(j,m)=true_neg_test/ben_test;
        PPV_test(j,m)=true_pos_test/length(find(ROC0_testing==1));
        NPV_test(j,m)=true_neg_test/length(find(ROC0_testing==0));
        
    end
    
end

AUC_m=mean(AUC);
AUC_trm=mean(AUCtr);
sensitivity_train_m=mean(sensitivity_train,2);
sensitivity_test_m=mean(sensitivity_test,2);
specificity_train_m=mean(specificity_train,2);
specificity_test_m=mean(specificity_test,2);
AUC=AUC';
AUCtr=AUCtr';
SenSpe=sensitivity_train_m+specificity_train_m;
[maxVal, idx_opt]=max(SenSpe);
% save ('Spec_train_svm_all.mat','specificity_train_m');
% save ('Sens_train_svm_all.mat','sensitivity_train_m');
% save ('Spec_test_svm_all.mat','specificity_test_m');
% save ('Sens_test_svm_all.mat','sensitivity_test_m');

figure();stairs(1-specificity_test_m,sensitivity_test_m,'r','linewidth',2)
xlabel('False positive rate')
ylabel('True positive rate')
set(gca,'fontsize',22);
figure();stairs(1-specificity_train_m,sensitivity_train_m,'r','linewidth',2)
xlabel('False positive rate')
ylabel('True positive rate')
set(gca,'fontsize',22);
