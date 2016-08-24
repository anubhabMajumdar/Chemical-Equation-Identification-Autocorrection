function [normal]=getSingleChar(normal,closed)
%returns an image containing only single characters
% figure,imshow(normal),title('normal');
% figure,imshow(closed),title('closed');
CC=bwconncomp(closed);
statClose=regionprops(CC,'Area','PixelIdxlist','BoundingBox');
m=CC.NumObjects; % number of blobs

 for i=1:m
     bb=statClose(i).BoundingBox;
     cropped=imcrop(normal,bb);
    [random,count]=bwlabel(cropped);
    %figure,imshow(cropped),title(['count ',num2str(count)]);
    
     if count==1 %|| bb(4)< mche
        % figure,imshow(cropped),title(['count ',num2str(count)]);
     else 
         rT=round(bb(2));
         cT=round(bb(1));
         normal(rT:rT+bb(4),cT:cT+bb(3))=0;
     end
     
 end
%figure,imshow(normal),title('normal');
end