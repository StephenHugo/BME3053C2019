function [mag, phs] = splitfft(input)
    
       
f=fft2(input);

fm=abs(f);
mag=fftshift(ifft2(log(fm+1)));

fph=exp(1i*angle(f));
phs=abs(ifft2(fph));


end