function [days_since_start, minutes_since_day_start] = parseDate(date_str)
	%5/7/2011 12:28
	%5/1/2011 2:27
    minutes_since_day_start = 0;
	word = '';
	index = 1;
	while date_str(index) ~= '/'
		word = [word date_str(index)];
		index = index + 1;
	end
	index = index + 1;
	month = word;
	word = '';
	while date_str(index) ~= '/'
		word = [word date_str(index)];
		index = index + 1;
	end
	day = word;
	if (str2double(month) == 4) && (str2double(day) ~= 30)
		fprintf('MONTH = 4 DAY ~= 30');
		error('MONTH = 4 DAY ~= 30');
	end

	if str2double(month) == 4
		days_since_start = 0;
	else
		days_since_start = str2double(day);


	while date_str(index) ~= ' '
		index = index + 1;
	end
	index = index + 1;

	word = '';
	while date_str(index) ~= ':'
		word = [word date_str(index)];
		index = index + 1;
	end
	hour = word;
	word = '';
	index = index + 1;

	while (index <= length(date_str)) && (date_str(index) ~= ' ')
		word = [word date_str(index)];
		index = index + 1;
	end
	minute = word;
	minutes_since_day_start = str2double(hour) * 60 + str2double(minute);
end