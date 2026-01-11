function numtest2()
% Projekt 2, zadanie 42
% Ulyana Frolova, 341910
%
% Test numeryczny – równanie liniowe rzędu 3 z prawą stroną sin(x)
% Cel testu:
%   Zbadać zachowanie oraz dokładność  metody dla liniowego równania 
%   różniczkowego rzędu trzeciego z niezerowymi współczynnikami oraz 
%   trygonometryczną prawą stroną, poprzez porównanie rozwiązania 
%   numerycznego z rozwiązaniem dokładnym przy różnych liczbach kroku. 
% Dane wejściowe: 
%   % y^(7) + 3 y^(5) - 2 y^(3) + y' = 5 cos(x)
% Oczekiwany wynik:
%   y(x) = sinx

fprintf('--- NUMTEST 2: y⁽⁷⁾+3y⁽⁵⁾−2y⁽³⁾+y''=5cos(x) ---\n');

x0 = 0; 
xN = 2*pi;

% Warunki początkowe
y0 = [
    sin(0);   
    cos(0);    
   -sin(0);    
   -cos(0);  
    sin(0);   
    cos(0);    
   -sin(0)     
];

N_values = [10 100 1000 5000];
err_values = zeros(size(N_values));

% Współczynniki
a0 = @(x) 0;    
a1 = @(x) 1;    
a2 = @(x) 0;     
a3 = @(x) -2;     
a4 = @(x) 0;
a5 = @(x) 3;
a6 = @(x) 0;
a = {a0,a1,a2,a3,a4,a5,a6};

% Prawa strona
b = @(x) 5*cos(x);

% Dokładne rozwiązanie
y_exact = @(x) sin(x);

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
    ylim([-1.2 1.2]); 
    grid on;
    xlabel('x');
    ylabel('y(x)');
    legend('Dokładne', 'Numeryczne', 'Location','best');
    title(sprintf('NUMTEST 2: N = %d', N));
end

% Wykres zależności błędu maksymalnego od liczby kroków N
figure;
loglog(N_values, err_values, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
grid on;
xlabel('Liczba kroków N');
ylabel('Błąd maksymalny');
title('Zależność błędu maksymalnego od liczby kroków N');

end % function

