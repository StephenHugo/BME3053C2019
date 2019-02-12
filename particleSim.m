function particleSim(windowSize,standardDev,delta,noiz,time)
    
    parseinputs

    fi(1)
    dx = 0;
    dy = 0;

    for t=1:time
    %adapted from fspecial
    siz   = ( windowSize - 1 ) /2;
    std   = standardDev;
    
    [x,y] = meshgrid( (-siz:siz) + dx, (-siz:siz) + dy);
    arg   = -(x.*x + y.*y)/(2*std*std);

    h     = exp(arg);
    h(h<eps*max(h(:))) = 0;

    h     = h/max(h(:));
    
    h     = h + noiz*randn(size(h));
    
    imagesc(h)
    % film(num2str(t)) %% uncomment to save images
    
    pause(0.02)
    
    dx    = dx + delta*(randi(3)-2);
    dy    = dy + delta*(randi(3)-2);
    end
     
    function parseinputs
        if time>100
            time=100;
        elseif time<2
            time=1;
        end 
        if windowSize>100
            windowSize = 100;
        elseif windowSize<10
            windowSize = 10;
        end
    end
end

function film(title)
set(gcf,'Position',[100 100 300 300])
g=getframe(gcf);
imwrite(g.cdata,['~/things/matlab/bme3053C/images/im',title,'.jpg'],'jpg','Quality',50)

end