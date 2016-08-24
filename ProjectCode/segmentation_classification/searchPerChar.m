function[str]=searchPerChar(im)
%im=var;
%bin=im2bw(im);
bin=im;

%count = 1; % This variable is to save single characters

[labeled,numOfChar]=bwlabel(bin);
stat=regionprops(labeled,'BoundingBox');
for i=1:numOfChar  
    upper(i)=stat(i).BoundingBox(2);
    lower(i)=upper(i)+stat(i).BoundingBox(4);    
end
U=median(upper);
L=median(lower);
middle=(U+L)/2;
str=' ';
for i=1:numOfChar
 
% pause;
% disp('Press any key');

bb=stat(i).BoundingBox;
img=imcrop(bin,bb);
[r,c]=size(img);
paddedImg=zeros(r+20,c+20);
paddedImg(10:r+9,10:c+9)=img(:,:);
paddedImg=im2bw(paddedImg);
%imwrite(~paddedImg,'image.bmp');
if upper(i)>middle && lower(i)>L
    % disp('subscript');
else if lower(i)<middle && upper(i) <U
    %disp('superscript');
    else 
        try
    %[element,entire,totlenb,str]=splitOutput('output.txt');
       % str  
        %figure,imshow('image.bmp'),title(str);
        
        %% Save all single chars in folder singlechars
        
        name = strcat('singlechars\',num2str(count),'.jpg');
        imwrite(img,name);
        imshow(img);
        count = count + 1;
       %% 
        txt=ocr(paddedImg,'TextLayout','Block');
        %figure,imshow(paddedImg),title(txt.Words);
        catch
      %  disp('empty string');
        
        end
    end
end
%system(cmd);
    try
    str=strcat(str,txt.Text);
    %str=strcat(str,';');
    catch
    end
end 


end