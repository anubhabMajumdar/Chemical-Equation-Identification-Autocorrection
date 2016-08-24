function [type]=decide(str,pt_htable)
disp(str);
thresh=0.5;

%% type :  1 - Chemical, 0 - non-chemical, 2 - empty string
%%
%try
elementExpr = '[A-Z][a-z]*';
%entireExpr = '[A-Z]*[a-z]*';
%blankExpr = '[ ]*';

element = regexp(str,elementExpr,'match');
%entire = regexp(str,entireExpr,'match');
%blank = regexp(str,blankExpr,'match');
%totlenb=numel(str)-numel(blank);

[row,len]=size(element{1});
%len=numel(element)

[row,totlen]=size(str{1});
found=0;
notFound=0;
for i=1:len
    %element{i}
    flag=ptLookUp(pt_htable, element{1}{i});
    if flag==1
        found=found+1;
        else notFound=notFound+1;
    end
end
if totlen > 0 && found>=thresh*totlen 
    %disp(i);
    %disp('It is a chemical reaction');
    %figure,imshow(im),title(['CHEMICAL EQUATION',' ',num2str(found)]);
    type='chem'
    found
    totlen
else
     %figure,imshow(im),title(['NON CHEMICAL EQUATION tesseract',' ',num2str(found)]);
    %disp('It is a mathematical equation');
    found
    totlen
    type='math';
end

% catch
%     type=2;
%     %disp('empty string');
% end




end