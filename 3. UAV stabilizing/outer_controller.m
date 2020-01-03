function [phi_dotd] = outer_controller(phi, sp)
global Ts
global kp_out ki_out kd_out
global phid
persistent ephii
persistent past_ephi

phid = sp;
ephi = phid - phi;

%% Initializing
if isempty(ephii)
    ephii = 0;
end
if isempty(past_ephi)
    past_ephi = 0;
end

%% Numerical error
ephii = ephii + Ts * ephi;
ephid = (ephi - past_ephi)/Ts;
past_ephi = ephi;

%% Output
phi_dotd = (kp_out * ephi) + (ki_out * ephii) + (kd_out * ephid);

end