function [t] = equal_or_reversible(operand)

operand = add_padding(operand);
[r,c] = size(operand);
change = zeros(c,1);

for i=1:c
    for j=1:r-1
        if xor(operand(j,i), operand(j+1,i))
            change(i) = change(i) + 1;
        end
    end
end

max_change = max(change);

if max_change == 4
    t = '=';
else
    t = '<=>';
end
end


            
        
            