function transPotencial( csv )
  dataset = load(csv);
  [filas, columnas] = size(dataset);
  v = dataset(1:filas);
  
  %fmuestreo = 1; 
  %frecuencia de muestreo = muestras por segundo tomadas de una señal
  %continua para volverla discreta
  %periodo = 1 / fmuestreo;
  nuevaLongitud = 2^nextpow2(filas);
  if(filas == 0)
    nuevaLongitud = 2;
  end
  %nueva longitud de la señal
  %para un mejor funcionamiento de fft(), debe ser una potencia de 2
  dt = 1; %delta t
  t = (0:nuevaLongitud-1)*dt; %vector tiempo
  dw = 2*pi/(nuevaLongitud*dt); %delta omega
  w = (0:nuevaLongitud-1)*dw; %vector de omega
  
  %obteniendo el espectro de amplitudes del potencial natural
  TFV = fft(v, nuevaLongitud);
  bilateral = abs(TFV/nuevaLongitud); %espectro de amplitudes
  
  %obteniendo el espectro de fases del potencial natural
  fases = angle(TFV); %espectro de fases
  
  subplot(2, 1, 1);
    stem(w, bilateral, 'filled');
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
    stem(w, fases, 'filled');
    title('Espectro de fases', 'Color', [1 1 1]);
    set(gca, 'XColor', [1 1 1]);
    set(gca, 'YColor', [1 1 1]);
    set(gca, 'GridColor', [0 0 0]);
    xlabel('Frecuencia ( \omega )');
    ylabel('\pi');
    set(gca, 'FontSize', 16);
    set(gca, 'FontWeight', 'bold');
    xlim([0 w(end)]);
    grid on;
end

