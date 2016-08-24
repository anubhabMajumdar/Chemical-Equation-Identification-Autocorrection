function [m,coord] = return_peak_location(h_proj2)


temp = h_proj2;
%imshow(temp);

coordinate= find(temp==max(temp));
m=max(temp);


coord = median(coordinate);

end