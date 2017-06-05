function [d] = decimalSolutions(s, d)
%decimalSolutions Output the decimal solutions to a text file

% The variables we want to output
fields = {'t1','t2','t3','d1','L3','d4','ddt_t1','ddt_t2','ddt_t3','ddt_d4', ...
    'T01','T02','T03','T04','T10','T21','T32','T43', ...
    'w11','u11','w22','u22','w33','u33','w44','u44','w04','u04', ...
    'J44','detJ44'};

% Substitute parameters
for i=1:numel(fields)
    d.(fields{i})=double(subs(s.(fields{i}),...
        [s.t1 s.t2 s.t3 s.d1 s.L3 s.d4 s.ddt_t1 s.ddt_t2 s.ddt_t3 s.ddt_d4],...
        [d.t1 d.t2 d.t3 d.d1 d.L3 d.d4 d.ddt_t1 d.ddt_t2 d.ddt_t3 d.ddt_d4]));
end

% Write to file
fid = fopen('decimal_solutions.txt','w');
for i = 1:numel(fields)
    % Name of variable
    fprintf(fid, '# %s\r\n', fields{i});
    % Value of variable
    var = d.(fields{i});
    % Rows and columns for matrices
    [rows, cols] = size(var);
    for r = 1:rows
        for c = 1:cols
            % Print the value
            fprintf(fid, '%8.3g', var(r, c));
        end
        % New line at end of row
        fprintf(fid, '\r\n');
    end
    % New line before next variable
    fprintf(fid, '\r\n');
end
fclose(fid);
% Open in Notepad
!notepad decimal_solutions.txt

end

