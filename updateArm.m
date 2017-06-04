function [d] = updateArm(s, d)
%updateArm Summary of this function goes here
%   Detailed explanation goes here
fields={'arm','T00','T01','T02','T03'};
for i=1:numel(fields)
    d.(fields{i})=double(subs(s.(fields{i}),...
        [s.L1 s.L2 s.t1 s.t2],...
        [d.L1 d.L2 d.t1 d.t2]));
end

plot3(d.arm(1,:),d.arm(2,:),d.arm(3,:),'-ok');
plotTriad(d.T00,0);
plotTriad(d.T01,1);
plotTriad(d.T02,2);
plotTriad(d.T03,3);

end

