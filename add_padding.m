function [out] = add_padding(col_img)

     [r, c] = size(col_img);
     out = zeros(r+20,c+20);
     out(10:10+r-1, 10:10+c-1) = col_img;
     se = strel('square', 5);
     out = imclose(out, se);
           
end
