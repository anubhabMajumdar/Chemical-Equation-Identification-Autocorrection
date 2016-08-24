function [finalState]=getSLG(charArray,H)
% here we try to extract (l),(g) or (s) from the operands and also (aq)

try
        close=charArray(end,1);
        open=charArray(end-2,1);
        % the length of charArray is less than 3, e.g, He then it throws error
        open1=charArray(end-3,1);
        Comb=[];
        if close==')' && open=='('

            middle = charArray(end-1,1);
            allComb = getAllCombination(middle,H);
            count=1;
            for j=1:size(allComb,1)
                candidate = allComb(j,:)
                if candidate == 's' || candidate == 'g' || candidate == 'l'
                    Comb(count,1)=candidate;
                    count=count+1;
                else
                end
            end
            finalState = strcat('(',Comb,')');

        else if close==')' && open1=='('
            middle1=charArray(end-2,:);
            middle2=charArray(end-1,:);
            newChar = [middle1;middle2];
            allComb=getAllCombination(newChar,H);
            for i=1:size(allComb,1) 
                if strcmp(allComb(i,:),'aq')==1
                     finalState='(aq)';
                     break;
                else finalState=[];
                end
            end
        else
            finalState=[];
            end
        end


catch
           finalState=[];
end



end