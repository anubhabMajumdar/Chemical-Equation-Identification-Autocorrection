function [result] = feature_vector_plus(img)

[max_h_proj_value_h, loc_h] = feature_vector_common(img);
[max_h_proj_value_v, loc_v] = feature_vector_common(rot90(img));

%[r,c] = size(img);
% bw = bwlabel(img);
% stat = regionprops(bw, 'Centroid');
% centroid_calc = stat(1).Centroid;
% dist = sqrt((power((centroid_calc(1)-r),2)) + (power((centroid_calc(2)-c),2)));

x = imclose(img,strel('line', 2,0));
x = imclose(x,strel('line', 2,90));
b1 = bweuler(~x);

fvm = feature_vector_minus(img);
result = [max_h_proj_value_h, loc_h, max_h_proj_value_v, loc_v, fvm, b1];
%result = [loc_h, loc_v, b1];

end