function symbolicSolutions(s)
%symbolicSolutions Output the symbolic solutions to a text file

% The variables we want to output
fields = {'T01','T02','T03','T04','T10','T21','T32','T43', ...
    'w11','u11','w22','u22','w33','u33','w44','u44','w04','u04', ...
    'J44','detJ44','detJ44factors'};

% Write to file
fid = fopen('symbolic_solutions.txt','w');
for i = 1:numel(fields)
    % Name of variable
    fprintf(fid, '# %s\r\n', fields{i});
    % Value of variable
    var = s.(fields{i});
    % Rows and columns for matrices
    [rows, cols] = size(var);
    for r = 1:rows
        for c = 1:cols
            % Print the value
            fprintf(fid, '%40s', var(r, c));
        end
        % New line at end of row
        fprintf(fid, '\r\n');
    end
    % New line before next variable
    fprintf(fid, '\r\n');
end
fclose(fid);
% Open in Notepad
!notepad symbolic_solutions.txt

end

