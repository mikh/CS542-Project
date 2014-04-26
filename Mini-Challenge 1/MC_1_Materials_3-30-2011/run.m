%script to analyze the data

fprintf('Getting original map...\n');
map_image_name = 'Vastopolis_Map.png';

[original_map, original_colormap] = imread(map_image_name, 'png');
original_map = normalizeColor(original_map, 252);
dot_map = original_map;
big_dot_map = original_map;
magnitude_map = original_map;
magnitudes = zeros(size(original_map));

date_map_coords = cell(60,1);

figure(1);
imshow(original_map, original_colormap);

[map_x, map_y] = size(original_map);

dot_radius = 8;

%first date = 4/30
x_s = 42.3017;
x_e = 42.1609;
y_s = 93.5673;
y_e = 93.1923;

delta_x = abs(x_s - x_e)/map_x;
delta_y = abs(y_s - y_e)/map_y;

fprintf('Loading text file...\n');
database_file_name = 'Microblogs.csv';
fid = fopen(database_file_name);
fprintf('Opening %s...\n', database_file_name);
end_string = '~~~!!!###FILEEND###!!!~~~';

line = fgets(fid);  %skip first line
line = fgets(fid);
line_number = 1;


epidemic_keywords = cell(0,1); 
epidemic_keywords = [epidemic_keywords; 'flu'];
epidemic_keywords = [epidemic_keywords; 'sick'];
epidemic_keywords = [epidemic_keywords; 'epidemic'];
epidemic_keywords = [epidemic_keywords; 'fever'];
epidemic_keywords = [epidemic_keywords; 'medicine'];
epidemic_keywords = [epidemic_keywords; 'cold'];
epidemic_keywords = [epidemic_keywords; 'doctor'];
epidemic_keywords = [epidemic_keywords; 'chill'];
epidemic_keywords = [epidemic_keywords; ' ill '];
epidemic_keywords = [epidemic_keywords; 'pneumonia'];
num_messages = 0;

early_day = 999;
early_minute = 9999;
early_messasge = '';
early_line_number = 0;


while (strcmp(line, end_string) ~= 1) && (line_number < 1023078)
    fprintf('Evaluating line %d\n', line_number);
    broken_line = breakLine(line, ',', 4);
    str = broken_line{1};
        
    locations = breakLine(broken_line{3}, ' ', 2);
    cur_x = str2double(locations{1});
    cur_y = str2double(locations{2});
    xx = round(abs(x_s - cur_x)/delta_x + 1);
    yy = round(abs(y_s - cur_y)/delta_y + 1);
    
    l = length(epidemic_keywords);
    found = 0;
    for ii = 1:l
        A = strfind(broken_line{4},epidemic_keywords{ii});
        if isempty(A) ~= 1
            found = 1;
            break;
        end
    end
    
    if found == 1 && xx > 0 && xx <= map_x && yy > 0 && yy <= map_y
        num_messages = num_messages + 1;
        dot_map(xx,yy) = 255;
        big_dot_map = drawCircleOnMap(big_dot_map, xx, yy, dot_radius, 253);
        mag = magnitudes(xx,yy);
        magnitude_map = drawCircleOnMap(magnitude_map, xx, yy, dot_radius + mag, 253);
        mag = mag + 1;
        magnitudes(xx,yy) = mag;

        [date_mes, time_mes] = parseDate(broken_line{2});
        if date_mes < early_day
            early_day = date_mes;
            early_minute = time_mes;
            early_messasge = broken_line{4};
            early_line_number = line_number;
        elseif date_mes == early_day
            if time_mes < early_minute
                early_day = date_mes;
                early_minute = time_mes;
                early_messasge = broken_line{4};
                early_line_number = line_number;
            end
        end
        
        date_mes = date_mes + 1;        
        date_map_coords{date_mes} = [date_map_coords{date_mes}, xx, yy];

    end
    
    line = fgets(fid);
    line_number = line_number + 1;
end

fclose(fid);

figure(2);
imshow(dot_map, original_colormap);
    
imwrite(dot_map, original_colormap, 'dot_map.png');
imwrite(big_dot_map, original_colormap, 'big_dot_map.png');
imwrite(magnitude_map, original_colormap, 'magnitude_map.png');

for ii = 1:60
    A = date_map_coords{ii};
    if length(A) ~= 0
        date_map = original_map;
        for jj = 1:2:length(A)
            date_map = drawCircleOnMap(date_map, A(jj), A(jj+1), dot_radius, 253);
        end
        imwrite(date_map, original_colormap, sprintf('date_map_day_%d.png', ii-1));
    end
end
