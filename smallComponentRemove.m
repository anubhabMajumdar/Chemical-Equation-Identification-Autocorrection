function [I]=smallComponentRemove(I)

CC = bwconncomp(I);
STATS = regionprops(CC,'BoundingBox','PixelIdxList','Area');
n = CC.NumObjects;
for i = 1:n
    if(STATS(i).BoundingBox(3) < 15 && STATS(i).BoundingBox(4)<15)
        I(CC.PixelIdxList{i})= 0;
    end
end
end