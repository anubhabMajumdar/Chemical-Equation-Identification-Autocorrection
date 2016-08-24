function [h]=HProj2image(h_proj,I)
%creates a binary image from input h_proj and gets rid of the projections
%which are lesser than a certain value
% h : final horizontal projection image

% for i = 1:M
%     if(h_proj(i) < 8)
%         h_proj(i) = 0;
%     end
% end
[M,N]=size(I);
h = zeros(size(I));
for i = 1:M
    for j = 1:N
        if(h_proj(i) > 0)
            h(i,j) = 1;
            h_proj(i) = h_proj(i) -1;
        end
    end
end
%figure,imshow(h),title('horizontal projection');

% CC = bwconncomp(h);
% STATS = regionprops(CC,'Area','PixelIdxlist','BoundingBox');
% n = CC.NumObjects;
%   
%   for i = 1:1:n
%         if(STATS(i).BoundingBox(4) < 10)
%             h(CC.PixelIdxList{i}) = 0;
%         end
%   end

end