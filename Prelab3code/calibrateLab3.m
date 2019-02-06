function [A, B, C] = calibrateLab3(Tl, Tm, Th, Rl, Rm, Rh)

% define x's and y's
x1 = 1/(Tl+273);
x2 = 1/(Tm+273);
x3 = 1/(Th+273);

y1 = log(Rl);
y2 = log(Rm);
y3 = log(Rh);

% solve for C, then B, then A
C = ( x3*(y1-y2) - x1*(y1-y2) + y1*x1 - y1*x2 - y3*x1 + y3*x2 ) / ...
    ( (y3^3)*(y1-y2) - y1*(y2^3) + y1^4 - (y1^3)*(y1 - y2) + y3*(y2^3) - y3*(y1^3));

B = ( x1 - x2 + C*(y2^3) -C*(y1^3) ) / ...
    ( y1-y2 );

A = x2 - B*y2 - C*(y2^3);




end