function [closedI,s]=wordGapClose(I,cw_gap)
% returns a image containing word blobs

[peak,loc]=findpeaks(cw_gap);

gap=cw_gap(loc(2):loc(3));
s2=loc(2)+find(gap==min(gap)) + 15;
%len=numel(s2);
s=s2(1);
se = strel('line',s2(1),0);
closedI = imclose(I,se);

end