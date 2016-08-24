function [ cw_gap ] = char_gap( img,line_t,line_b,n,N,cw_gap )

CC = bwconncomp(img);
STATS = regionprops(CC,'Area','PixelIdxlist','BoundingBox');
m = CC.NumObjects;
L = bwlabel(img);
comp = zeros(1,m);
for i =1:n
    count = 0;
    q = 0;
    for k = 1:N
        for j = line_t(i):line_b(i)
            p = L(j,k);
            if(p > 0 && comp(p) == 0 && STATS(p).BoundingBox(4) > 8)
                if(count == 0)
                    comp(p) = 1;
                    q = p;
                    count = count + 1;
                    
                else
                    s = ceil(STATS(p).BoundingBox(1));
                    t = ceil(STATS(q).BoundingBox(1)) + STATS(q).BoundingBox(3) -1;
                    %display([num2str(s-t) ' ' num2str(p) ' ' num2str(s) ' ' num2str(q) ' ' num2str(t)]);
                    if((s-t) <= 0 || (s-t) > 200)
                        %continue;
                        comp(p) = 1;
                        break;
                    end
                    cw_gap(s-t) = cw_gap(s-t) + 1;
                    comp(p) = 1;
                    q = p;
                end
                
            end
            
        end
    end
end


end

