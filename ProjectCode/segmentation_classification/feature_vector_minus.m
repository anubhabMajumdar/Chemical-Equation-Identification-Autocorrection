function [result] = feature_vector_minus(img)

[r,c] = size(img);
count_one = find(img==1);
count_zero = find(img==0);

density =(numel(count_one)/numel(count_zero)); 
% AR = c/r;
% 
% result = [density, AR];
result = density;
end