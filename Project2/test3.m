function test3()
% Projekt 2, zadanie 42
% Ulyana Frolova, 341910
%
% Test poprawności działania algorytmu – wielomian stopnia 2
% Cel testu: 
%   Sprawdzić, czy implementacja metody daje poprawne wyniki dla funkcji 
%   kwadratowych przy różnych liczbach kroku.
% Dane wejściowe: 
%   y' = x^2, y(0)=0
% Oczekiwany wynik:
%   y(x) = (1/3) x^3

fprintf('------------ TEST 1: y'' = x^2 -------------\n');
fprintf('-------- Oczekiwane: y(x)=(1/3)x^3 --------\n');
fprintf('-------------------------------------------\n');

x0 = 0;
xN = 1;
y0 = 0;
b = @(x) x.^2;
a  = {};            
y_exact_func = @(x) (1/3)*x.^3;
N_values = [1 10 100]; 

for i = 1:length(N_values)
    N = N_values(i);
    [y_num, x] = P2Z42_UFR_rk3(b, a, x0, xN, y0, N);
    y_exact = y_exact_func(x);
    
    current_error = abs(y_num(1,:) - y_exact);

    fprintf('\n------------ Wyniki dla N = %3d -----------\n', N);
    fprintf('%6s | %10s | %10s | %6s\n', 'x', 'y_num', 'y_exact', 'Error');
    fprintf('-------------------------------------------\n');
    
    line_counter = 0; 
    
    for k = 1:length(x)
        fprintf('%6.4f | %6.8f | %6.8f | %6.2e\n', ...
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