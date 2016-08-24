% count diagonal black_pixels

function [d_left, d_right] = count_diagonal_blacks(img)

d_left = 0;
d_right = 0;

[r,~] = size(img);

for i=1:r
    if img(i,i) == 0
        d_left = d_left + 1;
    end
    
    if img(i,r-i+1) == 0
        d_right = d_right + 1;
    end
end

end
