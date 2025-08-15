clear
clc

ts=0.1;
t=0:ts:20;
N=length(t);

% Condiciones iniciales
x1(1)=5;
y1(1)=4;
phi(1)=0;

% Referencias deseadas
hxd = 0;
hyd = -3;

a=0.2;

hx(1)=x1(1)+a*cos(phi(1));
hy(1)=y1(1)+a*sin(phi(1));

for k=1:N
% Control
    
    % Errores de control
    hxe(k) = hxd - hx(k);
    hye(k) = hyd - hy(k);
    
    he = [hxe(k); hye(k)];
    
    % Matriz Jacobiana
    J=[cos(phi(k)) -a*sin(phi(k)); 
        sin(phi(k)) a*cos(phi(k))];
    
    % Matriz de ganancia
    K = [0.2 0;
        0 0.2];
    
    % Ley de control
    qpRef = pinv(J)*K*he;
    
    u(k)=qpRef(1); % Velocidad lineal de entrada al robot 
    w(k)=qpRef(2); % Velocidad angular de entrada al robot
    
    % Aplicar acciones de control al robot 
   
    phi(k+1)=phi(k)+ts*w(k);
    
    x1p(k)=u(k)*cos(phi(k+1));
    y1p(k)=u(k)*sin(phi(k+1));

    x1(k+1)=x1(k)+ts*x1p(k);
    y1(k+1)=y1(k)+ts*y1p(k);
    
    hx(k+1)=x1(k+1)+a*cos(phi(k+1));
    hy(k+1)=y1(k+1)+a*sin(phi(k+1));
    
end

scene=figure;
set(scene,'Color','white');
set(gca,'FontWeight','bold');
sizeScreen=get(0,'ScreenSize');
set(scene,'position',sizeScreen);
camlight('headlight');
axis equal;
grid on;
box on;
xlabel('x(m)'); ylabel('y(m)'); zlabel('z(m)');

view([135 35]);
axis([-3 3 -3 3 0 2]);

scale = 4;

hold on;
H2=plot3(hx(1),hy(1),0,'r','lineWidth',2); % posición inicial
H3=plot3(hxd,hyd,0,'gO','lineWidth',2); % punto de referencia
H4=plot3(hx(1),hy(1),0,'rO','lineWidth',2);
plot(hx,hy);

for i=1:N
    
    if i ~= 1
      delete(G);
    end
    
    pcx=x1(i); % posición central x
    pcy=y1(i); % posición central y
    
    psq1x=pcx-0.4*sqrt(2)/2*cos(pi/4+phi(i)); % coordenada x de la esquina 1 
    psq1y=pcy-0.4*sqrt(2)/2*sin(pi/4+phi(i));
    
    psq2x=pcx+0.4*sqrt(2)/2*cos(pi/4-phi(i));
    psq2y=pcy-0.4*sqrt(2)/2*sin(pi/4-phi(i));
    
    psq3x=pcx-0.4*sqrt(2)/2*cos(pi/4-phi(i));
    psq3y=pcy+0.4*sqrt(2)/2*sin(pi/4-phi(i));
    
    psq4x=pcx+0.4*sqrt(2)/2*cos(pi/4+phi(i));
    psq4y=pcy+0.4*sqrt(2)/2*sin(pi/4+phi(i));
    
    coord_3=[psq3x psq3y 0];
    coord_4=[psq4x psq4y 0];
    coord_2=[psq2x psq2y 0];
    coord_1=[psq1x psq1y 0];
    coord_7=[psq3x psq3y .1];
    coord_8=[psq4x psq4y .1];
    coord_6=[psq2x psq2y .1];
    coord_5=[psq1x psq1y .1];
    
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

