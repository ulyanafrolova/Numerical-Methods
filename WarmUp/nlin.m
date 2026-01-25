function r = nlin(f)
% Frolova Ulyana, 341910
% Total minipoints score: 628.5

eps_m = eps();
max_roots = 20000;
found = zeros(max_roots, 1);
count = 0;
intervals = [
    -20000, -500;
    -500, -100;
    -100,-10;
    -10, -1;
    -1, -0.1;
    -0.1, 0;
    0, 0.1;
    0.1, 1;
    1, 10;
    10, 100;
    100, 500;
    500, 20000;
    ];
a_int = intervals(:,1);
b_int = intervals(:,2);
N = ceil(abs(b_int - a_int) * 10);
x = a_int + (b_int - a_int).* linspace(0,1,max(N));
y = f(x);
mask = imag(y)==0;
y(~mask) = 0;
y = real(y);
signs = sign(y);
changes_mask = signs(:,1:end-1).*signs(:,2:end) < 0;
[row_idx, col_idx] = find(changes_mask);
for i = 1:length(row_idx)
    if count >= max_roots, break; end
    a = x(row_idx(i), col_idx(i));
    b = x(row_idx(i), col_idx(i)+1);
    root = NaN;
    for iter = 1:50
        mid = (a + b) / 2;
        d = max(1, abs(mid)) * eps_m;
        if (b - a) < 1000 * d
            root = mid;
            break;
        end
        fmid = real(f(mid));
        if real(f(a))*fmid <= 0
            b = mid;
        else
            a = mid;
        end
    end
    if ~isnan(root)
        d = max(1, abs(root))  * eps_m;
        f1 = real(f(root - 500*d));
        f2 = real(f(root + 500*d));
        if f1 * f2 < 0
            duplicate = false;
            for j = 1:count
                d_old = max(1, abs(found(j)))  * eps_m;
                if abs(found(j) - root) <= 1000 * max(d, d_old)
                    duplicate = true;
                    break;
                end
            end
            if ~duplicate
                count = count + 1;
                found(count) = root;
            end
        end
    end
end

if count == 0
    r = [];
else
    r = found(1:count);
end
end % function
