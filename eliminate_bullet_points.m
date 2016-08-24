function [img] = eliminate_bullet_points(img)

[L,num]=bwlabel(img);
stat=regionprops(L,'BoundingBox');
for w=1:num
    image2=im2bw(imcrop(L,stat(w).BoundingBox));
    [r,c] = size(image2);
    %[d_left, d_right] = count_diagonal_blacks(imresize(image2,[50,50]));
    image2 = imresize(image2,[50,50]);
    %figure,imshow(image2);
    
    se = strel('disk',20);
    
    erosion = imerode(image2, se);
    
    %if ((r/c >=0.8) && (r/c <=2) && (nnz(erosion)~=0))
     if (nnz(erosion)~=0)
        %figure,imshow(erosion),title(num2str(nnz(erosion)));
        rT=round(stat(w).BoundingBox(2));
        cT=round(stat(w).BoundingBox(1));
        img(rT:rT+round(stat(w).BoundingBox(4)),cT:cT+round(stat(w).BoundingBox(3)))=0;
    end
end
end
