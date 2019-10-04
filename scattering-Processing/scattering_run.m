%%
n = 1;
for slicenum = 0:699
    dataname = ['P3DOCTSlice',num2str(slicenum),'.bmp'];
    imgo = imread(dataname);
    imgm(:,:,n) = imgo;
    n = n+1;
end
for i = [1,201,401,601]
    imgm(:,:,i) = imgm(:,:,i+1);
end
save imgm imgm;

%%
n = 1;
for slicenum = 900:1499
    dataname = ['P10mmby20mm3DOCTSlice',num2str(slicenum),'.bmp'];
    imgo = imread(dataname);
    imgm(:,:,n) = imgo;
    n = n+1;
end
save imgm imgm;

%%
figure, imshow(imgm(:,:,1));
figure, imshow(imgm(:,:,101));
figure, imshow(imgm(:,:,201));
figure, imshow(imgm(:,:,301));
figure, imshow(imgm(:,:,401));
figure, imshow(imgm(:,:,501));
figure, imshow(imgm(:,:,601));
% figure, imshow(imgm(:,:,701));
% figure, imshow(imgm(:,:,801));
% figure, imshow(imgm(:,:,901));

%%
p39ts2 = batch('potentialSurfaceOpti1_2');

%% For Surface Checking
load imgm; load surface;
figure,
% fpath = 'E:\Yifeng Zeng\!PhD Work\Projects\OCT\Rectum-Data-Processing\!Final-Processing\Patient137\First-Scan\SurfaceCheck';
for i = 1:size(imgm,3)
    imgo = imgm(:,:,i); dataname = ['image',num2str(i),'.bmp'];
    imshow(imgo);hold on
    plot(surface(i,:)','Linewidth',6,'Color','r'); title(num2str(i));
    hold off;
    pause(0.01);
%     saveas(gcf,fullfile(fpath,dataname));
end