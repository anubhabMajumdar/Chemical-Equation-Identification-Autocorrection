function [t] = up_down_arrow_type(operand)

[r,c] = size(operand);

half1 = operand(1:ceil(r/2),:);
half2 = operand(ceil(r/2):r,:);

% figure,imshow(half2);

[BW, ~] = bwlabel(half1);
stat = regionprops(BW, 'BoundingBox');
bb1 = stat(1).BoundingBox;

[BW, ~] = bwlabel(half2);
stat = regionprops(BW, 'BoundingBox');
bb2 = stat(1).BoundingBox;

if bb1(3)>bb2(3)
    t = '^';
else
    t = 'v';
end
end