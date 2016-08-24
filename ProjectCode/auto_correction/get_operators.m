function [operand_img, operator_img] = get_operators(line, operator_line)

[r,c] = size(operator_line);
operator_img = zeros(r,c);
operand_img = zeros(r,c);

operator_line = im2bw(operator_line);
temp = operator_line;
[BW, n] = bwlabel(operator_line);
stat = regionprops(BW, 'BoundingBox');

mean_gap = average_char_gap(operator_line);

for j=1:n
        bb=stat(j).BoundingBox;
        r1=round(bb(2));
        c1=round(bb(1));
        r2=r1+round(bb(4));
        c2=c1+round(bb(3));
        operator_line(r1:r2,c1:c2)=1;
end
%figure, imshow(line);
    len = floor(mean_gap);
    se = strel('Line', len, 0);
    
    operator_line = imclose(operator_line, se);
%    imwrite(~operator_line,'D:\Google Drive\#ICDAR\Paper_work\ICDAR 1.0\ppt\closedSingleCharEqu.png');
%     figure,imshow(temp);
%     figure,imshow(line);
    operator_line = im2bw(operator_line);
    [BW, n] = bwlabel(operator_line);
    stat = regionprops(BW, 'BoundingBox');
    %figure,imshow(temp);
    
    for i=1:n
        bb=stat(i).BoundingBox;
        r1=ceil(bb(2));
        c1=ceil(bb(1));
        r2=r1 + floor(bb(4));
        c2=c1 + floor(bb(3));
        
        if r2 > r
            r2 = r;
        end
        if c2 > c
            c2 = c;
        end
        
        operand = temp(r1:r2, c1:c2);
        %figure,imshow(operand);
        [~, count] = bwlabel(operand);
        if count == 1
            operator_img(r1:r2, c1:c2) = line(r1:r2, c1:c2);
        else
            operand_img(r1:r2, c1:c2) = operand;
        end
    end
    
    
end


