function [seg]=segmentInLine(equation,operand,operator)

seg=operator;
[operator,operatorNum]=bwlabel(operator);
stat=regionprops(operator,'BoundingBox');
[operand,num]=bwlabel(operand);
statOprnd=regionprops(operand,'BoundingBox');
%imshow(operand);
temp=zeros(size(equation));
for i=1:operatorNum
    left=round(stat(i).BoundingBox(1));
    right=round(left+stat(i).BoundingBox(3));
    mid=round(stat(i).BoundingBox(2)+stat(i).BoundingBox(4)/2);
    for l=left:-1:1
        if operand(mid,l)>0
            label=operand(mid,l);
            [r,c]=find(operand==label);
            for a=1:numel(r)
                seg(r(a),c(a))=equation(r(a),c(a));
            end
           break;
        end
    end
   % figure,imshow(seg),title('left scan');
    for r=right:size(operator,2)
        if operand(mid,r)>0
            label=operand(mid,r);
            [r,c]=find(operand==label);
            for a=1:numel(r)
                seg(r(a),c(a))=equation(r(a),c(a));
            end
            break;
        end
    end
    %figure,imshow(seg),title('right scan');
end




end