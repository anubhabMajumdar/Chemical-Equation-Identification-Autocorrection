function [ar] = aspect_ratio(im)

[r,c] = size(im);

ar = c/r;

end