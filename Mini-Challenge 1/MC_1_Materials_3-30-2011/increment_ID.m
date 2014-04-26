function [ out ] = increment_ID( ID_list, ID )
    [r, c] = size(ID_list);
    found = 0;
    for ii = 1:r
        if ID_list(ii,1) == ID
            found = 1;
            ID_list(ii,2) = ID_list(ii,2) + 1;
        end
    end
    
    if found == 0
        ID_list = [ID_list; [ID, 1]];
    end
    
    out = ID_list;

end

