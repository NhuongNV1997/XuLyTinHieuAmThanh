>> %melody
[nhuong, fs] = wavread('D:\nhuong\orig_input.wav');
[rows colums] = size(data);
fs = 44100; % sampling frequency (Hz)
t = 0 : 1/fs : 5; % time axis (seconds)
f1 = 440; % frequency (Hz)
f2 =  f1/2;
f3 =  3*f1;
A1 = 0.3; A2 = A1/2; A3 = A1/3; 
w = 0; % phase

y1 = A1 * sin( 2 * pi * f1 * t + w );
y2 = A2 * sin( 2 * pi * f2 * t + w );
y3 = A3 * sin( 2 * pi * f3 * t + w );

y = [y1 y3 y2 y3 y2 y1];
melody = y(1:length(nhuong));

for i = 1:colums
    for j = 1:rows
        melody(j+i) = nhuong(j,i) + y(i+j);
        
    end
end

%fft
Y = fft(melody);
plot(abs(Y))

N = fs % number of FFT points
transform = fft(melody,N)/N;
magTransform = abs(transform);

faxis = linspace(-fs/2,fs/2,N);
plot(faxis,fftshift(magTransform));
xlabel('Frequency (Hz)')

% view frequency content up to half the sampling rate:
axis([0 length(faxis)/2, 0 max(magTransform)]) 

% change the tick labels of the graph from scientific notation to floating point: 
xt = get(gca,'XTick');  
set(gca,'XTickLabel', sprintf('%.0f|',xt))


>> %spectrogram
win = 128 % window length in samples
% number of samples between overlapping windows:
hop = win/2            

nfft = win % width of each frequency bin 
spectrogram(melody,win,hop,nfft,fs,'yaxis')

% change the tick labels of the graph from scientific notation to floating point: 
yt = get(gca,'YTick');  
set(gca,'YTickLabel', sprintf('%.0f|',yt))

