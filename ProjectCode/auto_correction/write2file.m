function [final]=write2file(f,final)

totalNum = numel(final);
for i=1:totalNum
    fprintf(f,'%s\t',final{i});
end
fprintf(f,'\n');

 end