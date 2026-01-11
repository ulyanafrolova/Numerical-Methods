function numtest5()
% Projekt 2, zadanie 42
% Ulyana Frolova, 341910
%
% Test numeryczny – szybko zanikający składnik
% Cel testu:
%   Zbadać zachowanie oraz dokładność  metody dla liniowego równania 
%   różniczkowego z bardzo szybko zanikającym składnikiem, poprzez 
%   porównanie rozwiązania numerycznego z rozwiązaniem dokładnym przy 
%   różnych liczbach kroku. 
% Dane wejściowe: 
%   y' = -50y+e^(-x),  y(0) = 0
% Oczekiwany wynik:
%   y(x) = 1/49 (e^(-x)-e^(-50x))

fprintf('---- NUMTEST 5: y''=-50y+e^(-x) ----\n');
fprintf('-----------------------------------\n');
x0 = 0;
xN = 2;

% Warunki początkowe
y0 = 0;

N_values = [10 20 50 100 1000];
err_values = zeros(size(N_values));

% Współczynniki
a0 = @(x) 50;
a  = {a0};

% Prawa strona
b = @(x) exp(-x);

% Rozwiązanie dokładne
y_exact = @(x) (exp(-x) - exp(-50*x)) / 49;

% Stała siatka do rysowania rozwiązania dokładnego
x_fine = linspace(x0, xN, 1000);
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
    ylim([-1.2 1.2]); 
    grid on;
    xlabel('x');
    ylabel('y(x)');
    legend('Dokładne', 'Numeryczne', 'Location','best');
    title(sprintf('NUMTEST 5: N = %d', N));
end

% Wykres zależności błędu maksymalnego od liczby kroków N
figure;
loglog(N_values, err_values, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
grid on;
xlabel('Liczba kroków N');
ylabel('Błąd maksymalny');
title('Zależność błędu maksymalnego od liczby kroków N');

end % function

