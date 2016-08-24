function [left_d, right_d] = diagonal_white_black_pixel(im)

[r,c] = size(im);
m = min(r,c);
im = imresize(im, [m,m]);

%%
b_count = 0;
w_count = 0;

for i=1:m
    if im(i,i) == 1
        w_count = w_count + 1;
    else
        b_count = b_count + 1;
    end
end
  
left_d = b_count/w_count;

%%
b_count = 0;
w_count = 0;

for i=1:m
    if im(i,m-(i-1)) == 1
        w_count = w_count + 1;
    else
        b_count = b_count + 1;
    end
end
  
right_d = b_count/w_count;

end