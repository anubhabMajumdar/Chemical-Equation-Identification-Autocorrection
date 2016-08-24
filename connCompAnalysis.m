function [I,mcw,mche,w,he]=connCompAnalysis(I)
% connected component analysis
% height width of every character
% median height,width calculation

% removal of small components
CC = bwconncomp(I);
STATS = regionprops(CC,'BoundingBox','PixelIdxList','Area');
n = CC.NumObjects;
for i = 1:n
    if(STATS(i).Area < 10)
        I(CC.PixelIdxList{i})= 0;
    end
end
%imtool(~BW);
CC = bwconncomp(I);
STATS = regionprops(CC,'BoundingBox','PixelIdxList','Area');
n = CC.NumObjects;
w = zeros(1,n);
he = zeros(1,n);
for i = 1:n
    w(i) = STATS(i).BoundingBox(3);
    he(i) = STATS(i).BoundingBox(4);
end
mcw = median(w);%Median Character width
mche = median(he);%Median Character height




end