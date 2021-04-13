function [x, nfinal] = secant_solver(f, x0, x1, N, tol)
    x(1) = x0; % Set initial guess
    x(2) = x1;
    n = 3; 
    nfinal = N + 1; 
    while (n <= N + 1)
      fe = f(x(n - 1)) * (x(n-1) - x(n-2)) / (f(x(n-1)) - f(x(n-2)));
      x(n) = x(n - 1) - fe;
      if (abs(fe) <= tol)
        nfinal = n; 
        break;
      end
      n = n + 1;
    end
end