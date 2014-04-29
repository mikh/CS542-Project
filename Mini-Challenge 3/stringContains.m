function [ match ] = stringContains( str, keywords )
    match = 0;
    for ii = 1:length(keywords)
       A = strfind(str, keywords{ii});
       if isempty(A) ~= 1
           match = 1;
           break;
       end
    end
end

