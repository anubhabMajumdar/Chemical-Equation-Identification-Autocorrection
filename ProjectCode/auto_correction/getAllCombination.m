function [allComb]=getAllCombination(charArray,H)

numChar = size(charArray,1);
combinationSet{numChar} = [];
%st{numChar}=[];
for i=1:numChar
    if charArray(i,1)=='_' || charArray(i,1)=='^'
        charArray(i,1:end-1)=charArray(i,2:end);
        charArray(i,end)=' ';
        %charArray(i,:)=strtrim(charArray(i,:));
    end
    character=strtrim(charArray(i,:));
    try
        probableOut=strsplit(char(strtrim(H.Get(character))),' ');
         if size(character,2)==1
             probChar= strcat(((char(probableOut))'),character);
         else 
             % the outputs which have length~= 1 should not be in
             % the possible combination list, as all the input should be
             % single character.
             probChar= strcat(((char(probableOut))'));
         end
            combinationSet{i}=probChar;
         
    catch
        %disp('No match found in the probable error list!');
        combinationSet{i}=character;
    end
end

allComb = cartprod(combinationSet);
% allComb contains all the combinations of the possible output
end