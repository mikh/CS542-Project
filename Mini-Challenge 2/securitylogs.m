fid = fopen('C:\Users\Prince\Documents\MATLAB\Machine Learning\20110413\security\20110413_VAST11MC2_SecurityLog.xml');
fid2 = fopen('C:\Users\Prince\Documents\MATLAB\Machine Learning\20110414\security\20110414_VAST11MC2_SecurityLog.xml');
fid3 = fopen('C:\Users\Prince\Documents\MATLAB\Machine Learning\20110415\security\20110415_VAST11MC2_SecurityLog.xml');
while ~feof(fid) 
    line = fgets(fid);
    A = strfind(line,'<Data Name=''IpPort''>2034</Data>');    % Indicates unsuccessful login attempt.
    if isempty(A) ~= 1
        lengthA = length(A);
        for i=1:lengthA
            newstring = line(A(i)-20:A(i)-7);   % Gets the IP address that performed the unsuccessful login.
            disp(newstring);
        end
    end
end

% XML data is extremely hard to use in matlab, so I manually read the XML
% and the earliest inclusion of this event for the security logs is from
% 2011-04-14T13:37:29.437500000Z.

% Also, each file reads similiarly.