function [L,U,M]=getZones(stat,numChar)

for i=1:numChar
    bb=stat(i).BoundingBox;
    col=round(bb(1));
    row=round(bb(2));
    width=round(bb(3));
    height=round(bb(4));
    top(i)=row;
    bottom(i)=(row+height);
    
end

L=round(median(bottom));
U=round(median(top));
M=round((L+U)/2);
end