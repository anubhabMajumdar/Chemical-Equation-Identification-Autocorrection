function [h_proj2] = image_to_hProj(image2)

[M2,N2] = size(image2);
    %Horizonal Projection of remaining characters
h_proj2 = zeros(1,M2);  
for i = 1:M2
    for j = 1:N2
        if(image2(i,j) == 1)
            h_proj2(i) = h_proj2(i) + 1;
        end
    end
end
end
