clear;
close all;
clc;
syms x;
y = input('Enter function(function of x) : ');
g = diff(y);
dg = diff(g);

l = input('Input lower limit of interval :');
r = input('Input higher limit of interval :');
oldx = (l+r)/2;
e = 1e-6;
error = vpa(subs(g,x,oldx));
cnt = 0;

while abs(error)>e && cnt<100
    newx = oldx - vpa(subs(g,x,oldx))/vpa(subs(dg,x,oldx));
    if newx<=l
        newx = l + 1e-7;
    end
    if newx>=r
        newx = r - 1e-7;
    end
    error = vpa(subs(g,x,newx));
    oldx = newx;
    cnt = cnt+1;
end
fprintf('function has either minima or maxima at %f.\n',oldx);

a = l - (r-l)*0.5;
b = r + (r-l)*0.5;
x_arr = a:0.1:b;
y_arr = vpa(subs(y, x, x_arr));

figure(1);
hold on;
plot(x_arr, y_arr,'linewidth',2);
scatter([oldx], [vpa(subs(y,x,oldx))], 40, 'red', 'h', 'filled');
text(oldx-1, vpa(subs(y,x,oldx))+5, 'Extreme point');
xlim([a b]);
xlabel('X-axis');
ylabel('Y-axis');
title('f(x)=x^3 + (x-3)^2 extreme point at x=1.1196')
grid on;
