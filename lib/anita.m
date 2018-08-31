function [sensorIzq, sensorDer] = anita(p)
  lectura = fscanf(p, '%f');
  sensorIzq = lectura(1);
  sensorDer = lectura(2);
end