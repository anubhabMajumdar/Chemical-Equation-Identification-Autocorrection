function [str]=getEachCharacter(perLine)

str='';
perLine=im2bw(perLine);
[labeled,numChar]=bwlabel(perLine);

stat=regionprops(labeled,'BoundingBox');

[L,U,M]=getZones(stat,numChar);

image=perLine; image(L,:)=0; image(U,:)=0; image(M,:)=0;
%figure,imshow(image);
%%
for i=1:numChar  %for each character
    char=imcrop(perLine,stat(i).BoundingBox);
    position=getPosition(L,U,M,stat(i).BoundingBox);
    out=pad(char);
    outText=ocr(out, 'TextLayout','Block');
    txt=outText.Text;
    if numel(txt)==0
        txt='NaN';
    end
    %figure,subplot(1,2,1),imshow(out),
    if position == 1
    %title([outText.Text,'super']);
    str=strcat(str,'^',txt);
    else if position ==0
            %title([outText.Text,'normal']);
            str=strcat(str,txt);
        else %title([outText.Text,'sub']);
             str=strcat(str,'_',txt);
        end
    end
    str=strcat(str,'~');
    %pause(3);
end
%%
end