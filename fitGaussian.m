function [xOffset, yOffset, amplitude] = fitGaussian(g)
    % fits a single gaussian shape assuming an odd-sized window
    % struggles with noise because of q
    
    fi(g)
    
    siz = size(g);  
    
    [x, y] = meshgrid((1:siz(1))-(siz(1)+1)/2, (1:siz(2))-(siz(2)+1)/2);
    
    q=-log(g);

    result = [x(:).^2 x(:) y(:).^2 y(:) ones(size(x(:)))]\q(:);
    
    xOffset = 0.5*result(2)/result(1);
    
    yOffset = 0.5*result(4)/result(3);
    
    amplitude = exp( -result(5) + result(1)*xOffset^2);
    
end