function [] = test5()
% Projekt 1, zadanie 24
% Ulyana Frolova, 341910
%
% TEST 5 — Test symetrii dla trzech funkcji nieparzystych
% W testach porównujemy wynik numeryczny I_num z analitycznym I_ref
% Cel testu:
%   Sprawdzić, czy kwadratura poprawnie integruje funkcje nieparzyste,
%   dla których całka na symetrycznym rombie wynosi dokładnie 0
% Oczekiwany wynik: 
%   I = 0 dla każdej funkcji i każdego n
% Działanie:
%   Funkcja testowa nie przyjmuje żadnych argumentów i nic nie zwraca, ale 
%   wypisuje wyniki w ładny i czytelny sposób do konsoli

fprintf('------------------- TEST5 -------------------\n');
fprintf('------------- Funckje nieparzyste -----------\n');

% Definicje funkcji
functions = {
    @(x,y) x.^3 .* (y.^2); % Nieparzysta względem OX
    @(x,y) y.^7; % Nieparzysta względem OY
    @(x,y) x.^9 .* y.^13; % Nieparzysta względem OX i OY
};

% Nagłówki
names = {
    ' f1(x,y) = x³y² -';
    ' f2(x,y) = y⁷ ---';
    ' f3(x,y) = x⁹y¹³ '
};

% Wartość całki obliczona analitycznie
I_ref = 0;

% Wartości n do przetestowania
n_values = [1, 10, 100];

for k = 1:3
    fprintf('---------------%s-------------\n', names{k});
    fprintf('   n   |    I_num   |    I_ref   |   Error\n');
    fprintf('---------------------------------------------\n');

    fk = functions{k};
    I_num = arrayfun(@(n) P1Z24_UFR_romb(fk, n), n_values);
    errors = abs(I_num - I_ref);
    for i = 1:numel(n_values)
        fprintf('%4d   | % .6f  | % .6f  | % .6f\n', ...
                n_values(i), I_num(i), I_ref, errors(i));
    end

    fprintf('\nPress any key to continue...\n');
    pause;

end

end % function