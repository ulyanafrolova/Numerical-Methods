function numtest4()
% Projekt 2, zadanie 42
% Ulyana Frolova, 341910
%
% Test numeryczny – równanie wysokiego rzędu z wielomianową prawą stroną
% Cel testu:
%   Zbadać zachowanie oraz dokładność metody RK3 dla liniowego
%   równania różniczkowego wyższych rzędów z wielomianową prawą stroną, 
%   poprzez porównanie rozwiązania numerycznego z rozwiązaniem dokładnym.
% Równanie:
%   y^(8) - y^(6) + y^(4) - y'' = 40320 - 20160*x^2 + 1680*x^4 - 56*x^6
% Warunki początkowe:
%   y^(k)(0) = 0,  k = 0,...,7
% Rozwiązanie dokładne:
%   y(x) = x^8

fprintf('-- NUMTEST 4: y⁽⁸⁾−y⁽⁶⁾+y⁽⁴⁾−y''=40320−20160x²+1680x⁴−56x⁶--\n');

x0 = 0;
xN = 1;

% Warunki początkowe
y0 = zeros(8,1);

% Siatki numeryczne do analizy zbieżności
N_values = [20 200 2000];
err_values = zeros(size(N_values));

% Funkcje współczynników
a0 = @(x) 0;
a1 = @(x) 0;
a2 = @(x) -1;
a3 = @(x) 0;
a4 = @(x) 1;
a5 = @(x) 0;
a6 = @(x) -1;
a7 = @(x) 0;
a = {a0,a1,a2,a3,a4,a5,a6,a7};

% Prawa strona
b = @(x) 40320 - 20160*x.^2 + 1680*x.^4 - 56*x.^6;

% Rozwiązanie dokładne
y_exact = @(x) x.^8;

% Stała siatka do rysowania rozwiązania dokładnego
x_fine = linspace(x0, xN, 5000);
y_fine = y_exact(x_fine);

for k = 1:length(N_values)
    N = N_values(k);
    [y_num, x] = P2Z42_UFR_rk3(b, a, x0, xN, y0, N);
    % Maksymalny błąd w węzłach metody
    err = max(abs(y_num(1,:) - y_exact(x)));
    err_values(k) = err;
    fprintf('N = %4d   Max error = %.3e\n', N, err);
    % Wykres porównawczy
    figure;
    plot(x_fine, y_fine, 'b', 'LineWidth', 2); hold on;
    plot(x, y_num(1,:), 'r--', 'LineWidth', 1.5);
    grid on;
    xlabel('x');
    ylabel('y(x)');
    legend('Dokładne', 'Numeryczne', 'Location','best');
    title(sprintf('NUMTEST 4 — N = %d', N));
end

% Wykres zbieżności
figure;
loglog(N_values, err_values, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
grid on;
xlabel('Liczba kroków N');
ylabel('Błąd maksymalny');
title('Zależność błędu maksymalnego od liczby kroków N');

end % function
