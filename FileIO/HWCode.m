function HWCode

% create s, which is an open serial connection to the arduino
    s=serial('/dev/cu.usbmodem14201');
    set(s,'BaudRate',115200)
    set(s,'Timeout', 1)
    set(s,'DataBits', 8)
    set(s,'StopBits', 1)
    
    pause(0.2)

% open the serial connection
    fopen(s); % can't share open port with arduino
    pause(2) % wait for the Arduino to reset when you open the port
    
    % send R to the arduino
    fprintf(s,'R'); % the R is aRbitrary...
    
    potatoes = fscanf(s,'%s'); % Here I expect two messages
    chomatoes = fscanf(s,'%s'); % So I create two variables
    
    clc
    
    if strcmp(chomatoes,'chomatoes') % check that chomatoes was read correctly
        disp(['   The ' potatoes ' were sent successfully.'])
    else
        disp('    Try again...')
    end

% close the serial connection
    fclose(s);
    
% You don't always have to create a whole new serial object and constantly
% open/close the port to get continuous data. This code is just a basic
% example.

% If this crashes before the port is closed. Run instrfind to identify the
% open port and close it manually with fclose()
    
end