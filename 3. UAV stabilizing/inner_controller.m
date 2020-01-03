function [T] = inner_controller(ephi_dot)
global Ts
global kp_in ki_in kd_in
persistent past_ephi_dot
persistent ephi_doti

if isempty(past_ephi_dot)
    past_ephi_dot = 0;
end
if isempty(ephi_doti)
    ephi_doti = 0;
end
ephi_doti = ephi_doti + Ts * ephi_dot;
ephi_dotd = (ephi_dot - past_ephi_dot)/Ts;
past_ephi_dot = ephi_dot;

%% Output
T = (kp_in * ephi_dot) + (ki_in * ephi_doti) + (kd_in * ephi_dotd);

end