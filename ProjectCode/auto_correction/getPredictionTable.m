function [prediction] = getPredictionTable(allComb,molecule)
%% here we try to find the nearest match and 
%  try to predict the elementsin case of NO MATCH
% prediction table contains all the LCS with atleast 1 match
prediction=[];
    count=1;
    
        for i=1:size(allComb,1)
            candidate=allComb(i,:);
            for j=1:size(molecule,2)
                mol=molecule{j};
                 [D, dist, aLongestString] = LCS(candidate,mol);
%                   D=strmatch(candidate,mol);
%                   if numel(D)~=0
                   
                 if D~=0
                         prediction{count,1}=candidate;
                         prediction{count,2}=mol;
                     prediction{count,3}=aLongestString;
                     prediction{count,4}=dist;
                         count=count+1;
                  end

            end
        end
    

end