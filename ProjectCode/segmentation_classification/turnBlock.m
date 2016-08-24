function [img,num]=turnBlock(img)
% turns every character into a block taking its bounding box
% returns the number of such blocks

 [L,num]=bwlabel(img);
    %figure,imshow(line),title(num);
   
    stat=regionprops(L,'BoundingBox');
    for j=1:num
        bb=stat(j).BoundingBox;
        r1=round(bb(2));
        c1=round(bb(1));
        r2=r1+round(bb(4));
        c2=c1+round(bb(3));
        img(r1:r2,c1:c2)=1;
        
    end

end