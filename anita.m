a = arduino;

readings = 4;
five = zeros(1, readings);
three = zeros(1, readings);
indexFive = 1;
indexThree = 1;

i = 1;
while i < 2
    
    for index = 1:readings
       
        dibuja(five, three);
        
        %first, conmute the relay
        writePWMVoltage(a, 'D9', 5);
        five(indexFive) = readVoltage(a, 'A1');
        indexFive = indexFive + 1;
        pause(1);
        
        %conmute the relay again and perform the second read
        writePWMVoltage(a, 'D9', 0);
        three(indexThree) = readVoltage(a, 'A0');
        indexThree = indexThree + 1;
        pause(1);

        pause(.1); %permite visualizar la grafica cada n segundos
        
        if(indexFive == 101)
            indexFive = 1;
        end
        if(indexThree == 101)
            indexThree = 1;
        end
    end
    dibuja(five, three);
    i = i + 1;
end
clear;