function Xdot = dynamics(t,X)
global M I T r
% X = [phi phi_dot]

Xdot = zeros(2,1);
Xdot(1) = X(2);
Xdot(2) = (1/I)*(T+M*9.8*r*X(1));

end