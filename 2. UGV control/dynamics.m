function Xdot = dynamics(t,X)
global km kd cv cw M J eam ead

Xdot = zeros(5,1);

F = km * eam;                % FR+FL
T = kd * ead;                % l(FR+FL)

Xdot(1) = X(4) * cos(X(3));  % vcos@
Xdot(2) = X(4) * sin(X(3));  % vsin@
Xdot(3) = X(5);              % w
Xdot(4) = (F-cv*X(4))/M;     % (F-cv*v)/M
Xdot(5) = (T-cw*X(5))/J;     % (T-cw*w)/J

end