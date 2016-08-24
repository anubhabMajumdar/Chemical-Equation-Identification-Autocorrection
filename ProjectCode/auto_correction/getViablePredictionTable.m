function [finalChoice]=getViablePredictionTable(prediction)
%% from the prediction table, we take up the rows with the 
%  longest match with elements in the molecule list
 count=1;
 arr=cell2mat(prediction(:,4));
 coeff=find(arr==max(arr));
 for i=1:numel(coeff)
    viablePrediction(count,:)=prediction(coeff(i),:);
    count=count+1;
 end
 
%% now we have to dial it down to the ones with the same length
lenElement=numel(char(viablePrediction(1,1)));
count=1;
for i=1:numel(coeff)
    len=numel(char(viablePrediction(i,2)));
    if len==lenElement
        sameLengthPrediction(count,:)=viablePrediction(i,:);
        count=count+1;
    end
end

finalChoice=unique(sameLengthPrediction(:,2));
end