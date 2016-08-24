function [match]=autoCorrect(word)
clear charArray
[H]=readFromErrorFile;
molecule=unique(readFromMoleculeFile());

%% get the word all split and charArray contains each character output from OCR
% word = '1~2~H~_2~O~';

[charArray,start,str]=getCharArray(word);


%% extract the state of the operands, like (s) or (l) or (g)
[state]=getSLG(charArray,H);
if numel(state)~=0
    charArray(end-numel(state)+1:end,:)=[];
end

%%
%ch == each character from OCR output
% ch = '''E'
[allComb]=getAllCombination(charArray,H);

%% here we try to find the exact match from the molecule_list

[match]=getMatch(allComb,molecule);

%% here we try to find the nearest match and 
%  try to predict the elementsin case of NO MATCH
% prediction table contains all the LCS with atleast 1 match
if numel(match)==0
        disp('NO MATCH');
        try
        [prediction] = getPredictionTable(allComb,molecule);
        [choice]= getViablePredictionTable(prediction)
        if numel(choice)==1
            match = char(choice);
        end
        catch
            match=str;
        end
  

end
match=strcat(start,match,state) 

end