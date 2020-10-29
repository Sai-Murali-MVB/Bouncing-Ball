% Trajectory
clc
clear all
close all %to close all the windows
% Split u into components ux and uy
clearvars; % Clear all variables in the workspace
e = 0.9;   % coefficient of restitution
ux = 1;    % m/s
uy = 10/e; % m/s
g = 9.81;  % m/s^2
x(1) = 0;  % Initializing the vector x
y(1) = 0;  % Initializing the vector x
while uy > 0.01
    xref = x(end);
    uy = uy * e;%coefficient of restitution is given by ratio of velocity of seperation and approach 
    tf = 2.0 * uy / g; % time of flight back to the ground using v = u + at
    dt = tf / 10;      % time increment, taking 20 steps
    t = 0;
% Loop as long as t < tf
    while t < tf
        t = t + dt;
        if((uy - 0.5 * g * t) * t > -0.000001)%negative velocity implies under the ground but physically we can visualize till v=0
            x(end + 1) = ux * t + xref;%x axis position after every collision
            y(end + 1) = (uy - 0.5 * g * t) * t;%height to which the ball hass bounced after the collision
            if(y(end) < 0) y(end) = 0; end
        end
    end
end
figure(1)
plot(x,y)
title('TRAJECTORY');
xlabel('INDEX OF COLLISION');
ylabel('HEIGHT');
% Qunatization
n1=2;
L=2^n1;
xmax=4.5;
xmin=0.5;
del=(xmax-xmin)/L;%step size
partition=xmin:del:xmax;			% definition of decision lines
codebook=xmin-(del/2):del:xmax+(del/2);    % definition of representation levels
[index,quants]=quantiz(y,partition,codebook); 	
% gives rounded off values of the samples
figure(2)
subplot(2,1,1)
stem(x,y)
title('SAMPLED SIGNAL');
xlabel('INDEX OF COLLISION');
ylabel('HEIGHT');
subplot(2,1,2)
stem(x,quants);
title('QUANTIZED SIGNAL');
xlabel('INDEX OF COLLISION');
ylabel('HEIGHT');
