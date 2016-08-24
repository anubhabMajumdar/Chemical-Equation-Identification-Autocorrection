function[type]=search(pt_htable,im)

thresh=0.6;

% imwrite(im,'image.jpg');
% cmd=' "C:\Program Files\Tesseract-OCR\tesseract" image.jpg output -psm 7';
% system(cmd);
str = ocr(im);
str.Text
pause;
disp('Press any key');
try
%[element,entire,totlenb,str]=splitOutput('output.txt');
[element,entire,totlenb,str]=splitOutput2(str.Text);
% str
% entire
% element
len=numel(element);
totlen=numel(entire);
found=0;
notFound=0;
for i=1:len
    flag=ptLookUp(pt_htable, char(element{i}));
    if flag==1
        found=found+1;
    else notFound=notFound+1;
    end
end
if totlen > 0 && found>=thresh*totlen 
    disp(i);
    disp('It is a chemical reaction');
    figure,imshow(im),title(['CHEMICAL EQUATION',' ',num2str(found)]);
    pause;
    disp('Press any key');
    type=1;
else
    figure,imshow(im),title(['NON CHEMICAL EQUATION tesseract',' ',num2str(found)]);
    disp('It is a mathematical equation');
    pause;
    disp('Press any key');
    type=0;
end

catch
    figure,imshow(im),title(['EMPTY STRING RETURNED',' ',num2str(found)]);
    disp('It is an null string');
    pause;
    disp('Press any key');
    type=2;
    %disp('empty string');
end
end  