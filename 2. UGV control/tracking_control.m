function [vd,wd,thtd,horizontal] = tracking_control(xd,yd,meas,isLast,horizontal)
global kp3 kp4

ex = xd - meas(1);  % (x error definition)
ey = yd - meas(2);  % (y error definition)
vxd = kp3 * ex;     % (desired linear velocity)
vyd = kp3 * ey;     % (desired linear velocity)   

waiting_time = 60;
    
%% Parallel parking
% isLast가 true라면, 최종지점에 도달한 것으로 인식하여 각도를 'angle'로 맞춤
% 처음에는 가로방향을 맞추고, 일정시간 뒤에 세로방향을 맞춤
if isLast
    if horizontal < waiting_time
        % disp('x-parallel')
        thtd = 0;
        horizontal = horizontal + 1;
    else
        thtd = pi/2;
        % disp('y-parallel')
    end 
else
    thtd = atan2(vyd,vxd); 
end
    
%% vd & wd
if cos(thtd) > 0.05
    vd = vxd/cos(thtd);
else 
    vd = vyd/sin(thtd);
end
    
etht = thtd - meas(3);  % (theta error definition)
wd = kp4 * etht;
    
%% Destination
if abs(ex)<0.1 && abs(ey)<0.1
    vd=0;
    wd=0;
    thtd=meas(3);
end

end