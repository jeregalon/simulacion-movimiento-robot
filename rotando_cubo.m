function rotando_cubo(angx, angy, angz, sucesion)
        
    num_frames = 300;
    
    rx = angx / 100;
    ry = angy / 100;
    rz = angz / 100;
    
    % coordenadas iniciales:
    %
    %    7-------8
    %   /|      /|
    %  / |     / |
    % 5--|----6  |
    % |  3----|--4
    % | /     | /
    % 1-------2

    esquinas = [-0.5, 0.5, 0.5; % esquina 1
            -0.5, -0.5, 0.5;    % esquina 2
            -0.5, 0.5, -0.5;    % esquina 3
            -0.5, -0.5, -0.5;   % esquina 4
            0.5, 0.5, 0.5;      % esquina 5
            0.5, -0.5, 0.5;     % esquina 6
            0.5, 0.5, -0.5;     % esquina 7
            0.5, -0.5, -0.5];   % esquina 8
    
    figure()
    
    for frame = 1:num_frames
        
        if frame ~= 1
            delete(G);
        end
        
    % matrices de rotación
        
        if frame < 100

            if sucesion(1) == 'X'
                
                matx = [1 0 0; 0 cos(rx) -sin(rx); 0 sin(rx) cos(rx)];

                for i=1:length(esquinas)
                    esquinas(i,:) = esquinas(i,:) * matx;
                end

            elseif sucesion(1) == 'Y'
                
                maty = [cos(ry) 0 sin(ry); 0 1 0; -sin(ry) 0 cos(ry)];

                for i=1:length(esquinas)
                    esquinas(i,:) = esquinas(i,:) * maty;
                end
            
            elseif sucesion(1) == 'Z'
                
                matz = [cos(rz) -sin(rz) 0; sin(rz) cos(rz) 0; 0 0 1];

                for i=1:length(esquinas)
                    esquinas(i,:) = esquinas(i,:) * matz;
                end

            else
                break;
            end
           
        elseif frame >= 100 && frame < 200

            if sucesion(2) == 'X'
                
                matx = [1 0 0; 0 cos(rx) -sin(rx); 0 sin(rx) cos(rx)];

                for i=1:length(esquinas)
                    esquinas(i,:) = esquinas(i,:) * matx;
                end

            elseif sucesion(2) == 'Y'
                
                maty = [cos(ry) 0 sin(ry); 0 1 0; -sin(ry) 0 cos(ry)];

                for i=1:length(esquinas)
                    esquinas(i,:) = esquinas(i,:) * maty;
                end
            
            elseif sucesion(2) == 'Z'
                
                matz = [cos(rz) -sin(rz) 0; sin(rz) cos(rz) 0; 0 0 1];

                for i=1:length(esquinas)
                    esquinas(i,:) = esquinas(i,:) * matz;
                end

            else
                break;
            end

        elseif frame >= 200 && frame < 300
            
            if sucesion(3) == 'X'
                
                matx = [1 0 0; 0 cos(rx) -sin(rx); 0 sin(rx) cos(rx)];

                for i=1:length(esquinas)
                    esquinas(i,:) = esquinas(i,:) * matx;
                end

            elseif sucesion(3) == 'Y'
                
                maty = [cos(ry) 0 sin(ry); 0 1 0; -sin(ry) 0 cos(ry)];

                for i=1:length(esquinas)
                    esquinas(i,:) = esquinas(i,:) * maty;
                end
            
            elseif sucesion(3) == 'Z'
                
                matz = [cos(rz) -sin(rz) 0; sin(rz) cos(rz) 0; 0 0 1];

                for i=1:length(esquinas)
                    esquinas(i,:) = esquinas(i,:) * matz;
                end

            else
                break;
            end
            
        end

    % dibujar el cubo
        
        for k = 1:length(esquinas)/8   

            X = esquinas(8*(k-1)+1:8*(k-1)+8,1);
            Y = esquinas(8*(k-1)+1:8*(k-1)+8,2);
            Z = esquinas(8*(k-1)+1:8*(k-1)+8,3);

            % Los puntos de cada cara se ordenan según el sentido antihorario
            caras = [1 2 4 3; 5 6 8 7; 1 3 7 5; 2 4 8 6; 1 2 6 5; 3 4 8 7];

            % size(X) = [4 6]
            % - cada columna hace referencia a los puntos de un plano
            % - hay 4 elementos en cada columna que se refieren a las coordenadas x de
            % cada punto del plano

            X = [X(caras(1,:)) X(caras(2,:)) X(caras(3,:)) X(caras(4,:)) X(caras(5,:)) X(caras(6,:))];
            Y = [Y(caras(1,:)) Y(caras(2,:)) Y(caras(3,:)) Y(caras(4,:)) Y(caras(5,:)) Y(caras(6,:))];
            Z = [Z(caras(1,:)) Z(caras(2,:)) Z(caras(3,:)) Z(caras(4,:)) Z(caras(5,:)) Z(caras(6,:))];

            alpha = 0.6; % transparencia de la cara
            colour ='blue'; % color de la cara

            G=fill3(X,Y,Z,colour,'FaceAlpha',alpha); % dibujar los cubos
            axis equal

            hold on
        end
        pause(0.01);
    end

end