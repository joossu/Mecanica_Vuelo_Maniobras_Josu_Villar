
% ANÁLISIS PARAMÉTRICO DE LA VELOCIDAD EN MANIOBRA "S" VERTICAL

% Definimos los datos del problema
W = 32000;      % Peso [N]
S = 20;         % Superficie alar [m^2]
rho = 1.225;    % Densidad del aire a nivel del mar [kg/m^3]
g = 9.81;       % Gravedad [m/s^2]
CD0 = 0.03;     % Resistencia parásita
k = 0.06;       % Factor de resistencia inducida

% Definimos los limites operativos
n_max = 7.5;    % Factor de carga máximo [g]
n_min = -3.9;   % Factor de carga mínimo [g]
CL_max = 1.4;   % Coeficiente de sustentación máximo
CL_min = -0.8;  % Coeficiente de sustentación mínimo
T_max = 15800;  % Empuje máximo disponible del motor [N]

% Definimos los datos de la maniobra
R = 500;              % Radio constante de la curva [m]
vector_V = 80:5:160;  % Barrido de velocidades (de 80 a 160 m/s)

% Definimos los angulos en radianes
phi = linspace(0, 2*pi, 1000);

% Definimos la variable auxiliar de curvatura (+1 para semicírculo AB, -1 para BC)
curv = ones(size(phi));
curv(phi >= pi) = -1;

fprintf('\n================ BARRIDO DE VELOCIDADES con R = 500 m fijado ================\n');
fprintf('V[m/s] \t n en B+[g] \t CL_max \t T_max[N] \t Válido Estr/Aero? \t Válido Motor?\n');
fprintf('------------------------------------------------------------------------------------\n');

% Realizamos el bucle para calcular las fuerzas en cada velocidad
for i = 1:length(vector_V)
    V = vector_V(i);
    
    % Factor de carga
    n = curv .* (V^2 / (g * R)) + cos(phi);
    
    % Coeficiente de sustentacion
    CL = (W / (0.5 * rho * V^2 * S)) .* n;

    % Resistencia aerodinámica
    D = 0.5 * rho * V^2 * S .* (CD0 + k .* CL.^2);
    
    % Escogemos los valores críticos
    n_B_plus = min(n);       % Factor de carga más negativo (en B+)
    CL_max_req = max(CL);    % CL más alto requerido (en A)
    T_max_req = max(D) + W;
    
    % Comprobamos si superan los límites
    ok_estructura = (n_B_plus >= n_min);
    ok_aerodinamica = (CL_max_req <= CL_max);
    ok_motor = (T_max_req <= T_max);
    
    % Preparamos las salidas para la tabla
    if ok_estructura && ok_aerodinamica
        viable_est_aero = 'SI';
    else
        viable_est_aero = 'NO';
    end
    
    if ok_motor
        viable_motor = 'SI';
    else
        viable_motor = 'NO';
    end
    
    % Imprimos cada flia
    fprintf('%d \t\t %5.2f \t\t %5.2f \t\t %5.0f \t\t\t %s \t\t\t\t %s\n', ...
        V, n_B_plus, CL_max_req, T_max_req, viable_est_aero, viable_motor);
end
fprintf('====================================================================================\n\n');