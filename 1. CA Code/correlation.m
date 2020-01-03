% [MEN48201 Project1-1 made by 20161253 Yuho Jeong]

% Function which makes correlation graph
% In auto-correlation: y1 has to be 'delayed' one
% In cross-correlation: entirely your choice

function corr = correlation(y1, y2)

% [1. Variables declaration & initialization]
xmax = 1023;            % x-axis max
x = [1:xmax];           % x-axis initialzation
corr = zeros(1,xmax);   % y-axis initialzation
Tc = 1;
T = 1023;

% [2. (Tc/T)*(#Agreements - #Disagreements)]
for i = 1:xmax
    
    % Set the value every iteration
    Agr = 0;
    Disagr = 0;
    shift = mod(i, 1023);
    y2_shift = [y2(1+shift:1023) y2(1:1+shift-1)];
    
    % Calculate Agreements & Disagreements
    for j = 1:1023
        if y1(j) == y2_shift(j)
            Agr = Agr + 1;
        else
            Disagr = Disagr + 1;
        end
    end
    
    % Caculate result
    corr(i) = (Tc/T)*(Agr - Disagr);
end

% [3. Plotting]
plot(x,corr);
axis([0 xmax -0.5 1.5]);

end