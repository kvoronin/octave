% p6.m - variable coefficient wave equation
% Grid, variable coefficient, and initial data:

N = 256; h = 2*pi/N; x = h*(1:N); t = 0; dt = h/4;
c = .2 + sin(x-1).^2;
v = exp(-100*(x-1).^2); vold = exp(-100*(x-.2*dt-1).^2);
% Time-stepping by leap frog formula:
tmax = 8; tplot = .15; clf, drawnow
plotgap = round(tplot/dt); dt = tplot/plotgap;
nplots = round(tmax/tplot);
data = [v; zeros(nplots,N)]; tdata = t;
for i = 1:nplots
for n = 1:plotgap
t = t+dt;
v_hat = fft(v);
w_hat = 1i*[0:N/2-1 0 -N/2+1:-1] .* v_hat;
w = real(ifft(w_hat));
%whos;
%pause()
vnew = vold - 2*dt*c.*w; vold = v; v = vnew;
end
data(i+1,:) = v; tdata = [tdata; t];
end
waterfall(x,tdata,data), view(10,70), colormap([0 0 0])
%whos;
axis([0 2*pi 0 tmax 0 5]), ylabel t, zlabel u, grid off


% Excercise 3.8: same problem solved by FD, not completed

figure
N = 256; h = 2*pi/N; x = h*(1:N); t = 0; dt = h/4;
c = .2 + sin(x-1).^2;
v = exp(-100*(x-1).^2); vold = exp(-100*(x-.2*dt-1).^2);
% Time-stepping by leap frog formula:
tmax = 8; tplot = .15; clf, drawnow
plotgap = round(tplot/dt); dt = tplot/plotgap;
nplots = round(tmax/tplot);
data = [v; zeros(nplots,N)]; tdata = t;
for i = 1:nplots
for n = 1:plotgap
t = t+dt;
%v_hat = fft(v);
%w_hat = 1i*[0:N/2-1 0 -N/2+1:-1] .* v_hat;
%w = real(ifft(w_hat));
%w'
%v'

w = zeros(1,N);
for j = 1 : N
  %i
  %mod(i+1,N)
  %mod(i-1,N)
  %1.0/h
  w(j) = (v(mod(j+1,N) + 1) - v(mod(j-1,N) + 1) )* (2.0/h);
end

%w'
vnew = vold - 2*dt*c.*w; vold = v; v = vnew;
end
data(i+1,:) = v; tdata = [tdata; t];
end
%whos;
%pause();
waterfall(x,tdata,data), view(10,70), colormap([0 0 0])
axis([0 2*pi 0 tmax 0 5]), ylabel t, zlabel u, grid off
