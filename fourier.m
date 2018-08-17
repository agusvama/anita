function fourier(csv)
  dataset = load(csv);
  [filas, columnas] = size(dataset);
  v = dataset(1:filas);
  r = dataset(filas+1:end);
  figure('Toolbar', 'none', 'Menubar', 'none', 'Name', 'Análisis de Fourier', 'Tag', 'plotsFourier');
  
  fmuestreo = filas; %frecuencia de muestreo = duración de la señal
  periodo = 1 / fmuestreo;
  longitud = filas; %es el tiempo que dura la señal
  fdominio = fmuestreo*(0: (longitud / 2)) / longitud;
  nuevaLongitud = 2^nextpow2(longitud);
  %nueva longitud de la señal para uso del espectro de frecuencias
  
  %obteniendo el espectro de frecuencias del potencial natural
  tfVoltaje = fft(v);
  realesVoltaje = abs(tfVoltaje/longitud);
  espectroAmplitudVoltaje = realesVoltaje(1:longitud/2 +1);
  
  %obteniendo el espectro de frecuencias del potencial natural
  tfVoltajeFrecuencias = fft(v, nuevaLongitud);
  realesVoltajeFrecuencias = abs(tfVoltajeFrecuencias / nuevaLongitud);
  espectroFrecuenciasVoltaje = realesVoltajeFrecuencias(1:nuevaLongitud/2 +1);
  
  %obteniendo el espectro de amplitudes de resistividad
  tfResistiva = fft(r);
  realesResistivos = abs(tfResistiva/longitud);
  espectroAmplitudResistivo = realesResistivos(1:longitud/2 +1);
  
  %obteniendo el espectro de frecuencias de resistividad
  tfResistivaFrecuencias = fft(r, nuevaLongitud);
  realesResistivosFrecuencia = abs(tfResistivaFrecuencias / nuevaLongitud);
  espectroFrecuenciasResistivo = realesResistivosFrecuencia(1:nuevaLongitud/2 +1);
  
  %now we plot :sunglasses:
  subplot(4, 2, [1, 2]);
    plot(v);
    xlabel('Potencial Natural');
    grid on;
    grid minor;
    
  subplot(4, 2, 3);
    plot(espectroAmplitudVoltaje);
    xlabel('Espectro de amplitudes');
    grid on;
    grid minor;
    
  subplot(4, 2, 4);
    plot(espectroFrecuenciasVoltaje);
    xlabel('Espectro de frecuencias');
    grid on;
    grid minor;
  subplot(4, 2, [5, 6]);
    plot(r, 'r');
    xlabel('Resistividad');
    grid on;
    grid minor;
  subplot(4, 2, 7);
    plot(espectroAmplitudResistivo, 'r');
    xlabel('Espectro de amplitudes');
    grid on;
    grid minor;
  subplot(4, 2, 8);
    plot(espectroFrecuenciasResistivo, 'r');
    xlabel('Espectro de frecuencias');
    grid on;
    grid minor;
end

