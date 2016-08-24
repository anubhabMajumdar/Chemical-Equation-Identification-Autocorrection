function [final_eqation_text] = form_equation_text(operand_list, operator_list, operator_line)

[r,c] = size(operator_line);

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
    len = floor(mean_gap);
    se = strel('Line', len, 0);
    
    operator_line = imclose(operator_line, se);
    operator_line = im2bw(operator_line);
    [BW, n] = bwlabel(operator_line);
    stat = regionprops(BW, 'BoundingBox');
%%    
    final_eqation_text = cell(n,1);
    operator_count = 1;
    operand_count = 1;
%%    
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
        [~, count] = bwlabel(operand);
        if count == 1
            final_eqation_text{i} = operator_list{operator_count};
            operator_count = operator_count + 1;
        else
            final_eqation_text{i} = operand_list{operand_count};
            operand_count = operand_count + 1;
        end
    end
%%    
    final_eqation_text = final_eqation_text';

%% correction
[BW,n] = bwlabel(operator_line);
stat = regionprops(BW, 'BoundingBox');

for i=1:n-1
        if (strcmp(final_eqation_text{i},'+') || strcmp(final_eqation_text{i},'->') || strcmp(final_eqation_text{i},'<-') || strcmp(final_eqation_text{i},'=') || strcmp(final_eqation_text{i},'<->') || strcmp(final_eqation_text{i},'<=>'))
            bb = stat(i+1).BoundingBox;
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

            img = temp(r1:r2, c1:c2);
            [~, cc] = bwlabel(img);
            if cc == 1
                img = im2bw(img);
                img = add_padding(img);
                o = ocr(img, 'TextLayout','Block');
                txt = o.Text;
                final_eqation_text{i+1} = txt(1);
            end
        end
end

    


end


