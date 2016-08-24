function [L] = detectOperator_ruleBased(I)
% returns an image with +, - , -> and division operator
[L,num]=bwlabel(I);
stat=regionprops(L,'BoundingBox');
for w=1:num
    image2=im2bw(imcrop(L,stat(w).BoundingBox));
    
    type = identify_operator(image2);
    
%     imshow(image2), title(type);
%     pause(1);
     
    if strcmp(type, 'other')
        rT=round(stat(w).BoundingBox(2));
        cT=round(stat(w).BoundingBox(1));
        L(rT:rT+round(stat(w).BoundingBox(4)),cT:cT+round(stat(w).BoundingBox(3)))=0;
    end
end
end
    
    
