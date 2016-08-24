function [out] = add_padding(col_img)

    x = 50;
    [r, c] = size(col_img);
        
        out = zeros(x,x);
        if (r>x)
            col_img = imresize(col_img, [x, c]);
            r = x;
        end
        
        if (c>x)
            col_img = imresize(col_img, [r, x]);
            c = x;
        end
        
        row_extra = x - r;
        col_extra = x - c;
        
        if row_extra > 0
            start_row = ceil(row_extra/2);
        else
            start_row = 1;
        end
        
        if col_extra > 0
            start_col = ceil(col_extra/2);
        else
            start_col = 1;
        end
        
        out(start_row:start_row + r - 1, start_col:start_col + c - 1) = col_img;
%         se = strel('square', 5);
%         out = imdilate(out, se);
%          
end
