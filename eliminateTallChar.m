function [I]=eliminateTallChar(I,mcw,mche)
% eliminate characters which are longer and wider than average

CC = bwconncomp(I);
STATS = regionprops(CC,'BoundingBox','PixelIdxList','Area');
n = CC.NumObjects;

for i = 1:n
    if(STATS(i).BoundingBox(4)> 20*mche  || STATS(i).BoundingBox(3)> 35*mcw)
        I(CC.PixelIdxList{i})= 0;
    end
end


end