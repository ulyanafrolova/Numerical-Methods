function [x, y] = coordinates(p0, p1, p2, n)
% Projekt 1, zadanie 24
% Ulyana Frolova, 341910
%
% Funkcja generuje równomierną siatkę punktów wewnątrz trójkąta
% Wejście:
%   p0, p1, p2 - wektory postaci [x, y] opisujące wierzchołki trójkąta
%   n - liczba podziałów każdej krawędzi trójkąta
% Wyjście:
%   x, y - macierze (n+1)x(n+1) zawierające współrzędne punktów siatki

% Inicjalizacja macierzy współrzędnych
x = zeros(n + 1, n + 1);
y = zeros(n + 1, n + 1);

% Przechodzimy po wierszach siatki od wierzchołka p0 do podstawy trójkąta
for i = 0:n
    % Lewy punkt na krawędzi p0–p1
    left = p0 + (p1 - p0) * (i / n);
    % Prawy punkt na krawędzi p0–p2
    right = p0 + (p2 - p0) * (i / n);
    % Dla każdego wiersza obliczamy punkty pomiędzy left i right
    for j = 0:i
        % Unikanie dzielenia przez zero
        if i == 0
            t = 0;
        else 
            t = j / i;
        end
        % Interpolacja liniowa pomiędzy punktami left i right
        pt = (1 - t) * left + t * right;
        % Zapis współrzędnych punktu do macierzy
        x(i + 1, j + 1) = pt(1);
        y(i + 1, j + 1) = pt(2);
    end
end

end % function
