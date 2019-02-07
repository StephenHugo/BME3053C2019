% blank files with code run from top-to-bottom, left-to-right

x=1; % this line runs first

y=int8(1); % this line runs next

z=uint8(1); % and so on

% x y and z each have a value of 1, but they differ by how many bits are
% used to store the value in memory. Each bit represents some power of 2,
% meaning that 1111 1111 (the max value z can posses) evaluates to: 1*2^7 +
% 1*2^6 + 1*2^5 + 1*2^4 + 1*2^3 + 1*2^2 + 1*2^1 + 1*2^0 = 255

maxz = 1*2^7 + 1*2^6 + 1*2^5 + 1*2^4 + 1*2^3 + 1*2^2 + 1*2^1 + 1*2^0;

hmm = z*256; % this will only go to 255

hmm = -z; % this will go to zero

hmm = z/2; % this rounds up to 1

hmm = z/3; % this rounds down to 0

% many images use unsigned integers like z to store pixel values, and
% before you can do complex math operations, they must be converted to
% double precision values to avoid saturating at 255 or 0, and to perform
% calculations with decimal places.