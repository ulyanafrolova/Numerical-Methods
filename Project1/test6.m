function [] = test6()
% Projekt 1, zadanie 24
% Ulyana Frolova, 341910
%
% TEST 6 — Test poprawności obliczeń dla funkcji wielomianowej stopnia 4
% W testach porównujemy wynik numeryczny I_num z analitycznym I_ref
% Cel testu:
%   Zweryfikować zachowanie kwadratury rzędu 3-go dla funkcji 
%   wielomianowych stopnia wyższego niż dokładność wzoru oraz obliczyć 
%   rząd zbieżności metody (ozn. p)
% Oczekiwany wynik:
%   Kwadratura 3-go rzędu nie integruje dokładnie wielomianów stopnia 4, 
%   ale I_num powinna zbliżać się do I_ref wraz ze wzrostem parametru n,
%   Oczekiwany rząd zbieżności p = 4
% Działanie:
%   Funkcja testowa nie przyjmuje żadnych argumentów i nic nie zwraca, ale 
%   wypisuje wyniki w ładny i czytelny sposób do konsoli

fprintf('----------------------- TEST6 ----------------------\n');
fprintf('------------------ Funckja stopnia 4 ---------------\n');
fprintf('------------------- f(x,y) = x⁴+y⁴ -----------------\n');

% Definicja funkcji testowej
f = @(x,y) x.^4 + y.^4;

% Wartość całki obliczona analitycznie
I_ref = 4/15;

% Wartości n do przetestowania
n_values = [1, 10, 100];
errors = zeros(size(n_values));

fprintf('   n   |     I_num     |     I_ref     |   Error\n');
fprintf('----------------------------------------------------\n');

k = 1;
for n = n_values
    % Wywołanie programu głównego
    I_num = P1Z24_UFR_romb(f, n);
    % Błąd bezwzględny
    error = abs(I_num - I_ref);
    errors(k) = error;
    fprintf('%4d   |  %.9f  |  %.9f  | %.9f\n', n, I_num, I_ref, error);
    k = k + 1;
end

p = log(errors(end-1) / errors(end)) / log(n_values(end) ...
    / n_values(end-1));
fprintf('\nSzacowany rząd zbieżności p ≈ %.4f\n', p);

disp('Press any key to continue...');
pause; 

end % function