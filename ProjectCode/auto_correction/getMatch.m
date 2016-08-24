function [match]=getMatch(allComb,molecule)


 match=[];
for i=1:size(allComb,1)
    candidate=allComb(i,:); 
    try
    %match=validatestring(candidate,molecule)
     x=strmatch(candidate,molecule,'exact');
     match=molecule{x}
     disp('Match found');
    catch
       
       % disp('No match');
    end
end

end