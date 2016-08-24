function [operator_list] = flag_up_down_arrow(operator_line, operator_list)

%figure, imshow(operator_line);
[r,c] = size(operator_line);
operator_line = im2bw(operator_line);
temp = operator_line;
[BW, n] = bwlabel(operator_line);
stat = regionprops(BW, 'BoundingBox');
op_count = 0;

mean_gap = average_char_gap(operator_line);

for j=1:n
        bb=stat(j).BoundingBox;
        r1=round(bb(2));
        c1=round(bb(1));
        r2=r1+round(bb(4));
        c2=c1+round(bb(3));
        operator_line(r1:r2,c1:c2)=1;
end
len = floor(mean_gap);
se = strel('Line', len, 0);
   
operator_line = imclose(operator_line, se);
%imshow(operator_line);

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
            op_count = op_count + 1;
                
            if i==n
                t = up_down_arrow_type(operand);
                operator_list{op_count} = t;
                
                %figure,imshow(operand), title('up/down');
            else
                bb2=stat(i+1).BoundingBox;
                r1=ceil(bb2(2));
                c1=ceil(bb2(1));
                r2=r1 + floor(bb2(4));
                c2=c1 + floor(bb2(3));
        
                if r2 > r
                    r2 = r;
                end
                if c2 > c
                    c2 = c;
                end

            operand2 = temp(r1:r2, c1:c2);
            %figure,imshow(operand);
            [~, count2] = bwlabel(operand2);
            if count2 == 1
                t = up_down_arrow_type(operand);
                operator_list{op_count} = t;
                %figure,imshow(operand), title('up/down');
            end
            end
        end
    end
end