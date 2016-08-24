function [element,entire,totlenb,str]=splitOutput2(str) 

%% eliminate the space and new line and get the element

elementExpr = '[A-Z][a-z]*';
entireExpr = '[A-Z]*[a-z]*';
blankExpr = '[ ]*';

element = regexp(str,elementExpr,'match');
entire = regexp(str,entireExpr,'match');
blank = regexp(str,blankExpr,'match');
totlenb=numel(str)-numel(blank);



end