function [I]=removeByEuler(I)
% removes the single characters with more than 0 holes
% euler num = total num of objects - total num of holes
[I,num]=bwlabel(I);
stat=regionprops(I,'EulerNumber','BoundingBox');
%num=numel(stat);
for i=1:num
      
   img = im2bw(imcrop(I, stat(i).BoundingBox));
  %figure,imshow(img),title(bweuler(img));
    if bweuler(img)~=1
        
        rT=stat(i).BoundingBox(2);
        cT=stat(i).BoundingBox(1);
        I(rT:rT+round(stat(i).BoundingBox(4)),cT:cT+round(stat(i).BoundingBox(3)))=0;
   
    end
end


end