function [equ1]=getEachLine(BW,operator,line_t,line_b,n)
% returns every line corresponding to the operator.

equ1=ones(size(BW));
for i=1:n
    line=operator(line_t(i):line_b(i),:);
    [l,count]=bwlabel(line);
    if count >0
        %figure,imshow(line);
        equ1(line_t(i):line_b(i),:)=BW(line_t(i):line_b(i),:);
       
    end
    
end



end