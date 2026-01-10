function [q] = P1Z24_UFR_romb(f, n)
% Projekt 1, zadanie 24
% Ulyana Frolova, 341910
% 
% Funkcja oblicza całkę funkcji f(x, y) po powierzchni rombu 
% o wierzchołkach A(0,1), B(1,0), C(0,-1), D(-1,0) za pomocą podziału
% rombu na 4n² trójkątów przystających i oraz użycia kwadratury rzędu 3-go 
% na każdym z nich.
% Wejście:
%   f - uchwyt do funkcji dwóch zmiennych f(x, y), której argumenty x, y 
%   są wektorami
%   n – dodatnia liczba naturalna określająca liczbę podziałów każdej 
%   krawędzi rombu
% Wyjście:
%   q – przybliżona wartość całki

% Kontrola poprawności argumentów wejściowych
if nargin ~= 2
    error('Funkcja wymaga dwóch argumentów');
end
if ~isa(f, 'function_handle')
    error('Argument f musi być handlem do funkcji dwóch zmiennych');
end
if ~isscalar(n) || n <= 0 || floor(n) ~= n
    error('Argument n musi być dodatnią liczbą naturalną');
end

% Współrzędne wierzchołków rombu
A = [0, 1];
B = [1, 0];
C = [0, -1];
D = [-1, 0];
O = [0,0]; % środek rombu

% Podział rombu na 4 trójkąty i generacja n² małych trójkątów 
[p1a, p2a, p3a] = make_triangles(A, B, O, n);
[p1b, p2b, p3b] = make_triangles(B, C, O, n);
[p1c, p2c, p3c] = make_triangles(C, D, O, n);
[p1d, p2d, p3d] = make_triangles(D, A, O, n);

% Łączymy wszystkie trójkąty w jeden zbiór (4n² trójkątów)
p0 = [p1a; p1b; p1c; p1d];
p1 = [p2a; p2b; p2c; p2d];
p2 = [p3a; p3b; p3c; p3d];

% Punkty środkowe trójkątów 
p012 = (p0 + p1 +p2) / 3;

% Rozdzielenie współrzędnych na wektory x i y
x0 = p0(:,1); y0 = p0(:,2);
x1 = p1(:,1); y1 = p1(:,2);
x2 = p2(:,1); y2 = p2(:,2);

% Wyznacznik macierzy dla każdego trójkąta
% detA = x0.*(y1 - y2) + x1.*(y2 - y0) + x2.*(y0 - y1);

% Pole każdego małego trójkąta
% areas = 0.5 * abs(detA);

% Wartości funkcji w punktach kwadratury
f0   = f(x0, y0);
f1   = f(x1, y1);
f2   = f(x2, y2);
f012 = f(p012(:, 1), p012(:, 2));

% Kwadratura rzędu 3 na każdym trójkącie
%q = sum(areas .* (f0 + f1 + f2 + 9*f012) / 12);
q = sum((f0 + f1 + f2 + 9*f012) / 12) /(2*n*n);

end % function



