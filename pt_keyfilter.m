function out = pt_keyfilter(key)
if ~isempty(strfind(key,' '))
   out = strrep(key,' ','_');
else
   out = strrep(key,'_',' ');
end;