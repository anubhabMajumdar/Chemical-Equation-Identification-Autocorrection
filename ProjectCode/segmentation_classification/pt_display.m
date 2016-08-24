function pt_display(entry)
%  disp ' '
%  disp '-------------------------'
[t,r] = strtok(entry,'^');
while ~isempty(t)
   %sprintf('%s',t);
   disp(t);
   [t,r] = strtok(r,'^');
end;
 disp '-------------------------'
end