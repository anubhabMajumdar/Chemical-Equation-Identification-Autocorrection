function [max_h_proj_value, loc] = feature_vector_common(img)

[r,c] = size(img);
h_proj = HProj(img);
max_h_proj_value = max(h_proj);
max_h_proj_location = find(h_proj == max_h_proj_value);

% below_center_location = find(max_h_proj_location >= (r/2));
% above_center_location = find(max_h_proj_location < (r/2));
% 
% if ~isempty(below_center_location) && ~isempty(above_center_location)
%     closest_below = min(below_center_location) - (r/2);
%     closest_above = (r/2) - max(above_center_location);
%     m = min(closest_above, closest_below);
%     if m == closest_above
%         loc = max(above_center_location);
%     else
%         loc = min(below_center_location);
%     end
% elseif ~isempty(below_center_location)
%     loc = min(below_center_location);
% else
%     loc = max(above_center_location);
% end
% 
% loc = loc/(r/2);
max_h_proj_value = max_h_proj_value/c;
relative_val = abs(max_h_proj_location - (r/2));
min_val = min(relative_val);
index = find(relative_val == min_val);
if numel(index) > 1
    index = index(1);
end
loc = max_h_proj_location(index);
loc = loc/(r/2);

end

