% Assignment of Structural Dynamics
% RESPONSE SPECTRUM
clear global; clc;

% IMPORT EL CENTRO DATA
elcentro = xlsread('ELC1.xlsx');
t = elcentro(:,1);
E = elcentro(:,2);

% Input Data
% We have to plot the response spectrum for different values of xi
xis = [0, 0.025, 0.05, 0.1]; % Values of damping ratio xi
m = 1;
dt = t(2) - t(1);
T = (0.01:0.01:25)';
omega_n = 2 * pi ./ T;
K = m .* omega_n .* omega_n;

% Solution and Plotting for Spectral Displacement
figure;
for i = 1:length(xis)
    xi = xis(i);
    
    % Calculate displacement
    D = zeros(length(T),1);
    for j = 1:length(T)
        wn = omega_n(j);
        k = K(j);
        [u, ~] = function_code(xi, m, k, E, dt, wn);
        D(j) = max(abs(u));
    end
    
    % Plotting for Spectral Displacement
    plot(T, D, 'LineWidth', 2, 'DisplayName', ['\xi = ', num2str(xi)]);
    hold on;
end
xlabel('Time period (s)');
ylabel('Spectral Displacement (D, in.)');
title('Response Spectrum for Spectral Displacement');
legend('Location', 'best');

% Solution and Plotting for Spectral Velocity
figure;
for i = 1:length(xis)
    xi = xis(i);
    
    % Calculate velocity
    V = zeros(length(T),1);
    for j = 1:length(T)
        wn = omega_n(j);
        k = K(j);
        [~, v] = function_code(xi, m, k, E, dt, wn);
        V(j) = max(abs(v));
    end
    
    % Plotting for Spectral Velocity
    plot(T, V, 'LineWidth', 2, 'DisplayName', ['\xi = ', num2str(xi)]);
    hold on;
end
xlabel('Time period (s)');
ylabel('Spectral Velocity (V, in/s)');
title('Response Spectrum for Spectral Velocity');
legend('Location', 'best');

% Solution and Plotting for Spectral Acceleration
figure;
for i = 1:length(xis)
    xi = xis(i);
    
    % Calculate acceleration
    A = zeros(length(T),1);
    for j = 1:length(T)
        wn = omega_n(j);
        k = K(j);
        [u, ~] = function_code(xi, m, k, E, dt, wn);
        A(j) = max(abs(u .* wn)); % Convert displacement to acceleration
    end
    
    % Plotting for Spectral Acceleration
    plot(T, A, 'LineWidth', 2, 'DisplayName', ['\xi = ', num2str(xi)]);
    hold on;
end
xlabel('Time period (s)');
ylabel('Spectral Acceleration (A, in/s^2)');
title('Response Spectrum for Spectral Acceleration');
legend('Location', 'best');