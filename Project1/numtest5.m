function [] = numtest5()
% Projekt 1, zadanie 24
% Ulyana Frolova, 341910
%
% NUMTEST 5 — Test funkcji nieciągłej
% Cel testu:
%   Ocenić odporność metody na brak gładkości funkcji, oraz zbadać, jak 
%   podział obszaru wpływa na dokładność wyniku.
% Działanie:
%   Funkcja testowa nie przyjmuje żadnych argumentów i nic ni zwraca, ale 
%   wypisuje wyniki w ładny sposób do konsoli i pokazuje wizualizację

fprintf('----------- NUMTEST 5 -----------\n');
fprintf('------- Funkcja nieciągła -------\n');
fprintf('---- f(x, y) = sign(x+y-0.1) ----\n');

% Definicja funkcji testowej
f = @(x,y) sign(x+y-0.1);

% Dokładna wartość całki
I_ref = -0.2;

% Wartości n do przetestowania
n_values = [1, 10, 100, 1000, 2000];

fprintf('  n  |  I_num  |  I_ref  | Error\n');
fprintf('---------------------------------\n');

I_num_values = zeros(size(n_values));
errors = zeros(size(n_values));

for i = 1:length(n_values)
    n = n_values(i);
    % Wywołanie programu głównego
    I_num = P1Z24_UFR_romb(f, n);
    I_num_values(i) = I_num;
    % Błąd bezwzględny
    errors(i) = abs(I_num - I_ref);
    fprintf('%4d | % .4f | % .4f | %.4f\n', n, I_num, I_ref, errors(i));
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