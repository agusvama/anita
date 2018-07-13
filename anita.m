delete(instrfind({'Port'},{'COM3'}));
delete(instrfind({'Port'},{'COM4'}));
arduino1 = serial('COM3');
arduino2 = serial('COM4');
fopen(arduino1);
fopen(arduino2);

%desechar primera lectura que viene con basura
fscanf(arduino1);
fscanf(arduino2);

try
  close('Gráficas'); %cierra la figura para no crear más y más con el mismo tags
catch
end
figure('Toolbar', 'none', 'Menubar', 'none', 'Name', 'Gráficas', 'Tag', 'plotsFigure');

readings = 10;
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
        five(indexFive) = fscanf(arduino1, '%d');
        indexFive = indexFive + 1;
        
        %lectura de 3V
        three(indexThree) = fscanf(arduino2, '%d');
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
fclose(arduino1);
fclose(arduino2);
clear;