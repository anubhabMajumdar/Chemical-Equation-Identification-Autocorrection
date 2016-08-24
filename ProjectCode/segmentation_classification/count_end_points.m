function [end_points] = count_end_points(im)

im = add_padding(im);
BW = bwmorph(im,'skel',Inf);
c = corner(BW);

[end_points,~] = size(c);

end