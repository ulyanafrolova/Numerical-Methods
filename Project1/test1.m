function [] = test1()
% Projekt 1, zadanie 24
% Ulyana Frolova, 341910
%
% TEST 1 — Test poprawności obliczeń dla funkcji stałej
% W testach porównujemy wynik numeryczny I_num z analitycznym I_ref
% Cel testu:
%   Sprawdzić, czy implementacja kwadratury na rombie daje poprawne wyniki
%   dla funkcji stałych przy różnych gęstościach siatki
% Oczekiwany wynik: 
%   Kwadratura powinna dokładnie integrować funkcje wielomianowe stopnia 0
% Działanie:
%   Funkcja testowa nie przyjmuje żadnych argumentów i nic nie zwraca, ale 
%   wypisuje wyniki w ładny i czytelny sposób do konsoli

fprintf('------------------- TEST 1 ------------------\n');
fprintf('--------------- Funkcja stała ---------------\n');
fprintf('---------------- f(x, y) = 5 ----------------\n');

% Definicja funkcji testowej
% f = @(x,y) 5
f = @(x,y) 5*ones(size(x));

% Wartość całki obliczona analitycznie
I_ref = 10;

% Wartości n do przetestowania
n_values = [1, 10, 100];

fprintf('   n   |    I_num   |    I_ref   |   Error\n');
fprintf('---------------------------------------------\n');

for n = n_values
    % Wywołanie programu głównego
    I_num = P1Z24_UFR_romb(f, n);
    % Błąd bezwzględny
    error = abs(I_num - I_ref);
    fprintf('%4d   |  %.5f  |  %.5f  |  %.5f\n', n, I_num, I_ref, error);
end

fprintf('\nPress any key to continue...\n');
pause; 

end % function
