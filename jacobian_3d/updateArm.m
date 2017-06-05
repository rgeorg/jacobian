function [d] = updateArm(s, d)
%updateArm Draw the robot arm after some change

% Recalculate the point positions and orientations
fields={'arm','T00','T01','T02','T03','T04'};
for i=1:numel(fields)
    d.(fields{i})=double(subs(s.(fields{i}),...
        [s.t1 s.t2 s.t3 s.d1 s.L3 s.d4],...
        [d.t1 d.t2 d.t3 d.d1 d.L3 d.d4]));
end

% Plot the arm
plot3(d.arm(1,:),d.arm(2,:),d.arm(3,:),'-ok');

% Plot the frames
plotTriad(d.T00,0);
plotTriad(d.T01,1);
plotTriad(d.T02,2);
plotTriad(d.T03,3);
plotTriad(d.T04,4);

end

