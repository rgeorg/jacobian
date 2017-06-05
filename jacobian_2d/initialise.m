function [s, d] = initialise()

% s contains the symbolic expressions
s = struct();

% d contains the decimal expressions
d = struct();

% Construct transforms from the modified D&H parameters
s.L1 = sym('L1');
s.L2 = sym('L2');
s.t1 = sym('t1');
s.t2 = sym('t2');

s.T00=sym(eye(4));
s.T01=frameTrans(0,0,0,s.t1);
s.T12=frameTrans(0,s.L1,0,s.t2);
s.T23=frameTrans(0,s.L2,0,0);

% Get transforms relative to the {0} frame
s.T02=s.T01*s.T12;
s.T03=s.T02*s.T23;

% Get the xyz coords of the frames relative to the {0} frame
s.arm=[s.T00(1:3,4) s.T01(1:3,4) s.T02(1:3,4) s.T03(1:3,4)];

% Invert transforms to use with velocities
s.T10=inv(s.T01);
s.T21=inv(s.T12);
s.T32=inv(s.T23);

% Time derivatives
s.ddt_t1 = sym('ddt_t1');
s.ddt_t2 = sym('ddt_t2');

% Velocities of each frame with respect to itself
s.w00=sym([0 0 0]');
s.u00=sym([0 0 0]');

s.w11=s.T10(1:3,1:3)*s.w00+s.ddt_t1*[0 0 1]';
s.u11=s.T10(1:3,1:3)*(s.u00+cross(s.w00,s.T01(1:3,4)));

s.w22=s.T21(1:3,1:3)*s.w11+s.ddt_t2*[0 0 1]';
s.u22=s.T21(1:3,1:3)*(s.u11+cross(s.w11,s.T12(1:3,4)));

s.w33=s.T32(1:3,1:3)*s.w22+0*[0 0 1]';
s.u33=s.T32(1:3,1:3)*(s.u22+cross(s.w22,s.T23(1:3,4)));

% Velocities of the end effector with respect to the {0} frame
s.w03=s.T03(1:3,1:3)*s.w33;
s.u03=s.T03(1:3,1:3)*s.u33;

% Jacobian of the end effector with respect to itself
s.J33=[diff(s.u33,s.ddt_t1), diff(s.u33,s.ddt_t2)];

% Determinant of the Jacobian
s.detJ33=det(s.J33(1:2,:));

% Determinant factors
s.detJ33factors=factor(s.detJ33).';

% Simplify
fields=fieldnames(s);
for i=1:numel(fields)
    s.(fields{i})=simplify(s.(fields{i}));
end

end






