%% Define x
x = 0:0.1:100;


%% Max speed efficiency function
max_speed = @(x) 235*(((exp(0.1 .* (x-50))./(exp(0.1 .* (x-50)) + 1)) + 0.05.*sin(x) - (0.1*exp(-abs(x-10)) + 0.2*exp(-abs(x-21)) + 0.3*exp(-abs(x-35)) + 0.3*exp(-abs(x-50)) + 0.2*exp(-abs(x-80)))));
figure(1);
plot(x, max_speed(x));
xlabel('Power');
ylabel('Max Speed (MPH)');
title('Max-speed efficiency');
grid on;

%% Handling efficiency function
max_handling_x = 60;
handling = @(x) (5.519) * ((x <= max_handling_x) .* exp(0.2*(x-max_handling_x/2.3))./(exp(0.2*(x-max_handling_x/2.3)) + 1) + (x > max_handling_x) .* exp(-0.07*(x - max_handling_x))) - (0.2*exp(-abs(x-10)) + 0.2*exp(-abs(x-21)) + 0.3*exp(-abs(x-35)) + 0.3*exp(-abs(x-50)) + 0.2*exp(-abs(x-80)));
figure(2);
plot(x, handling(x));
xlabel('Power');
ylabel('Handling');
title('Handling efficiency');
grid on;

%% Accelaration efficiency function
accelaration = @(x) (1/1.04e-3) * (1 - exp(-0.15*x) + 1e-7 * exp(exp(exp(0.01*x))) + 0.02 * sin(x));
figure(3);
plot(x, accelaration(x));
xlabel('Power');
ylabel('Accelaration (RPM)');
title('Accelaration efficiency');
grid on;

%% Optimal tuning point
% We need to find the tuning points x 
% s.t. max_speed(x) = 10 * handling(x) + 0.23 * accelaration(x)
% the optimal tuning point will be the maximum of all the tuning points
% We take f(x) = max_speed(x) - 10 * handling(x) - 0.23 * accelaration(x)
% We will find zeros of f, to find the optimal x, we will start from the 
% Rightmost point in secant method
f = @(x) max_speed(x) - 0.23 * accelaration(x) - 10 * handling(x);
figure(4);
plot(x, f(x));
xlabel('Power');
ylabel('f');
title('f = max-speed - 0.23 * accelaration - 10 * handling');
grid on;

%% Secant method to find roots of f

[ans1, nfinal] = secant_solver(f, 100, 99, 100, 1e-7);
[t1, t1_] = secant_solver(f, 0, 0.01, 100, 1e-7);
[t2, t2_] = secant_solver(f, 80, 81, 100, 1e-7);
figure(5);
hold on;
plot(x, f(x));
scatter([t1(end), t2(end)], [0, 0], 30, 'black', 'd', 'filled');
scatter([ans1(end)], [0], 40, 'red', 'h', 'filled');
text(t1(end)+2, 0, 'Tuning point 1');
text(t2(end)-10, -10, 'Tuning point 2');
text(ans1(end)-15, 20, 'Optimal tuning');
text(ans1(end)-5, 10, 'point');
xlabel('Power');
ylabel('f');
title('f = max-speed - 0.23 * accelaration - 10 * handling');
grid on;

