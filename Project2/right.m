function dy = right(x, y, b, a)
% Projekt 2, zadanie 42
% Ulyana Frolova, 341910
%
% Funkcja oblicza wektor prawej strony układu równań różniczkowych
% Argumenty wejsciowe:
%   x - bieżąca wartość zmiennej niezależnej
%   y – wektor wartości zmiennych stanu w p. x [y1(x); y2(x); ...; ym(x)]
%   b  – funkcja prawej strony równania b(x)
%   a  – tablica funkcji współczynników {a0(x), a1(x), ..., a_{m-1}(x)}
% Argumenty wyjściowe:
%   dy – wektor pochodnych zmiennych [y1'(x); y2'(x); ...; ym'(x)]

% Liczba równań w układzie
m = numel(y);
dy = zeros(m,1);

% Pierwsze równania: y1' = y2, y2' = y3, ..., y_{m-1}' = y_m
if m > 1
    dy(1:m-1) = y(2:m);
end

% Wektorowe obliczenie wartości współczynników a_j(x)
if ~isempty(a)
    a_vec = cellfun(@(f) f(x), a);
else
    a_vec = [];
end

% Ostatnie równanie: ym' = b(x) − Σ a_j(x)*y_j
if isempty(a_vec)
    s = b(x);
else
    s = b(x) - a_vec * y;
end

dy(end) = s;

end % function
