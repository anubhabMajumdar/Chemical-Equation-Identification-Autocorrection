function [operand_list, operator_list] = make_lists(operand_img, operator_img)

char_gap = average_char_gap(operand_img);
se = strel('Line', char_gap, 0);
temp = operand_img;
[BW, n] = bwlabel(operand_img);
stat = regionprops(BW, 'BoundingBox');
for j=1:n
        bb=stat(j).BoundingBox;
        r1=round(bb(2));
        c1=round(bb(1));
        r2=r1+round(bb(4));
        c2=c1+round(bb(3));
        operand_img(r1:r2,c1:c2)=1;
end

closed_img = imclose(operand_img, se);
operand_img = temp;
%% operand list

[BW, n] = bwlabel(closed_img);
stat = regionprops(BW, 'BoundingBox');
operand_list = cell(n,1);

for i=1:n
    bb = stat(i).BoundingBox;
    operand = imcrop(operand_img, bb);
    str = getEachCharacter(operand);
    %figure,imshow(operand);%,title(str);
    
    operand_list{i} = str;
end

%% operator list

closed_equal = check_equal(operator_img);
[BW, n] = bwlabel(closed_equal);
stat = regionprops(BW, 'BoundingBox');
operator_list = cell(n,1);

for i=1:n
    bb = stat(i).BoundingBox;
    operand = imcrop(operator_img, bb);
    [~, count] = bwlabel(operand);
    [r,c] = size(operand);
    flag = 0;
    
    if flag == 0
        if count > 1
            t = equal_or_reversible(operand);
            operator_list{i} = t;
        else

              if (r/c)>=0.8
                operator_list{i} = '+';
              else
                  t = arrow_type(operand);
                  operator_list{i} = t;
              end
        end
    end
end
end