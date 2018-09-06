function transResistividad( csv )
dataset = load(csv);
  [filas, columnas] = size(dataset);
  r = dataset(filas+1:end);
  
  fmuestreo = filas; %frecuencia de muestreo = duración de la señal
  periodo = 1 / fmuestreo;
  nuevaLongitud = 2^nextpow2(filas);
  %nueva longitud de la señal
  %para un mejor funcionamiento de fft(), debe ser una potencia de 2
  
  %obteniendo el espectro de amplitudes de resistividad
  tfResistiva = fft(r);
  realesResistivos = abs(tfResistiva/nuevaLongitud);
  espectroAmplitudResistivo = realesResistivos(1:nuevaLongitud/2 +1);
  
  %obteniendo el espectro de frecuencias de resistividad
  tfResistivaFrecuencias = fft(r, nuevaLongitud);
  realesResistivosFrecuencia = abs(tfResistivaFrecuencias / nuevaLongitud);
  espectroFrecuenciasResistivo = realesResistivosFrecuencia(1:nuevaLongitud/2 +1);
  
  subplot(2, 1, 1);
    stem(espectroAmplitudResistivo, 'r', 'filled');
    set(gca, 'XColor', [1 1 1]);
    set(gca, 'YColor', [1 1 1]);
    set(gca, 'GridColor', [0 0 0]);
    xlabel('Espectro de amplitudes');
    xlim([0 nuevaLongitud]);
    grid on;
    
  subplot(2, 1, 2);
    stem(espectroFrecuenciasResistivo, 'r', 'filled');
    set(gca, 'XColor', [1 1 1]);
    set(gca, 'YColor', [1 1 1]);
    set(gca, 'GridColor', [0 0 0]);
    xlabel('Espectro de frecuencias');
    xlim([0 nuevaLongitud]);
    grid on;
end

