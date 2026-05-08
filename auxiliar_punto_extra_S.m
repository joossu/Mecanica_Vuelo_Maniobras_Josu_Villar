% DEMOSTRACIÓN: VARIACIÓN DEL EMPUJE CON LA VELOCIDAD (Punto Extra)

% Definimos un rango de velocidades
V = 30:1:340; 

% En un turborreactor nos da igual la velocidad, el C-101EB siempre da unos 15800 N
T_reactor = 15800 * ones(size(V)); 

% En un motor alternativo + hélice usamos una velocidad inventada (sabemos
% que a bajas velocidades da mas empuje). Vamos a suponer que a 50 m/s dan
% el mismo empuje. Así podemos calcular qué potencia constante tendría la hélice.
V_ref = 50; 
P_constante = 15800 * V_ref; 

% Calculamos la fuerza de la hélice 
T_helice = P_constante ./ V; 

% Dibujamos las graficas
figure('Name', 'Comparativa Propulsiva (S)', 'Color', 'w');
plot(V, T_reactor, 'b-', 'LineWidth', 2); hold on;
plot(V, T_helice, 'r--', 'LineWidth', 2);

% Marcamos la velocidad del modelo (la de 140 m/s)
xline(140, 'k:', 'LineWidth', 1.5);
plot(140, 15800, 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
plot(140, P_constante/140, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

grid on;
title('Variación del Empuje Disponible con la Velocidad');
xlabel('Velocidad de vuelo, V (m/s)');
ylabel('Empuje Disponible, T (N)');
legend('Turborreactor (T \approx Constante)', 'Hélice (P = Constante)', 'Velocidad del Ensayo (140 m/s)');

fprintf('\n--- RESULTADOS A LA VELOCIDAD DE ENSAYO (140 m/s) ---\n');
fprintf('Empuje Turborreactor: %.0f N\n', 15800);
fprintf('Empuje Hélice:        %.0f N\n', P_constante / 140);
fprintf('-----------------------------------------------------\n');
fprintf('CONCLUSIÓN: La hélice pierde %.0f N de fuerza respecto al reactor.\n\n', 15800 - (P_constante/140));