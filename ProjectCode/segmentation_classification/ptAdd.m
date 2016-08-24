function ptAdd(pt_htable, inp_line)

try
res = strsplit(inp_line);
split = char(res);

%name = input(':: ','s');
name = split(1,:);
name = deblank(name);

%size(name)

entry=[name '^'];
 len = size(split);
 line = '';
 for i = 2:len(1)
    line = strcat(line,' ', split(i,:));
    if isempty(line)
      break;
      
   end;
end;
entry=[entry line '^'];
if strcmp(entry, '^')
   disp 'No name entered'
   return;
end;
pt_htable.put(pt_keyfilter(name),entry);
%disp ' '
sprintf('%s has been added to the phone book.', name);
catch
    a = 0;
end
end