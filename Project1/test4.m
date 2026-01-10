function [] = test4()
% Projekt 1, zadanie 24
% Ulyana Frolova, 341910
%
% TEST 4 — Test poprawności obliczeń dla funkcji wielomianowej stopnia 3
% W testach porównujemy wynik numeryczny I_num z analitycznym I_ref
% Cel testu:
%   Sprawdzić, czy kwadratura rzędu 3-go na rombie poprawnie aproksymuje
%   całkę funkcji wielomianowych stopnia 3 dla rosnących gęstości siatki
% Oczekiwany wynik:
%   Kwadratura nie musi dokładnie integrować funkcji stopnia 3, ale wynik
%   numeryczny powinien zbiegać w kierunku wartości analitycznej przy
%   zwiększaniu parametru n
% Działanie:
%   Funkcja testowa nie przyjmuje żadnych argumentów i nic nie zwraca, ale 
%   wypisuje wyniki w ładny i czytelny sposób do konsoli

fprintf('------------------- TEST 4 ------------------\n');
fprintf('------------- Funckja sześcienna ------------\n');
fprintf('----------------- f(x,y) = x³ ---------------\n');

% Definicja funkcji testowej
f = @(x,y) x.^3;

% Wartość całki obliczona analitycznie
I_ref = 0;

% Wartości n do przetestowania
n_values = [1, 10, 100];

fprintf('   n  |    I_num    |    I_ref   |  Error\n');
fprintf('---------------------------------------------\n');

for n = n_values
    % Wywołanie programu głównego
    I_num = P1Z24_UFR_romb(f, n);
    % Błąd bezwzględny
    error = abs(I_num - I_ref);
    fprintf('%4d  |  % .6f  | % .6f  | %.6f\n', n, I_num, I_ref, error);
end

fprintf('\nPress any key to continue...\n');
pause; 

end % function