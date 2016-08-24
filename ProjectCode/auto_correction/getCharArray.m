function [charArray,start,str]=getCharArray(word)

ch=strsplit(word,'~');
charArray=char(ch);
charArray=charArray(1:end-1,:);
numChar=numel(ch)-1;
str=[];
for i=1:numChar
    str=strcat(str,charArray(i,:));
end

%% in case the operand starts with a number
numberExpression = '[1-9]+[0-9]*';
[startIndex,endIndex] = regexp(str,numberExpression,'start','end');
try 
    if startIndex(1) == 1
        start=char(charArray(startIndex(1):endIndex(1)));
        charArray=charArray(endIndex(1)+1:end,:);
    else
        start=[];
    end
catch 
        start=[];
end
% here, start = [] if the operand does not start with a number 
% charArray contains the rest of single component OCR output

% edit the str, remove the first digit
if numel(start)>0
    str(1:end-1)=str(numel(start)+1:end);
    str(end)='';
end

end