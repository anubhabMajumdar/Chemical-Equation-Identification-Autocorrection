function [v]=vProj(I)
%removes the vertical projection

[row,col]=size(I);
        v=zeros(1,col);
        for j=1:col
            for R=1:row
                if I(R,j)==1
                    v(j)=v(j)+1;
                end
            end
        end
end