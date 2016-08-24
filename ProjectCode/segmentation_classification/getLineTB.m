function [line_t,line_b,lw,n]=getLineTB(h)
% rerurns two arrays including row value of line top and bottom
% line_t : line top of each line
% line_b : line bottom of each line
% n = number of text lines.
CC = bwconncomp(h);
STATS = regionprops(CC,'BoundingBox');
n = CC.NumObjects;
lw=0;
line_t = zeros(1,n);
line_b = zeros(1,n);
for i = 1:n
    line_t(i)= ceil(STATS(i).BoundingBox(2));
    line_b(i)= line_t(i) + STATS(i).BoundingBox(4)-1;
end
for i=1:n
     if(i > 1 && i < n)
         lw(i) = (line_t(i) - line_b(i-1));
    end
end



end