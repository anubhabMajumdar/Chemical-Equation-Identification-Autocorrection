function [fv] = feature_vector_hog(img)

fixed_size = 20;

result = zeros(fixed_size);

img = imresize(img, [NaN, fixed_size]);
[r,~] = size(img);

remaining = fixed_size - r;

if (remaining > 0)

    start = round(remaining/2);
    result(start:start+r-1,:) = img;

else if (remaining < 0)
    remaining = abs(remaining);
    start = ceil(remaining/2);
    bottom = floor(remaining/2);
    result(:,:) = img(start:r-bottom-1,:); 
    
    else
    result = img;
    end
end    
   fv = extractHOGFeatures(result);
end