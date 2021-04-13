function value = myRiemannSum(f,a,b,n)
    % Random interval Riemann sum / Riemann integration
    value = 0;
    dx = (b-a) / n;
    for k = 1 : n
        c = dx * rand + (a + (k-1) * dx);
        value = value + f(c);
    end
    value = dx*value;
end