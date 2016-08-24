function [operator_img, operator_list] = ocr_of_operators(operator_img)

[BW,n] = bwlabel(operator_img);
stat = regionprops(BW, 'BoundingBox');
operator_list = cell(n,1);

for i=1:n
bb = stat(i).BoundingBox;
img = imcrop(BW,bb);
img = im2bw(img);
img = add_padding(img);
o = ocr(img, 'TextLayout','Block');
txt = o.Text;
% figure, imshow(img), title(txt);
if strcmp(cellstr(txt), '+')
    operator_list{i} = '+';
    r1=round(bb(2));
    c1=round(bb(1));
    r2=r1+round(bb(4));
    c2=c1+round(bb(3));
    operator_img(r1:r2,c1:c2)=0;
end

end