function [ output_list ] = breakLine( line, string_token, pieces )
    l = length(line);
    word = '';
    cur_piece = 1;
    output_list = cell(0,0);
    for ii = 1:l
       char = line(ii);
       if strcmp(char, string_token) == 1
          if isempty(word) ~= 1
              output_list = [output_list, word];
              word = '';
          end
          cur_piece = cur_piece + 1;
       else
           word = [word, char];
       end
       if cur_piece == pieces
          output_list = [output_list, line(ii+1:l)]; 
          break;
       end
    end
end

