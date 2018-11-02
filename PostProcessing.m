% This is a collection of postprocessing codes I used for OCT
%%
slicenum = 900;
dataname = ['P3DOCTSlice',num2str(slicenum),'.bmp'];
img = imread(dataname);
figure,imshow(img);
% img(1:125,:) = 0;

%% For imgm Matrix
n = 1;
for slicenum = 474:1699
    dataname = ['P10mmby20mm3DOCTSlice',num2str(slicenum),'.bmp'];
    imgo = imread(dataname);
    imgm(:,:,n) = imgo;
    n = n+1;
end
save imgm imgm;

%% For Start Point for the Surface
figure, imshow(imgm(:,:,1));
figure, imshow(imgm(:,:,101));
figure, imshow(imgm(:,:,201));
figure, imshow(imgm(:,:,301));
figure, imshow(imgm(:,:,401));
figure, imshow(imgm(:,:,501));
figure, imshow(imgm(:,:,601));
figure, imshow(imgm(:,:,701));
figure, imshow(imgm(:,:,801));
figure, imshow(imgm(:,:,901));
figure, imshow(imgm(:,:,1001));
figure, imshow(imgm(:,:,1101));
figure, imshow(imgm(:,:,1201));

%% Image Post-Processing for Scattering Map
usp_p = usp;
usp_p(usp_p<=0) = -1;
usp_p(usp_p>20) = 20;
figure,imagesc(usp_p);colormap(jet);colorbar;
uspf = medfilt2(usp_p,[5 5]);
figure,imagesc(uspf);colormap(jet);colorbar;caxis([-1 20]);
set(gca,'fontsize',30);

%% Jet Colormap
uspf = medfilt2(usp_p,[5 5]);
figure,imagesc(uspf);colormap(jet);colorbar;caxis([-1 20]);
set(gca,'fontsize',30);
set(gca,'XTickLabel',{'mm','2',' ','4',' ','6',' ','8',' ','10'})
set(gca,'YTickLabel',{' ','4',' ','3',' ','2',' ','1','mm',' ',' '})
c = colorbar; c.TickLabels = {'0',' ','4',' ','8',' ','12',' ','mm^{-1}','18',''};
%% Box Plot for Statistic
C = [uspnormal' uspcancer'];
grp = [zeros(1,292452),ones(1,292969)];
figure,boxplot(C,grp);
 
%% For Surface Checking
load imgm; load surface;
fpath = 'E:\Yifeng Zeng\!PhD Work\Projects\OCT\Rectum-Data-Processing\!Final-Processing\Patient137\First-Scan\SurfaceCheck';
for i = 1:size(imgm,3)
    imgo = imgm(:,:,i); dataname = ['image',num2str(i),'.bmp'];
    imshow(imgo);hold on
    plot(surface(i,:)','Linewidth',6,'Color','r'); title(num2str(i));
    hold off; 
    saveas(gcf,fullfile(fpath,dataname));
end

%% Check whether the Deletion is Good or not and Ready for 3D Rendering
load imgm; load surface;
fpath = 'E:\Yifeng Zeng\!PhD Work\Projects\OCT\Colon Data Processing\Patient3\Part2 Normal\imgm700to1199\SurfaceDel';
thickness = 160;
for slicenum = 1:500
    imgo = imgm(:,:,slicenum); 
    dataname = ['image',num2str(slicenum),'.bmp'];
    for i = 1:1000
        imgo(1:surface(slicenum,i),i)=0;
        imgo(surface(slicenum,i)+thickness:1000,i)=0;
    end
    imwrite(imgo,fullfile(fpath,dataname),'bmp');
end

%% Mean and Standard Deviation
us = [usp(1:120,300:600);usp(221:500,300:600)];
us = us(:);
a = us>0&us<10;
us = us.*a;
us(us==0) = [];
aave = mean(us);
astd = std(us);
uspwavelettwicedepthcom = us;

%% Remove White Space of Saved Image
figure,imagesc(uspp);colormap(jet);
set(gca,'fontsize',20,'xtick',[],'ytick',[]);
tightInset = get(gca, 'TightInset');
position(1) = tightInset(1);
position(2) = tightInset(2);
position(3) = 1 - tightInset(1) - tightInset(3);
position(4) = 1 - tightInset(2) - tightInset(4);
set(gca, 'Position', position);
fpath = 'E:\Yifeng Zeng\!PhD Work\Projects\OCT\Colon Data Processing\! Final Processing\~Scattering Map\heterogeneity';
dataname = ['P3Cancer.tif'];
saveas(gcf,fullfile(fpath,dataname));

%% Error-Processing
b = usp>0 & usp<20;
errorafter = err.*b;
errorafter = errorafter(:);
errorafter(errorafter==0)=[];
m2 = mean(errorafter>0&errorafter<10);
s2 = std(errorafter>0&errorafter<10);
m1 = mean(errorafter);
s1 = std(errorafter);

%% Area Extraction
figure
imagesc(uspf);
colormap Gray
h1=imfreehand;
BW=createMask(h1);

figure
imagesc(BW);colormap(gray)

uspf = uspf.*BW;

%%
us2 = (usp_p(:,1) usp_p usp_p(:,1000));
while length(find(us2>6.9))>0
for k = 2:501
    j = 2;
    while j<1002
        if us2(k,j)>6.9
            us2(k,j)=(us2(k-1,j)+us2(k+1,j)+us2(k,j-1)+us2(k,j+1))/4;
        end
        j = j+1;
    end
  
end
  last = this;
  this = length(find(us2>6.9));
  if last == this
      break;
  end
end
