function [op, im] = openImg(im)

[~,c] = size(im);
len = round(c/2);
s = strel('line', len , 0);
im = imopen(im, s);

c = find(im==1, 1);

if isempty(c)
    op = 0;
else
    op = 1;
end
end