function [out]=pad(char)

[r, c] = size(char);
 out = zeros(r+20,c+20);
 out(10:10+r-1, 10:10+c-1) = char;
 out=imclose(out,strel('square',2));


end