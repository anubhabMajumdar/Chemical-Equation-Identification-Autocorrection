function [closedI]=formWordBlob(I,cw_gap)
% returns a image containing word blobs

[peak,loc]=findpeaks(cw_gap);

gap=cw_gap(loc(1):loc(2));
s2=loc(1)+find(gap==min(gap));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%s2(1) = round((s2(1) / 2) ) + 2;

se = strel('line',s2(1),0);
closedI = imclose(I,se);

% se = strel('disk',5);
% closedI = imclose(closedI,se);

end