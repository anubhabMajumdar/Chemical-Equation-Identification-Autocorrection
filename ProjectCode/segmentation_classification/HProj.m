function [h_proj]=HProj(I)
%returns the horizontal projectionof image array I
[M,N]=size(I);
h_proj = zeros(1,M);  
for i = 1:M
    for j = 1:N
        if(I(i,j) == 1)
            h_proj(i) = h_proj(i) + 1;
        end
    end
end
end