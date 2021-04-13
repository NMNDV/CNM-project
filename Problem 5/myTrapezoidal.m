function trap = myTrapezoidal(func, low, high, nInterval)

    h = (high-low)/nInterval;
    sum = 0;
    
    for k=1:1:nInterval-1
        x(k) = low + k*h;
        y(k) = func(x(k));
        sum = sum + y(k);
    end
    
    trap = h/2 * (func(low)+func(high)+2*sum);
end

