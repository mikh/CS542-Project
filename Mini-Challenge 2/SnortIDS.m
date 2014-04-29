fid1 = fopen('C:\Users\Prince\Documents\MATLAB\Machine Learning\20110415\IDS\20110415_VAST11MC2_IDS.txt');
fid = fopen('C:\Users\Prince\Documents\MATLAB\Machine Learning\20110414\IDS\20110414_VAST11MC2_IDS.txt');
fid2 = fopen('C:\Users\Prince\Documents\MATLAB\Machine Learning\20110413\IDS\20110413_VAST11MC2_IDS.txt');

line = fgets(fid); %1
rule = cell(0,1);
C = strsplit(line);
if (strcmp(C{1},'[**]'))
    str = strjoin(C(4:end-2));
    rule = [rule; str];
end

IPsource = cell(0,1);
IPsource = [IPsource; 'placeholder'];
IPcount = 1;

attacker = cell(0,1);
date = cell(0,1);

line_number = 1;
while ~feof(fid)
    line = fgets(fid); 
    lrule = length(rule);
    C = strsplit(line);
    if (strcmp(C{1},'[**]'))
        str = strjoin(C(4:end-2));
        found1 = 0;
        for i=1:lrule
            A = strfind(str,rule{i});
            if isempty(A) ~= 1
                found1 = 1;
                break;
            end
        end
        if (found1 == 0)
            rule = [rule; str];
        end
    end
    A = strfind(C{1},'04/');
    lIP = length(IPsource);
    if isempty(A) ~= 1
        found2 = 0;
        for j=1:lIP
            if (strcmp(C{2},IPsource{j}) == 1)
                found2 = 1;
                IPcount(j) = IPcount(j) + 1;
                break;
            end
        end
        if (found2 == 0)
            IPsource = [IPsource; C{2}];
            IPcount = [IPcount, 1];
        end
        % Check for a snort IDS attack.
        if isempty(strfind(C{4},'192.168.1.16')) ~= 1
            attacker = [attacker; C{2}];
            date = [date; C{1}];
        end
    end
end

sortIP1 = num2cell(IPcount)';
sortIP = [IPsource, sortIP1];
sortIP = sortrows(sortIP,2);

fprintf('Earliest Snort IDS connection found on IP of %s\nAt time/date of %s\n', attacker{1}, date{1});

bar(IPcount)