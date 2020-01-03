% [MEN48201 Project1-1 made by 20161253 Yuho Jeong]

% Function which generates 1023bit C/A Codes for PRN number 1~37
function G = cacode(PRN_num)

% [1. Variables declaration & initialization]

% Code Phase Selection Table (G2)
G2_select=[2 6;     % PRN_num: 1
           3 7;     % PRN_num: 2
           4 8;     % PRN_num: 3
           5 9;     % PRN_num: 4
           1 9;     % PRN_num: 5
           2 10;    % PRN_num: 6
           1 8;     % PRN_num: 7
           2 9;     % PRN_num: 8
           3 10;    % PRN_num: 9
           2 3;     % PRN_num: 10
           3 4;     % PRN_num: 11
           5 6;     % PRN_num: 12
           6 17;    % PRN_num: 13
           7 8;     % PRN_num: 14
           8 9;     % PRN_num: 15
           9 10;    % PRN_num: 16
           1 4;     % PRN_num: 17
           2 5;     % PRN_num: 18
           3 6;     % PRN_num: 19
           4 7;     % PRN_num: 20
           5 8;     % PRN_num: 21
           6 9;     % PRN_num: 22
           1 3;     % PRN_num: 23
           4 6;     % PRN_num: 24
           5 7;     % PRN_num: 25
           6 8;     % PRN_num: 26
           7 9;     % PRN_num: 27
           8 10;    % PRN_num: 28
           1 6;     % PRN_num: 29
           2 7;     % PRN_num: 30
           3 8;     % PRN_num: 31
           4 9;     % PRN_num: 32
           5 10;    % PRN_num: 33
           4 10;    % PRN_num: 34
           1 7;     % PRN_num: 35
           2 8;     % PRN_num: 36
           4 10];   % PRN_num: 37

% Initial state of G1 & G2
G1 = [1 1 1 1 1 1 1 1 1 1];
G2 = [1 1 1 1 1 1 1 1 1 1];

% Polynomial of G1 & G2
extr1 = [0 0 1 0 0 0 0 0 0 1];  % x(3), x(10)
extr2 = [0 1 1 0 0 1 0 1 1 1];  % x(2), x(3), x(6), x(8), x(9), x(10)

% Code Phase Selection
select = G2_select(PRN_num,:);

% [2. C/A Code Generator]
for i = 1:1023
    
    % Phase selector
    temp = mod(sum(G2(select), 2), 2);
   
    % Generate 1bit of C/A code
    G(i) = mod(G1(10) + temp, 2);
   
    % Ouput of mod2-sum
    temp1 = G1 .* extr1;        % G1 extraction
    temp2 = G2 .* extr2;        % G2 extraction
    G1m = mod(sum(temp1), 2);   % Change temp1 to mod2-sum bit
    G2m = mod(sum(temp2), 2);   % Change temp2 to mod2-sum bit
    
    % Shifting
    G1 = [G1m G1(1:9)];
    G2 = [G2m G2(1:9)];
end
       
end
