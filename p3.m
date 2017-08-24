% p3.m - band-limited interpolation
h = 1; xmax = 10; clf
x = -xmax:h:xmax;
% computational grid
xx = -xmax-h/20:h/10:xmax+h/20;
% plotting grid
for plt = 1:3
subplot(3,1,plt)
switch plt
case 1, v = (x==0);
% delta function
case 2, v = (abs(x)<=3);
% square wave
case 3, v = max(0,1-abs(x)/3);
% hat function
end
plot(x,v,'.','markersize',14), grid on
p = zeros(size(xx));
for i = 1:length(x),
p = p + v(i)*sin(pi*(xx-x(i))/h)./(pi*(xx-x(i))/h);
end
line(xx,p,'linewidth',.7), axis([-xmax xmax -.5 1.5])
set(gca,'xtick',[]), set(gca,'ytick',[0 1])
end

%Excercise 2.7, completed
hold off
figure
Nvec = 2.^(3:6);
%Nvec = 2.^(3);
error = zeros(size(Nvec));
for plt = 2:3
  subplot(2,1,plt-1)
  meshindex = 0;
  for N = Nvec
  meshindex = meshindex + 1;
  h = 2.0 * xmax / N;
  x = -xmax:h:xmax;
  xx = -xmax-h/2:h:xmax+h/2;
  switch plt
  case 2, 
    v = (abs(x)<=3);
    vtocmp = (abs(xx) <=3 ); 
  % square wave
  case 3,
    v = max(0,1-abs(x)/3);
    vtocmp = max(0,1-abs(xx)/3); 
  % hat function
  end
  p = zeros(size(xx));
  for i = 1:length(x),
  p = p + v(i)*sin(pi*(xx-x(i))/h)./(pi*(xx-x(i))/h);
  end
  error(meshindex) = norm (vtocmp - p, inf);
  end
  %figure
  loglog(Nvec,error,'.','markersize',15);
  hold on
  grid on, xlabel Nvec, ylabel error
  title('Convergence of bandwidth limited interpolant')
  semilogy(Nvec,Nvec.^(-1),'-.')
  %hold off
end
