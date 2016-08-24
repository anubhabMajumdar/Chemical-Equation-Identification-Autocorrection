function [fv] = feature_vector_2(img)

% im is a binary image 
[r,c] = size(img);

%%   c/r ratio
ratio = c/r;

%% regionprops

img = add_padding(img);
stat = regionprops(img, 'Area', 'Perimeter', 'Centroid', 'Extrema', 'MajorAxisLength', 'MinorAxisLength', 'Orientation');


%% HProj and VProj

h_proj = HProj(img);
v_proj = HProj(rot90(img));
h_proj_moment2 = moment(h_proj,2);
h_proj_moment3 = moment(h_proj,3);
v_proj_moment2 = moment(v_proj,2);
v_proj_moment3 = moment(v_proj,3);

h1 = max(h_proj);
v1 = max(v_proj);

hp1 = find(h_proj == h1);
vp1 = find(v_proj == v1);

%%

fv = [ratio, stat.Area, stat.Perimeter, stat.MajorAxisLength, stat.MinorAxisLength, stat.Orientation, h_proj_moment2, h_proj_moment3, v_proj_moment2, v_proj_moment3, h_proj, v_proj, h1, v1, hp1(1), vp1(1)];
%fv = [h_proj, v_proj];
end