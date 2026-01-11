function test5()
% Projekt 2, zadanie 42
% Ulyana Frolova, 341910
%
% Test poprawności działania algorytmu – równanie różniczkowe rzędu >1
% Cel testu:
%   Sprawdzić, czy implementacja metody daje poprawne wyniki dla równań 
%   różniczkowych rzędu większego niż 1 przy różnych liczbach kroku oraz 
%   sprawdzić rząd zbieżności.
% Dane wejściowe: 
%   y''' = x, y(0)=0, y'(0)=0, y''(0)=0
% Oczekiwany wynik:
%   y(x) = (1/24) x^4

fprintf('------------- TEST 5: y'''''' = x ------------\n');
fprintf('-------- Oczekiwane: y(x)=(1/24)x^4 -------\n');
fprintf('-------------------------------------------\n');

x0 = 0;
xN = 1;
y0 = [0; 0; 0];
b = @(x) x;
a0 = @(x) 0;
a1 = @(x) 0;
a2 = @(x) 0;
a  = {a0, a1, a2};
y_exact_func = @(x) (1/24)*x.^4;

N_values = [1 10 100];
h_vec = zeros(size(N_values));

for i = 1:length(N_values)
    N = N_values(i);
    h_vec(i) = (xN - x0)/N;

    [y_num, x] = P2Z42_UFR_rk3(b, a, x0, xN, y0, N);
    y_exact = y_exact_func(x);

    current_error = abs(y_num(1,:) - y_exact);
    
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

end % function