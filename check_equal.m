function [operator_line] = check_equal(operator_line)

[M,N] = size(operator_line);

% CC = bwconncomp(operator_line);
% STATS = regionprops(CC,'BoundingBox','PixelIdxList','Area');
% n = CC.NumObjects
[operator_line,n]=bwlabel(operator_line);
STATS = regionprops(operator_line,'BoundingBox','PixelIdxList','Area');

he = zeros(1,n);

for i = 1:n
    he(i) = STATS(i).BoundingBox(4);
end

mche = mean(he);%Median Character height

for i=1:n
    bb = STATS(i).BoundingBox;
    img = imcrop(operator_line,bb);
    
    if ((bb(4) < 3*bb(3)/5))
        %this means -
        
        right = round(bb(1));
        left = round(bb(1)+ bb(3));
        
        %scan down
        down_start = round(bb(2) + bb(4));
        down_end = down_start + round(bb(3)); 
        mid = round(bb(1)+(bb(3)/2));
        
        for j=down_start:down_end
            if (j<M && operator_line(j,mid) > 0 )
                label = operator_line(j,mid)
                bb_down = STATS(label).BoundingBox;
                %img_down = imcrop(operator_line,bb_down);
                
                if ((bb_down(4) < 3*bb_down(3)/5))
                    operator_line(round(bb(2)):j,right:left) = 1;
                end
                break
            end
        end
        
        %up scan
        
        up_start = round(bb(2) - bb(4));
        up_end = up_start - round(bb(3)); 
        mid = round(bb(1)+round(bb(3)/2));
        
        for j=up_start:-1:up_end
            if (j>=1 && operator_line(j,mid) > 0 )
                label = operator_line(j,mid)
                bb_up = STATS(label).BoundingBox;
                
                if ((bb_up(4) < 3*bb_up(3)/5))
                    operator_line(j:round(bb(2)),right:left) = 1;
                end
                break
            end
        end
    end
    
                
end
end
                
    
    
    
    
    
    
    