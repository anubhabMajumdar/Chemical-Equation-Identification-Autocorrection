function [mean_gap] = average_char_gap(line)

[BW, n] = bwlabel(line);
stat = regionprops(BW, 'BoundingBox');
gap = zeros(n-1,1);

for i=1:(n-1)
    bb1 = stat(i).BoundingBox;
    bb2 = stat(i+1).BoundingBox;
    
    x1 = bb1(1);
    w1 = bb1(3);
    x2 = bb2(1);
    
    gap(i) = ceil(x2 - (x1 + w1));
end

mean_gap = mean(gap);
end