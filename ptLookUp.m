function [found]= ptLookUp(pt_htable,name)
entry = pt_htable.get(pt_keyfilter(name));
if isempty(entry)
   found=0;
   sprintf('The element %s is not in the Periodic Table',name);
else
   pt_display(entry);
   found=1;
end