% p26.m - eigenvalues of 2nd-order Chebyshev diff. matrix
N = 60; [D,x] = cheb(N); D2 = D^2; D2 = D2(2:N,2:N);
[V,Lam] = eig(D2);
[foo,ii] = sort(-diag(Lam)); e = diag(Lam(ii,ii)); V = V(:,ii);
% Plot eigenvalues:
clf, subplot('position',[.1 .62 .8 .3])
loglog(-e,'.','markersize',10), ylabel eigenvalue
title(['N = ' int2str(N) ...
'max |\lambda| = ' num2str(max(-e)/N^4) 'N^4'])
hold on, semilogy(2*N/pi*[1 1],[1 1e6],'--r')
text(2.1*N/pi,24,'2\pi / N','fontsize',12)
% Plot eigenmodes N/4 (physical) and N (nonphysical):
vN4 = [0; V(:,N/4-1); 0];
xx = -1:.01:1; vv = polyval(polyfit(x,vN4,N),xx);
subplot('position',[.1 .36 .8 .15]), plot(xx,vv), hold on
plot(x,vN4,'.','markersize',9), title('eigenmode N/4')
vN = [0; V(:,N-1); 0];
subplot('position',[.1 .1 .8 .15])
semilogy(x,abs(vN)), axis([-1 1 -1 1]), hold on
plot(x,vN,'.','markersize',9)
title('modulus of eigenmode N(log scale)')