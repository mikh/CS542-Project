function [ month, day, year ] = extractDate( str )
    word = '';
    index = 1;
    while str(index) == ' '
        index = index + 1;
    end
    
    while str(index) ~= ' '
        word = [word str(index)];
        index = index + 1;
    end
    
    month = word;
    
    word = '';
    index = index + 1;
    while str(index) ~= ','
        word = [word str(index)];
        index = index + 1;
    end
    
    day = str2num(word);
    
    index = index + 2;
    word = '';
    while (index <= length(str)) && (str(index) ~= ' ')
        word = [word str(index)];
        index = index + 1;
    end
    year = str2num(word);
end

