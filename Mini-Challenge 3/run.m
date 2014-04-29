file_directory = 'MC_3_Materials_4_4_2011';

all_files = dir(file_directory);

keywords = cell (0,1);
% %keywords = [keywords; 'threat'];
% keywords = [keywords; ' terrorist '];
% keywords = [keywords; ' terrorism '];
% %keywords = [keywords; 'terror'];
% %keywords = [keywords; 'attack'];
% %keywords = [keywords; 'bomb'];
% keywords = [keywords; ' hijack '];
% keywords = [keywords; ' hijacker '];
% keywords = [keywords; ' hijacking '];
% keywords = [keywords; ' hijacked '];
% 
rm_keywords = cell(0,1);
% rm_keywords = [rm_keywords; 'Iraq'];

% keywords = [keywords; 'Downtown --'];
% keywords = [keywords; 'Cornertown --'];
% keywords = [keywords; 'Eastside --'];
% keywords = [keywords; 'Lakeside --'];
% keywords = [keywords; 'Northville --'];
% keywords = [keywords; 'Plainville --'];
% keywords = [keywords; 'Riverside --'];
% keywords = [keywords; 'Smogtown --'];
% keywords = [keywords; 'Southville --'];
% keywords = [keywords; 'Suburbia --'];
% keywords = [keywords; 'Uptown --'];
% keywords = [keywords; 'Villa --'];
% keywords = [keywords; 'Westside --'];
%keywords = [keywords; 'Vastopolis Dome'];
%keywords = [keywords; 'Dome'];
%keywords = [keywords; 'dome'];
%keywords = [keywords; 'weird'];
%keywords = [keywords; 'strange'];
keywords = [keywords; 'Agriculture'];
keywords = [keywords; 'agriculture'];

remove_articles = cell(0,1);
remove_articles = [remove_articles; '00830.txt'; '00906.txt';'03550.txt';'03720.txt';'03792.txt'];

start_day = 1;
start_month = 'May';
start_year = 2011;

end_day = 14;
end_month = 'May';
end_year = 2011;

date_filter = 0;

add_keywords = cell(0,1);
add_keywords = [add_keywords; 'Vastopolis'];
%add_keywords = [add_keywords; ' terrorism '];


dates = cell(0,1);
matches = 0;
matched_files = cell(0,1);

for ii = 3:length(all_files)
    fprintf('Processing file #%d, %s\n',ii, all_files(ii).name);
    filename = [file_directory '\' all_files(ii).name];
    
    cur_file = fopen(filename);
    headline = fgets(cur_file);
    date_posted = fgets(cur_file);
    content = fgets(cur_file);
    
    [month, day, year] = extractDate(date_posted);
    date_bound = 1;
    if date_filter == 1
        if strcmp(month, start_month) ~= 1
            date_bound = 0;
        end

        if year ~= start_year
            date_bound = 0;
        end

        if ((day < start_day) || (day > end_day))
            date_bound = 0;
        end
    end
    
    
    match_headline = stringContains(headline, keywords);
    match_content = stringContains(content, keywords);
    match_headline_rm = stringContains(headline, rm_keywords);
    match_content_rm = stringContains(content, rm_keywords);
    match_headline_add = stringContains(headline, add_keywords);
    match_content_add = stringContains(content, add_keywords);
    
    if (date_bound == 1) && (match_headline == 1 || match_content == 1) && ~(match_headline_rm == 1 || match_content_rm == 1) && (match_headline_add == 1 || match_content_add == 1)
       dates = [dates; date_posted];
       matches = matches + 1;
       matched_files = [matched_files; all_files(ii).name];
    end
    
    fclose(cur_file);
end

fprintf('All files processed. %d Matches found.\n', matches);
matched_files



