function [y, x] = P2Z42_UFR_rk3(b, a, x0, xN, y0, N)
% Projekt 2, zadanie 42
% Ulyana Frolova, 341910
%
% Funkcja przybliża rozwiązanie liniowego równania różniczkowego dowolnego
% rzędu metodą Rungego-Kutty 3-go rzędu (α = 1/3, β = 2/3).
% Argumenty wejsciowe:
%   b   - uchwyt do funkcji b(x) (prawa strona równania)
%   a   – tablica funkcji współczynników {a0(x), a1(x), ..., a_{m-1}(x)}
%   x0  – początek przedziału
%   xN  – koniec przedziału
%   y0  – wektor warunku początkowego w punkcie x0 (m×1)
%   N   – liczba kroków podziału przedziału [x0, xN]
% Argumenty wyjściowe:
%   y   – macierz przybliżeń rozwiązania (m × (N+1))
%       każdy wiersz odpowiada składowej układu,
%       każda kolumna odpowiada kolejnemu węzłowi siatki
%   x   – wektor węzłów siatki w przedziale [x0, xN]

% Rząd układu
m = numel(y0);
% Krok
h = (xN - x0)/N;
% Wektor węzłów
x = linspace(x0, xN, N+1);

% Inicjalizacja macierzy rozwiązania
y = zeros(m, N+1);
% Warunek początkowy
y(:,1) = y0;

% Parametry RK3
alpha = 1/3;
beta  = 2/3;

% Stosujemy metodę Rungego-Kutty rzędu 3-go
for n = 1:N
    % Wektor pochodnych w punkcie początkowym kroku
    k0 = right(x(n), y(:,n), b, a);
    % Wektor pochodnych w punkcie przesuniętym o alpha*h
    k1 = right(x(n)+alpha*h, y(:,n)+alpha*h*k0, b, a);
    % Wektor pochodnych w punkcie przesuniętym o beta*h
    k2 = right(x(n)+beta*h, y(:,n) + h*beta*k1, b, a);
    % Zapisujemy nowy wektor stanu w następnej kolumnie macierzy y
    y(:,n+1) = y(:,n) + (h/4) * (k0 + 3*k2);
end

end % function
