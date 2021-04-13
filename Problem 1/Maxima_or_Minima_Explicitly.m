clear;
close all;
clc;
syms x;
y = input('Enter function(function of x) : ');
g = diff(y);
dg = diff(g);

l = input('Input lower limit of interval : ');
r = input('Input higher limit of interval : ');


%%% MINIMA
oldx = (l+r)/2;
e = 1e-6;
error = vpa(subs(g,x,oldx));
cnt = 0;

while abs(error)>e && cnt<100
    newx = oldx - vpa(subs(g,x,oldx))/abs(vpa(subs(dg,x,oldx)));
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

if cnt==100
    fprintf('No Minima found.\n');
else
    fprintf('function has Minima at %f.\n',oldx);
end

p = oldx;


%%% MAXIMA
oldx = (l+r)/2;
e = 1e-6;
error = vpa(subs(g,x,oldx));
cnt = 0;

while abs(error)>e && cnt<100
    newx = oldx - vpa(subs(g,x,oldx))/-abs(vpa(subs(dg,x,oldx)));
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

if cnt==100
    fprintf('No Maxima found.\n');
else
    fprintf('function has Maxima at %f.\n',oldx);
end


a = l - (r-l)*0.5;
b = r + (r-l)*0.5;
x_arr = a:0.1:b;
y_arr = vpa(subs(y, x, x_arr));

figure(1)
hold on;
plot(x_arr, y_arr,'linewidth',2);
scatter([p], [vpa(subs(y,x,p))], 40, 'red', 'h', 'filled');
text(p-0.5, vpa(subs(y,x,p))+4, 'Minima');
scatter([oldx], [vpa(subs(y,x,oldx))], 40, 'black', 'h', 'filled');
text(oldx-0.5, vpa(subs(y,x,oldx))+4, 'Maxima');
xlim([a b]);
xlabel('X-axis');
ylabel('Y-axis');
title('f(x)=x^3 + (x-3)^2 minima at x=1.1196 maxima at x=-1.7863')
grid on;
