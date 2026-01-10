function [] = numtest2()
% Projekt 1, zadanie 24
% Ulyana Frolova, 341910
%
% NUMTEST 2 — Test funkcji szybko rosnącej
% Cel testu:
%   Ocenić zachowanie metody dla funkcji o dużych wartościach i szybko
%   rosnącej i zbadać, jak podział obszaru wpływa na dokładność wyniku
% Działanie:
%   Funkcja testowa nie przyjmuje żadnych argumentów i nic ni zwraca, ale 
%   wypisuje wyniki w ładny sposób do konsoli i pokazuje wizualizację

fprintf('------------------------ NUMTEST 2 -----------------------\n');
fprintf('----------------- Funkcja szybko rosnąca -----------------\n');
fprintf('------------------ f(x, y) = exp(30x+30y) ----------------\n');

f = @(x,y) exp(30*(x+y));

% Obliczenie dokładnej wartości całki metodą integral2
I_ref = integral2(f, -1, 1, @(x) -(1-abs(x)), @(x) (1-abs(x)), ...
    'AbsTol',1e-12,'RelTol',1e-12);

% Wartości n do przetestowania
n_values = [1, 5, 10, 100, 1000, 2000];

fprintf('  n  |      I_num      |      I_ref      |      Error\n');
fprintf('----------------------------------------------------------\n');

I_num_values = zeros(size(n_values));
errors = zeros(size(n_values));

for i = 1:length(n_values)
    n = n_values(i);
    % Wywołanie programu głównego
    I_num = P1Z24_UFR_romb(f, n);
    I_num_values(i) = I_num;
    % Błąd bezwzględny
    errors(i) = abs(I_num - I_ref);
    fprintf('%4d | %15.1f | %15.1f | %.1f\n', n, I_num, I_ref, errors(i));
end

% Wykres 1: wartość całki
disp('Press any key to see the plot...');
pause;
figure;
set(gca, 'TitleFontSizeMultiplier', 1.3);
set(gca, 'LabelFontSizeMultiplier', 1.2);
plot(n_values, I_num_values, 'LineWidth', 2.0, 'Color', 'b');
hold on;
plot(n_values, I_ref * ones(size(n_values)), '--', ...
    'LineWidth', 2.0, 'Color', 'r');
xlabel('n', 'FontSize', 16);
ylabel('Wartość całki', 'FontSize', 16);
title('Porównanie I_num oraz I_ref', ...
    'FontSize', 16, 'FontWeight', 'bold', 'Interpreter', 'none');
legend('I_{num}', 'I_{ref}', 'Location', 'best', 'FontSize', 12);
grid on;

% Wykres 2: błąd
disp('Press any key to see the plot with errors...');
pause;
figure;
loglog(n_values, errors, 'o-', 'LineWidth', 1.8, 'MarkerSize', 8, ...
    'Color', 'r');
xlabel('n', 'FontSize', 16);
ylabel('| I_{num} - I_{ref} | (skala log)');
title('Błąd bezwzględny', 'FontSize', 16);
grid on;

disp('Press any key to continue...');
pause;

end % function