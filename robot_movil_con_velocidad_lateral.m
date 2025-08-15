clear
clc

ts=0.1;
t=0:ts:200; % vector tiempo (cantidad de pasos)

uf=0.2*ones(1,length(t));
ul=0.4*ones(1,length(t));
w=0.01*ones(1,length(t));

% condiciones iniciales
xr(1)=0;
yr(1)=0;
phi(1)=0;

% creación de la ruta

for k=1:length(t)
   
   xrp(k)=uf(k)*cos(phi(k))-ul(k)*sin(phi(k));
   yrp(k)=uf(k)*sin(phi(k))+ul(k)*cos(phi(k));
   
   xr(k+1)=xr(k)+ts*xrp(k);
   yr(k+1)=yr(k)+ts*yrp(k);
   phi(k+1)=phi(k)+ts*w(k);
   
end

% simulación

pasos=5;
fig=figure;
set(fig,'position',[10 60 980 600]);
axis square;
cameratoolbar
axis([-8 10 -6 6 0 1]);
grid on;
hold on;
plot(xr,yr);

for i=1:pasos:length(t)
    
    if i ~= 1
      delete(G);
    end
    
    pcx=xr(i); % posición central x
    pcy=yr(i); % posición central y
    
    psq1x=pcx-sqrt(2)/2*cos(pi/4+phi(i)); % coordenada x de la esquina 1 
    psq1y=pcy-sqrt(2)/2*sin(pi/4+phi(i));
    
    psq2x=pcx+sqrt(2)/2*cos(pi/4-phi(i));
    psq2y=pcy-sqrt(2)/2*sin(pi/4-phi(i));
    
    psq3x=pcx-sqrt(2)/2*cos(pi/4-phi(i));
    psq3y=pcy+sqrt(2)/2*sin(pi/4-phi(i));
    
    psq4x=pcx+sqrt(2)/2*cos(pi/4+phi(i));
    psq4y=pcy+sqrt(2)/2*sin(pi/4+phi(i));
    
    coord_3=[psq3x psq3y 0];
    coord_4=[psq4x psq4y 0];
    coord_2=[psq2x psq2y 0];
    coord_1=[psq1x psq1y 0];
    coord_7=[psq3x psq3y 1];
    coord_8=[psq4x psq4y 1];
    coord_6=[psq2x psq2y 1];
    coord_5=[psq1x psq1y 1];
    
    coord=[coord_1;coord_2;coord_3;coord_4;coord_5;coord_6;coord_7;coord_8];
      
    for k = 1:length(coord)/8   % dibujar el robot (cubo)

      X = coord(8*(k-1)+1:8*(k-1)+8,1);
      Y = coord(8*(k-1)+1:8*(k-1)+8,2);
      Z = coord(8*(k-1)+1:8*(k-1)+8,3);

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
