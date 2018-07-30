function [placa] = iniciarArduino (port)
  delete(instrfind({'Port'},{port}));
  placa = serial(port);
  fopen(placa);
end