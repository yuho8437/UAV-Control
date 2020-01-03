function [xd,yd, barr_type,isLast] = pathplanning(barr, ti_k, barr_type)
%% 장애물의 properties
barr_size = size(barr);
barr_row = barr_size(1);
in_barr = false;

%% 변수 선언
tf = 20;
xmag = 6;
ymag = 5;
mag = max(xmag,ymag);
xd = ti_k * xmag / tf;
yd = ti_k * ymag / tf;
isLast = false;

%% 장애물과 만난 경우
for i = 1:barr_row
    if (barr(i,1) < xd && barr(i,2) > xd && barr(i,3) < yd && barr(i,4) > yd )
        in_barr = true;
        if yd-0.1 < barr(i,3) || barr_type == 1
            barr_type = 1;
            % disp('barr_type: 1 (Under)')
            xd = ti_k * xmag / tf;
            yd = barr(i,3);
        else
            barr_type = 2;
            % disp('barr_type: 2 (Left)')
            xd = ti_k * xmag / tf;
            yd = barr(i,4);
        end
    end
end

%% 장애물과 만나지 않은 경우
if in_barr == false
    barr_type = 3;
    if xd >= xmag && yd >= ymag
        % disp('Parallel parking')
        xd = xmag;
        yd = ymag;
        isLast = true;
    else
        % disp('barr_type: 3 (Free)')
        xd = ti_k * xmag / tf;
        yd = ti_k * ymag / tf;
    end
end

end
    