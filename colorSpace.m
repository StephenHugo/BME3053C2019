function colorSpace(in)

    a = double(imread( in )); % load up an image
    
%     siz = size(a);
%     if siz(1) > 100
%         step = 10*round(siz(1)/100);
%     else
%         step = 10;
%     end
    step=1;
    
    % separate out all the color channels
    r = a(1:step:end,1:step:end,1);
    g = a(1:step:end,1:step:end,2);
    b = a(1:step:end,1:step:end,3);
    
    % show the image
    image(uint8(a))
    % have a user click on an object they want to segment
    pos=round(ginput(1));
    
    % get the color of that pixel
    pixelVal = a(pos(2),pos(1),:);
    
    % subtract that value from every pixel, get magnitude of that vector
    q=sqrt( (r(:)-pixelVal(1)).^2+(g(:)-pixelVal(2)).^2+(b(:)-pixelVal(3)).^2);
    
    nhist(q,15)
    z=zeros(size(a(:,:,1)));
    
    % anything within thr arbitrary units of intensity shows up
    thr = 100;
    z(q<thr)=1;
    
    % check the result
    fi(z)
    
%     subplot(2,1,1)
%     image(uint8(a)),axis off
%     
%     subplot(2,1,2)
%     plot3(0,0,0,'.black')
%     hold on
%     for t=1:numel(r);
%         plot3(r(t),g(t),b(t),'s',...
%             'MarkerFaceColor',[r(t) g(t) b(t)]/255,...
%             'MarkerEdgeColor','none')
%         pause(0.02)
%     end

end