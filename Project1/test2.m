function [] = test2()
% Projekt 1, zadanie 24
% Ulyana Frolova, 341910
%
% TEST 2 — Test poprawności obliczeń dla funkcji liniowej
% W testach porównujemy wynik numeryczny I_num z analitycznym I_ref
% Cel testu:
%   Sprawdzić, czy implementacja kwadratury na rombie daje poprawne wyniki
%   dla funkcji liniowych przy różnych gęstościach siatki
% Oczekiwany wynik: 
%   Kwadratura powinna dokładnie integrować funkcje wielomianowe stopnia 1
% Działanie:
%   Funkcja testowa nie przyjmuje żadnych argumentów i nic nie zwraca, ale 
%   wypisuje wyniki w ładny i czytelny sposób do konsoli

fprintf('------------------- TEST 2 ------------------\n');
fprintf('-------------- Funckja liniowa --------------\n');
fprintf('-------------- f(x,y) = 2x+3y+1 -------------\n');

% Definicja funkcji testowej
f = @(x,y) 2*x + 3*y +1;

% Wartość całki obliczona analitycznie
I_ref = 2;

% Wartości n do przetestowania
n_values = [1, 10, 100];

fprintf('   n   |    I_num   |    I_ref   |   Error\n');
fprintf('---------------------------------------------\n');

for n = n_values
    % Wywołanie programu głównego
    I_num = P1Z24_UFR_romb(f, n);
    % Błąd bezwzględny
    error = abs(I_num - I_ref);
    fprintf('%4d   |  %.6f  |  %.6f  |  %f\n', n, I_num, I_ref, error);
end

fprintf('\nPress any key to continue...\n');
pause; 

end % function