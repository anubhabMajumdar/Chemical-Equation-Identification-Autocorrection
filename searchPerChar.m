function[]=searchPerChar(im,str)

bin=im2bw(im);
[labeled,numOfChar]=bwlabel(bin);
stat=regionprops(labeled,'BoundingBox');
for i=1:numOfChar  
    upper(i)=stat(i).BoundingBox(2);
    lower(i)=upper(i)+stat(i).BoundingBox(4);    
end
U=median(upper);
L=median(lower);
middle=(U+L)/2;

for i=1:numOfChar
 
pause;
disp('Press any key');

bb=stat(i).BoundingBox;
img=imcrop(bin,bb);
[r,c]=size(img);
paddedImg=zeros(r+20,c+20);
paddedImg(10:r+9,10:c+9)=img(:,:);
paddedImg=im2bw(paddedImg);
imwrite(~paddedImg,'image.bmp');
if upper(i)>middle && lower(i)>L
    cmd=' "tesseract" image.bmp output -psm 10 nobatch numbers';
    disp('subscript');
else 
cmd=' "tesseract" image.bmp output -psm 10 nobatch letters';
end
system(cmd);
    try
    [element,entire,totlenb,str]=splitOutput('output.txt');
        str  
        figure,imshow('image.bmp'),title(str);
    catch
        disp('empty string');
    end
end 


end