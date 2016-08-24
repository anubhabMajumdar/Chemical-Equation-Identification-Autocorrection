function [normal]=getSingleChar(normal,closed)
%returns an image containing only single characters
% figure,imshow(normal),title('normal');
% figure,imshow(closed),title('closed');
CC=bwconncomp(closed);
statClose=regionprops(CC,'Area','PixelIdxlist','BoundingBox');
m=CC.NumObjects; % number of blobs

 for i=1:m
     bb=statClose(i).BoundingBox;
     area = statClose(i).Area;
     cropped=imcrop(normal,bb);
     [~,count]=bwlabel(cropped);
    
    
     if (count > 1)
         % special checking for arrow 
         %cropped = detectOperator2(im2bw(cropped),model);
         figure,imshow(cropped),title(['count ',num2str(count)]);
         %figure,imshow(cropped),title('before');
         CC2=bwconncomp(cropped);
         statClose2=regionprops(CC2,'BoundingBox','Area');
         m2=CC2.NumObjects; % number of blobs
            
         for k=1:m2
                
              bb2=statClose2(k).BoundingBox;
              area2 = statClose2(k).Area;
              
              cropped2=imcrop(cropped,bb2);
              
              if (area2 ~= area)%((area2/area) < 0.8)
                rT=round(bb2(2));
                cT=round(bb2(1));
                cropped2(rT:rT+bb2(4),cT:cT+bb2(3))=0;
              end
          end
          
         figure,imshow(cropped2),title('after');
         
         rT=round(bb(2));
         cT=round(bb(1));
                
         [x,y] = size(cropped2);
         normal(rT:rT+x,cT:cT+y)=cropped2;
            
     end
     
 end
%figure,imshow(normal),title('normal');
end