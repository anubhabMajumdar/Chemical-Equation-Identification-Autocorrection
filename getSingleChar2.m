function [normal]=getSingleChar2(normal,closed)

CC=bwconncomp(closed);
statClose=regionprops(CC,'Area','PixelIdxlist','BoundingBox');
m=CC.NumObjects; % number of blobs

 for i=1:m
     bb=statClose(i).BoundingBox;
     cropped=imcrop(normal,bb);
     [~,count]=bwlabel(cropped);
     
         
         
     if count~=1
            %figure,imshow(cropped);
            
            area = bwarea(cropped);

            CC2=bwconncomp(cropped);
            statClose2=regionprops(CC2,'Area','BoundingBox');
            m2=CC2.NumObjects; % number of blobs in cropped

            for k=1:m2
                
                bb2=statClose2(k).BoundingBox;
                cropped2=imcrop(cropped,bb2);
                
                area2 = bwarea(cropped2);
                
                if (area2/area == 1)
                   % figure,imshow(cropped2);
                else
                    rT=round(bb2(2));
                    cT=round(bb2(1));
                    cropped(rT:rT+bb2(4),cT:cT+bb2(3))=0;
                    
                end
                
            end
            
            %figure,imshow(cropped);
            rT=round(bb(2));
            cT=round(bb(1));
            [x,y] = size(cropped);
            normal(rT:rT+x-1,cT:cT+y-1)=cropped;
                    
     end
     
     
end
 end
         
    
