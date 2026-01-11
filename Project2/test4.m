function test4()
% Projekt 2, zadanie 42
% Ulyana Frolova, 341910
%
% Test poprawności działania algorytmu – wielomian stopnia 3
% Cel testu: 
%   Sprawdzić, czy implementacja metody daje poprawne wyniki dla funkcji 
%   wielomianowych stopnia 3 przy różnych liczbach kroku oraz sprawdzić 
%   rząd zbieżności.
% Dane wejściowe: 
%   y' = x^3, y(0)=0
% Oczekiwany wynik:
%   y(x) = (1/4) x^4

fprintf('------------- TEST 4: y'' = x^3 -------------\n');
fprintf('--------- Oczekiwane: y(x)=0.25x^4 --------\n');
fprintf('-------------------------------------------\n');

x0 = 0;
xN = 1;
y0 = 0;
b = @(x) x.^3;
a = {};
y_exact_func = @(x) 0.25 * x.^4;

N_values = [1 10 100];

err_max_vec = zeros(size(N_values));
h_vec = zeros(size(N_values));

for i = 1:length(N_values)
    N = N_values(i);
    h_vec(i) = (xN - x0)/N;

    [y_num, x] = P2Z42_UFR_rk3(b, a, x0, xN, y0, N);
    y_exact = y_exact_func(x);

    current_error = abs(y_num(1,:) - y_exact);
    
    % Zapamiętanie błędu maksymalnego dla N (do rzędu zbieżności)
    err_max_vec(i) = max(current_error);
    
    fprintf('\n------------ Wyniki dla N = %3d -----------\n', N);
    fprintf('%6s | %10s | %10s | %8s\n', 'x', 'y_num', 'y_exact', 'Error');
    fprintf('-------------------------------------------\n');
    
    line_counter = 0; 
    
    for k = 1:length(x)
        fprintf('%6.4f | %10.8f | %10.8f | %8.2e\n', ...
            x(k), y_num(1,k), y_exact(k), current_error(k));

        line_counter = line_counter + 1;
        if line_counter >= 20 
            fprintf('\nNaciśnij dowolny klawisz, aby kontynuować...\n');
            pause; 
            line_counter = 0;
        end
    end
    
    if i < length(N_values)
        fprintf('\nKoniec testu dla N=%d. Naciśnij klawisz...\n', N);
        pause;
    end
end

fprintf('-------------------------------------------\n');

% Obliczenie rzędu zbieżności na podstawie błędów maksymalnych
p = log(err_max_vec(1:end-1)./err_max_vec(2:end)) ... 
        ./ log(h_vec(1:end-1)./h_vec(2:end));

for k = 1:length(p)
    fprintf('Między N=%d a N=%d: p ≈ %.3f\n', ...
        N_values(k), N_values(k+1), p(k));
end

end % function