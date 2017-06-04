function [d] = generateSolutions(s, d)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
fields={'detJ33'};
for i=1:numel(fields)
    d.(fields{i})=double(subs(s.(fields{i}),...
        [s.L1 s.L2 s.t1 s.t2],...
        [d.L1 d.L2 d.t1 d.t2]));
end

end

