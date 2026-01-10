function [] = test3()
% Projekt 1, zadanie 24
% Ulyana Frolova, 341910
%
% TEST 3 — Test poprawności obliczeń dla funkcji kwadratowej
% W testach porównujemy wynik numeryczny I_num z analitycznym I_ref
% Cel testu:
%   Sprawdzić, czy implementacja kwadratury na rombie daje poprawne wyniki
%   dla funkcji kwadratowych przy różnych gęstościach siatki
% Oczekiwany wynik: 
%   Kwadratura powinna dokładnie integrować funkcje wielomianowe stopnia 2
% Działanie:
%   Funkcja testowa nie przyjmuje żadnych argumentów i nic nie zwraca, ale 
%   wypisuje wyniki w ładny i czytelny sposób do konsoli

fprintf('------------------- TEST 3 ------------------\n');
fprintf('------------- Funckja kwadratowa ------------\n');
fprintf('------------- f(x,y) = 2x²−3xy−y² -----------\n');

% Definicja funkcji testowej
f = @(x,y) 2*(x.^2) - 3*x.*y - y.^2;

% Wartość całki obliczona analitycznie
I_ref = 1/3;

% Wartości n do przetestowania
n_values = [1, 10, 100];

fprintf('   n   |    I_num   |    I_ref   |   Error\n');
fprintf('---------------------------------------------\n');

for n = n_values
    % Wywołanie programu głównego
    I_num = P1Z24_UFR_romb(f, n);
    % Błąd bezwzględny
    error = abs(I_num - I_ref);
    fprintf('%4d   |  %.6f  |  %.6f  |  %.6f\n', n, I_num, I_ref, error);
end

fprintf('\nPress any key to continue...\n');
pause; 

end % function