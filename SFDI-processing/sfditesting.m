folder_ovary = 'C:\Users\OCT-PC\Desktop\SFDI-TEST\patient5ovary';
folder_colon2 = 'C:\Users\OCT-PC\Desktop\SFDI-TEST\patientcolon';
folder_colon = 'C:\Users\OCT-PC\Desktop\SFDI-TEST\20180926-Colon-Patient152';
%%
figure, imagesc(Mua_result(:,:,1)), colormap('jet'), colorbar;
figure, imagesc(Musp_result(:,:,1)), colormap('jet'), colorbar;
%%
for fq = 1:3
    move = 80;
    temp = phantom(:,:,1,fq);
    temp = [temp(:,end-move+1:end),temp(:,1:end-move)];
    phantom(:,:,1,fq) = temp;
end
%%
dc = mdcref(:,:,1);
ac = macref_o(:,:,1);
%%
fftdc = fft2(dc);
figure, imagesc(abs(fftshift(fftdc)))
fftac = fft2(ac);
figure, imagesc(abs(fftshift(fftac)))
%%
fftdcs = fftshift(fftdc);
mirror = ones(size(fftdcs));
% mirror(456:506,616:666) = 0;
mirror(:,:) = 0;
mirror(481,641) = 1;
% mirror(481,[645,652,653,637,630,629,642,640])=0;
% mirror([480,482],641)=0;
fftdcs = fftdcs.*mirror;
% fftacs(381:581,541:741)=0;
% fftacs(641,481)=0;
dcinv = ifft2(fftdcs);
dcinvt = abs(dcinv);
% acinvt(acinvt>100)=0;
figure, imagesc(dcinvt);
%%
fftacs = fftshift(fftac);
mirror = ones(size(fftacs));
mirror(:,:) = 0;
% mirror(471:491,631:651) = 1;
mirror(481,641) = 1;
% mirror(481,[645,652,653,637,630,629,642,640])=0;
% mirror([480,482],641)=0;
fftacs = fftacs.*mirror;
% fftacs(381:581,541:741)=0;
% fftacs(641,481)=0;
acinv = ifft2(fftacs);
acinvt = abs(acinv);
% acinvt(acinvt>100)=0;
figure, imagesc(acinvt);
%%
ffttest = dct2(test);
figure, imagesc(abs(fftshift(ffttest)))
figure, imagesc(abs(ffttest))
ffttestinv = (ffttest);
% ffttestinv(1:50,1:50)=0;
% ffttestinv(end-49:end,1:50)=0;
% ffttestinv(end-49:end,end-49:end)=0;
% ffttestinv(1:50,end-49:end)=0;
ffttestinv(50:449,100:600)=0;
%%
dccount = 1;
for Rdc = 0.0109:0.0001:1
    account = 1;
    for Rac = 0.0001:0.0001:0.7863
        ref(1,1) = Rdc; ref(2,1) = Rac;
        fun = @(mu) diffuse(mu,ref);
        x0 = [0.0000000000001,0.0000001];
        x = fsolve(fun,x0);
        MuaF(account,dccount)  = x(1);
        MuspF(account,dccount) = x(2);
        account = account+1;
    end
    dccount = dccount+1;
end