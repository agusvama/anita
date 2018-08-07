function [ nombreArchivo ] = crearArchivo( fecha )
  nombreArchivo = ...
  strcat('projects/', int2str(fecha(1)), '-', ... %año
                      int2str(fecha(2)), '-', ... %mes
                      int2str(fecha(3)), '@', ... %dia
                      int2str(fecha(4)), '_', ... %hora
                      int2str(fecha(5)), '_', ... %minuto
                      int2str(fecha(6)),      ... %segundo
                      '.csv'                  ... %formato
        );
end

