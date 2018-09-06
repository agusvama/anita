function transPotencial( csv )
  dataset = load(csv);
  [filas, columnas] = size(dataset);
  v = dataset(1:filas);
  
  fmuestreo = filas; %frecuencia de muestreo = duración de la señal
  periodo = 1 / fmuestreo;
  nuevaLongitud = 2^nextpow2(filas);
  %nueva longitud de la señal
  %para un mejor funcionamiento de fft(), debe ser una potencia de 2
  
  %obteniendo el espectro de amplitudes del potencial natural
  tfVoltaje = fft(v);
  realesVoltaje = abs(tfVoltaje/nuevaLongitud);
  espectroAmplitudVoltaje = realesVoltaje(1:nuevaLongitud/2 +1);
  
  %obteniendo el espectro de frecuencias del potencial natural
  tfVoltajeFrecuencias = fft(v, nuevaLongitud);
  realesVoltajeFrecuencias = abs(tfVoltajeFrecuencias / nuevaLongitud);
  espectroFrecuenciasVoltaje = realesVoltajeFrecuencias(1:nuevaLongitud/2 +1);
  
  subplot(2, 1, 1);
    stem(espectroAmplitudVoltaje, 'filled');
    set(gca, 'XColor', [1 1 1]);
    set(gca, 'YColor', [1 1 1]);
    set(gca, 'GridColor', [0 0 0]);
    xlabel('Espectro de amplitudes');
    xlim([0 nuevaLongitud]);
    grid on;
    
  subplot(2, 1, 2);
    stem(espectroFrecuenciasVoltaje, 'filled');
    set(gca, 'XColor', [1 1 1]);
    set(gca, 'YColor', [1 1 1]);
    set(gca, 'GridColor', [0 0 0]);
    xlabel('Espectro de frecuencias');
    xlim([0 nuevaLongitud]);
    grid on;
end

