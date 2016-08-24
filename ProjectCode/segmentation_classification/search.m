function[type]=search(pt_htable,im)

thresh=0.6;

imwrite(im,'image.jpg');
cmd=' "C:\Program Files\Tesseract-OCR\tesseract" image.jpg output -psm 7';
system(cmd);
pause;
disp('Press any key');
try
%output=ocr(im);    
[element,entire,totlenb,str]=splitOutput('output.txt');
%[element,entire,totlenb,str]=splitOutput(output);
str
entire
element
len=numel(element);
totlen=numel(entire);
found=0;
notFound=0;
for i=1:len
    flag=ptLookUp(pt_htable, element{i});
    if flag==1
        found=found+1;
    else notFound=notFound+1;
    end
end
if totlen > 0 && found>=thresh*totlen 
    disp(i);
    disp('It is a chemical reaction');
    figure,imshow(im),title(['CHEMICAL EQUATION',' ',num2str(found)]);
    type=1;
else
     figure,imshow(im),title(['NON CHEMICAL EQUATION tesseract',' ',num2str(found)]);
    disp('It is a mathematical equation');
    type=0;
end

catch
    type=2;
    disp('empty string');
end
end  