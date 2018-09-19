% This code read R G B images respectively and combine them to a pseudocolor image
%%
r = imread('Blood Vessel 2 R.bmp');
g = imread('Blood Vessel 2 G.bmp');
b = imread('Blood Vessel 2 B.bmp');
% C(:,:,1) = r(:,:,1);
% C(:,:,2) = g(:,:,2);
% C(:,:,3) = b(:,:,3);
C = (r.*0.85+g.*0.6+b.*7.*0.43);
% axes(handles.axes2);
figure,imshow(C);

%%
figure,imshow(r(:,:,3));
figure,imshow(g(:,:,3));
figure,imshow(b(:,:,3));

