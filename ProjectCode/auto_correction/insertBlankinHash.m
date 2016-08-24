function [H]=insertBlankinHash(H,o)

num=numel(o);

    for i=1:num
        if numel(o{i})>0
            bool   = H.ContainsKey(o{i});
            o{i};
                if bool == 0
                H.Add(o{i},'');
                else
                    %disp('In the hashtable already');
                end
        end
    end
end


