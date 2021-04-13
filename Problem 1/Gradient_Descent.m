clear;
close all;
clc;
syms x;
y = input('Enter function(function of x) : ');
g = diff(y);

e = 1e-6;
LR = -0.01; %Learning Rate

%%% MINIMA
oldx = 0.1;
error = vpa(subs(g,x,oldx));
cnt = 0;
while abs(error)>e && cnt<1000
    newx = oldx - abs(LR)*(vpa(subs(g,x,oldx)));
    error = vpa(subs(g,x,newx));
    oldx = newx;
    cnt = cnt+1;
end

if cnt==1000
    fprintf('No minima found.\n');
else
    fprintf('Minima found at %f.\n',oldx);
end

x_arr = -3:0.01:3;
y_arr = vpa(subs(y,x,x_arr));

figure(1);
hold on;
plot(x_arr,y_arr,'linewidth',2);
scatter([oldx], [vpa(subs(y,x,oldx))], 40, 'red', 'h', 'filled');
text(oldx-0.25, vpa(subs(y,x,oldx))-1, 'Minima');
xlim([-pi pi]);
ylim([-15 10]);
xlabel('X-axis');
ylabel('Y-axis');
title('f(x)=x^4 - 8x^2 + 3 minima at x=2.0000')
grid on;


%%% MAXIMA
% oldx = 0;
% error = vpa(subs(g,x,oldx));
% cnt = 0;
% while abs(error)>e && cnt<100
%     newx = oldx - (-1*abs(LR))*(vpa(subs(g,x,oldx)));
%     error = vpa(subs(g,x,newx));
%     oldx = newx;
%     cnt = cnt+1;
% end
% 
% if cnt==100
%     fprintf('No maxima found.\n');
% else
%     fprintf('Maxima found at %f.\n',oldx);
% end
