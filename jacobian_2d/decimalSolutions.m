function [d] = decimalSolutions(s, d)
%decimalSolutions Output the decimal solutions to a text file

% The variables we want to output
fields = {'t1','t2','L1','L2','ddt_t1','ddt_t2', ...
    'T01','T02','T03','T10','T21','T32', ...
    'w11','u11','w22','u22','w33','u33','w03','u03' ...
    'J33','detJ33'};

% Substitute parameters
for i=1:numel(fields)
    d.(fields{i})=double(subs(s.(fields{i}),...
        [s.L1 s.L2 s.t1 s.t2 s.ddt_t1 s.ddt_t2],...
        [d.L1 d.L2 d.t1 d.t2 d.ddt_t1 d.ddt_t2]));
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

