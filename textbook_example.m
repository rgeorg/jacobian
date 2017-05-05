clearvars;
clc;
close all;

% s contains the symbolic expressions
s=struct();

% Construct transforms from the modified D&H parameters
syms L1 L2 t1 t2
s.T00=sym(eye(4));
s.T01=frameTrans(0,0,0,t1);
s.T12=frameTrans(0,L1,0,t2);
s.T23=frameTrans(0,L2,0,0);

% Get transforms relative to the {0} frame
s.T02=s.T01*s.T12;
s.T03=s.T02*s.T23;

% Get the xyz coords of the frames relative to the {0} frame
s.arm=[s.T00(1:3,4) s.T01(1:3,4) s.T02(1:3,4) s.T03(1:3,4)];

% d contains the decimal expressions
d=struct();

% Loop through symbolic expressions, substitute values, and save as decimal
% expressions
fields=fieldnames(s);
for i=1:numel(fields)
    d.(fields{i})=double(subs(s.(fields{i}),[L1 L2 t1 t2],...
        [0.5 0.4 pi/4 pi/2]));
end

% Plot the frame positions
figure;
hold on;
axis equal;
grid on;
plot3(d.arm(1,:),d.arm(2,:),d.arm(3,:),'-ok');
plotTriad(d.T00,0);
plotTriad(d.T01,1);
plotTriad(d.T02,2);
plotTriad(d.T03,3);

% Invert transforms to use with velocities
s.T10=inv(s.T01);
s.T21=inv(s.T12);
s.T32=inv(s.T23);

% Time derivatives
syms ddt_t1 ddt_t2

% Velocities of each frame with respect to itself
s.w00=[0 0 0]';
s.u00=[0 0 0]';

s.w11=s.T10(1:3,1:3)*s.w00+ddt_t1*[0 0 1]';
s.u11=s.T10(1:3,1:3)*(s.u00+cross(s.w00,s.T01(1:3,4)));

s.w22=s.T21(1:3,1:3)*s.w11+ddt_t2*[0 0 1]';
s.u22=s.T21(1:3,1:3)*(s.u11+cross(s.w11,s.T12(1:3,4)));

s.w33=s.T32(1:3,1:3)*s.w22+0*[0 0 1]';
s.u33=s.T32(1:3,1:3)*(s.u22+cross(s.w22,s.T23(1:3,4)));

% Velocities of the end effector with respect to the {0} frame
s.w03=s.T03(1:3,1:3)*s.w33;
s.u03=s.T03(1:3,1:3)*s.u33;

% Jacobian of the end effector with respect to itself
s.J33=[diff(s.u33,ddt_t1), diff(s.u33,ddt_t2)];

% Jacobian of the end effector with respect to the {0} frame
s.J03=s.T03(1:3,1:3)*s.J33;

% Remove redundant rows
s.J03=fullRank(s.J03);

% Determinant of the Jacobian
s.detJ03=det(s.J03);

% Joint rates as function of end effector velocity
syms ddt_x ddt_y
foo = s.J03\[ddt_x; ddt_y];
s.ddt_t1 = foo(1);
s.ddt_t2 = foo(2);








