function particle = particleSim(particle)
    % When the function is called, the inputs get mapped to these 5
    % variables above
    windowSize = particle.windowSize;
    standardDev = particle.standardDev;
    delta = particle.delta;
    noiz = particle.noiz;
    time = particle.time;
    
    parseinputs

    fi(1) % creates a blank image with good formating
    % colormap(summer)
    % colormap(hot)
%     colormap(hsv)
    
    % initial displacements for x and y
    dx = delta*(randi(3,time,1)-2); % negative moves to the right
    dy = delta*(randi(3,time,1)-2); % positive moves up
    
    dx = cumsum(dx); % add up individual steps
    dy = cumsum(dy);
    
    particle.dx = dx+(windowSize+1)/2;
    particle.dy = dy+(windowSize+1)/2;
    
    % use tabs for readability!!
    for t=1:time
        
        %adapted from fspecial 'gaussian'
        siz   = ( windowSize - 1 ) /2; % specify window size
        std   = standardDev; % specify gaussian's standard deviation
    
        % create an x and y mesh with offset/displacement
        [x,y] = meshgrid( (-siz:siz) - dx(t), (-siz:siz) - dy(t)); 
        arg   = -(x.*x + y.*y)/(2*std*std);

        h     = exp(arg); % h is the gaussian bead
        h(h<eps*max(h(:))) = 0; % very small values set to 0

        h     = h/max(h(:)); % set max value in image to 1
    
        h     = h + noiz*randn( size(h) ); % adding noiz
        
        particle.image(:,:,t) = h;
        
        [xpos, ypos, area] = denoiseFrame(h);
        
        particle.dx(t,2:4) = xpos;
        particle.dy(t,2:4) = ypos;
        particle.area(t,1:3) = area;
        
        subplot(2,2,1)
        
        imagesc(h) % overwrite the new image to the figure window
        
        title('original')
        
        hold on
        
        plot(xpos', ypos', 'x', 'MarkerSize', 23, 'LineWidth', 4)
        
        hold off
        
       % film(num2str(t)) %% uncomment to save images
    
        pause(0.02) % provide time for matlab to draw
    
    end
     
    function parseinputs
        % sets inputs to within a certain range
        
        % this is a conditional statement
        if time>1000 % returns a boolean output
            time=1000; % runs if the if condition is true
        elseif time<2 % this runs if the first condition fails: 0
            time=1; % runs if the elseif condition is true
        end 
        
        
        % limit windowSize value
        if windowSize>100
            windowSize = 100;
        elseif windowSize<10
            windowSize = 10;
        end
        
        % limit the noize value
        if noiz<0
            noiz=0; 
        end
        
    end
end

function film(title)
% input will become the file name
set(gcf,'Position',[100 100 110 110])
g  =getframe(gcf); % this takes a snapshot of the figure window

% write an image with some settings for quality
imwrite(g.cdata, ['C://Users/kaligamo/Documents/images/im',title,'.jpg'],'jpg','Quality',50)

end