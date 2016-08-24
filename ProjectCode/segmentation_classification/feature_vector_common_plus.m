function [max_h_proj_value_h, loc_h, max_h_proj_value_v, loc_v] = feature_vector_common_plus(img)
%function [max_h_proj_value_h, loc_h] = feature_vector_common_plus(img)

[max_h_proj_value_h, loc_h] = feature_vector_common(img);
[max_h_proj_value_v, loc_v] = feature_vector_common(rot90(img));
% [r,c] = size(img);
% AR = r/c;

end