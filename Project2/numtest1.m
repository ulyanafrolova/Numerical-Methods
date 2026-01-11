function numtest1()
% Projekt 2, zadanie 42
% Ulyana Frolova, 341910
%
% Test numeryczny – a(x) zbliża się do zera w punkcie przedziału
% Cel testu:
%   Zbadać zachowanie oraz stabilność metody w sytuacji, gdy współczynnik 
%   równania różniczkowego silnie maleje w pobliżu pewnego punktu, co 
%   prowadzi do zmiany pochodnej rozwiązania, poprzez porównanie 
%   rozwiązania numerycznego z rozwiązaniem dokładnym.
% Dane wejściowe:
%   ((x−0.35)^2 + 10⁻⁶) · y'(x) = 1, y(0) = 0
% Oczekiwany wynik:
%   y(x)=(1/sqrt(10⁻⁶))·(atan((x−0.35)/sqrt(10⁻⁶))−atan(−0.35/sqrt(10⁻⁶)))

fprintf('--- NUMTEST 1: ((x−0.35)^2 + 10⁻⁶)y''=1 ---\n');

x0 = 0; 
xN = 1;

% Warunki początkowe
y0 = 0;

N_values = [10 100 5000];
err_values = zeros(size(N_values));

% Współczynniki 
a = {};

% Prawa strona
b = @(x) 1 ./ ((x-0.35).^2 + 1e-6);

% Dokładne rozwiązanie
y_exact = @(x) (1/sqrt(1e-6)) * ...
    (atan((x-0.35)/sqrt(1e-6)) - atan(-0.35/sqrt(1e-6)));

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
    title(sprintf('NUMTEST 1: N = %d', N));
end

% Wykres zależności błędu maksymalnego od liczby kroków N
figure;
loglog(N_values, err_values, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
grid on;
xlabel('Liczba kroków N');
ylabel('Błąd maksymalny');
title('Zależność błędu maksymalnego od liczby kroków N');

end % function
