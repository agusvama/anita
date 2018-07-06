function anita(muestras)
try
  a = arduino;
catch
  warndlg('Arduino no conectado, conecte e intente de nuevo por favor :)');
  return;
end

try
  close('Gráficas'); %cierra la figura para no crear más y más con el mismo tags
catch
end
figure('Toolbar', 'none', 'Menubar', 'none', 'Name', 'Gráficas', 'Tag', 'plotsFigure');

readings = muestras;
five = zeros(1, readings);
three = zeros(1, readings);
indexFive = 1;
indexThree = 1;

%depth = linspace(0, p);

i = 1;
while i < 2
    
    for index = 1:readings
       
        dibuja(five, three);
        
        %lectura de 5V
        five(indexFive) = readVoltage(a, 'A0');
        indexFive = indexFive + 1;
        
        %lectura de 3V
        three(indexThree) = readVoltage(a, 'A1');
        indexThree = indexThree + 1;

        pause(.1); %permite dar tiempo a que se dibuje la gráfica
        
        if(indexFive == 101)
            indexFive = 1;
        end
        if(indexThree == 101)
            indexThree = 1;
        end
    end
    %dibuja(five, three, depth);
    i = i + 1;
end
dibuja(five, three);

clear;
end