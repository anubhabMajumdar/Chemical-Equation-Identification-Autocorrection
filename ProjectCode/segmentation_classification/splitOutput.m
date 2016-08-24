function [element,entire,totlenb,str]=splitOutput(str) 

%% read the output file and take them into a string
fid = fopen(filename);
k = 1;
while ~feof(fid)
    curr = fscanf(fid,'%c',1);
    %disp('currrr-----------------');
    %disp(curr);
     if ~isempty(curr)
       str(k) = curr;
        k = k+1;
     end
end 
fclose(fid);
%% eliminate the space and new line and get the element

elementExpr = '[A-Z][a-z]*';
entireExpr = '[A-Z]*[a-z]*';
blankExpr = '[ ]*';

element = regexp(str,elementExpr,'match');
entire = regexp(str,entireExpr,'match');
blank = regexp(str,blankExpr,'match');
totlenb=numel(str)-numel(blank);



end