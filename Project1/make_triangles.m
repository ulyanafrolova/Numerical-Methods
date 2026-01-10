function [p0, p1, p2] = make_triangles(A, B, C, n)
% Projekt 1, zadanie 24
% Ulyana Frolova, 341910
%
% Funkcja dzieli trójkąt o wierzchołkach A, B, C na dokładnie n² 
% przystających małych trójkątów
% Wejście:
%   A, B, C - wektory [x, y] opisujące wierzchołki trójkąta
%   n - liczba równych podziałów każdej krawędzi
% Wyjście:
%   p0, p1, p2 – macierze rozmiaru n² na n² zawierające współrzędne 
%   wierzchołków małych trójkątów wejściowych w postaci:
%   p0(k,:) – pierwszy wierzchołek trójkąta k-tego
%   p1(k,:) – drugi  wierzchołek trójkąta k-tego
%   p2(k,:) – trzeci wierzchołek trójkąta k-tego

% Inicjalizacja macierzy trójkątów
p0 = zeros(n * n, 2);
p1 = zeros(n * n, 2);
p2 = zeros(n * n, 2);

% Tworzymy siatkę punktów w trójkącie A-B-C
[x, y] = coordinates(A,B,C,n); % (n+1)x(n+1)

% Licznik zapisanych trójkątów
count = 1;

% Pętla po kolejnych wierzach siatki 
for i = 1:n
    % Indeksy dla trójkątów dolnych
    idx = 1:i;
    % Trójkąty dolne
    p0(count:count+i-1,:) = [x(i,idx)', y(i,idx)'];
    p1(count:count+i-1,:) = [x(i+1,idx)', y(i+1,idx)'];
    p2(count:count+i-1,:) = [x(i+1,idx+1)', y(i+1,idx+1)'];
    count = count + i;
    % Trójkąty górne (powstają tylko gdy i>1, bo musi istnieć prawy punkt
    if i > 1
        idx2 = 1:i-1;
        p0(count:count+i-2,:) = [x(i,idx2)', y(i,idx2)'];
        p1(count:count+i-2,:) = [x(i,idx2+1)', y(i,idx2+1)'];
        p2(count:count+i-2,:) = [x(i+1,idx2+1)', y(i+1,idx2+1)'];
        % Dodajemy i−1 kolejnych trójkątów
        count = count + i - 1;
    end
end

end % function