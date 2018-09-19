function transResistividad( csv )
dataset = load(csv);
  [filas, columnas] = size(dataset);
  r = dataset(filas+1:end);
  
  %fmuestreo = 1; %frecuencia de muestreo = duración de la señal
  %periodo = 1 / fmuestreo;
  nuevaLongitud = 2^nextpow2(filas);
  %nueva longitud de la señal
  %para un mejor funcionamiento de fft(), debe ser una potencia de 2
  dt = 1; %delta t
  t = (0:nuevaLongitud-1)*dt; %vector tiempo
  dw = 2*pi/(nuevaLongitud*dt); %delta omega
  w = (0:nuevaLongitud-1)*dw; %vector de omega
  
  %obteniendo el espectro de amplitudes de resistividad
  TFR = fft(r, nuevaLongitud);
  bilateral = abs(TFR/nuevaLongitud);
  
  %obteniendo el espectro de fases de resistividad
  fases = angle(TFR);
  
  subplot(2, 1, 1);
    stem(w, bilateral, 'r', 'filled');
    title('Espectro de amplitudes', 'Color', [1 1 1]);
    set(gca, 'XColor', [1 1 1]);
    set(gca, 'YColor', [1 1 1]);
    set(gca, 'GridColor', [0 0 0]);
    set(gca, 'FontWeight', 'bold');
    set(gca, 'FontSize', 16);
    xlabel('Frecuencia ( \omega )');
    ylabel('Amplitud');
    xlim([0 w(end)]);
    grid on;
    
  subplot(2, 1, 2);
    stem(w, fases, 'r', 'filled');
    title('Espectro de fases', 'Color', [1 1 1]);
    set(gca, 'XColor', [1 1 1]);
    set(gca, 'YColor', [1 1 1]);
    set(gca, 'GridColor', [0 0 0]);
    set(gca, 'FontWeight', 'bold');
    set(gca, 'FontSize', 16);
    xlabel('Frecuencia ( \omega )');
    ylabel('\pi');
    xlim([0 w(end)]);
    grid on;
end

