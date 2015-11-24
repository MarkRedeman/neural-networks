
% created:
% us 29-May-2003 01:09:42 / CSSM


function bpx(x);


     nl=7;
     lh=findall(gca,'type','line');
     nb=length(lh)/nl;
if nb-length(x)
     error('BPX: nr(XPOS) ~= nr(boxes)');
end
     lx=1;
for i=nb:-1:1
     cl=lh(lx:lx+nl-1);
     xoff=get(cl(1),'xdata');
for j=1:nl
     xold=get(cl(j),'xdata');
     xnew=xold-xoff+x(i);
     set(cl(j),'xdata',xnew);
end
     lx=lx+nl;
end
     set(gca,'xtick',x);
     set(gca,'xlim',[min(x)-.5 max(x)+.5]);
% CODE END
