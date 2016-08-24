function [str]=collapse(s)
len=numel(s);
count=1;
space=isspace(s);
for i=1:len
    if space(i)==1
      %  disp('space');
    else str(count)=s(i);
        count=count+1;
    end 
end

end