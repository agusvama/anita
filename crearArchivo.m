function [ nombreArchivo ] = crearArchivo( fecha )
  %abre un cuadro de diálogo y usuario selecciona ruta para guardar su PDF
  [file, path] = uiputfile('*.csv', 'Guardar datos como...');
  %uiputfile te devuelve 2 variables
  % file es el nombre del archivo
  % path es donde se va guardar
  if(~file)
    warndlg('introduzca un nombre de archivo')
    return;
  end
    nombreArchivo = strcat(path, file,        '_', ...
                           int2str(fecha(1)), '-', ... %año
                           int2str(fecha(2)), '-', ... %mes
                           int2str(fecha(3)), '@', ... %dia
                           int2str(fecha(4)),  '_', ... %hora
                           int2str(fecha(5)), '_', ... %minuto
                           int2str(fecha(6)),      ... %segundo
                           '.csv'                  ... %formato
          );
end

