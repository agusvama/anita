function [ nombreArchivo ] = crearArchivo(  )
  %abre un cuadro de diálogo y usuario selecciona ruta para guardar su PDF
  [file, path] = uiputfile('*.csv', 'Guardar datos como...');
  %uiputfile te devuelve 2 variables
  % file es el nombre del archivo
  % path es donde se va guardar
  if(file == 0) %se hizo clic en cancelar
    nombreArchivo = ''; %asignado para controlar el flujo de newButon_Callback
  else
    nombreArchivo = strcat(path, file);
  end
end

