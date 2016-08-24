function [left,right]=getLeftRightElement(final)

len = size(final,2);
for i=1:len
    if strcmp(final{i},'right_arrow')==1 % || final{i}=='left_arrow' || final{i}=='='
        partition = i;
        break;
    end
end
count=1;
for i=1:2:partition
    left{count}=final{i};
    count=count+1;
end
count=1;
for i=partition+1:2:len
    right{count}=final{i};
    count=count+1;
end

left=strcat(left{:});
right=strcat(right{:});
end