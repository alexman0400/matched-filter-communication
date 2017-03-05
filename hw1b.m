clc;clear;clf;
%B
disp('Second part of lab exercise')
SNR = input('Give SNR values (in dB):\n');   % SNR VALUE
bit_length = input('Give the number of bits the signal must have:\n');
ip=rand(1,bit_length)>0.5;                  % generating 0,1 with equal probability
x=2*ip-1;
OVERSAMPLING = 10; 
upsampled_x = upsample(x,OVERSAMPLING);

%Normalizing the pulse shape to have unit energy
 
pt = [ones(1,OVERSAMPLING) 0 0 0 0 0 0]/sqrt(OVERSAMPLING);
 
%Impulse response of a rectangular pulse, convolving the oversampled input with rectangular pulse
%The output of the convolution operation will be in the transmitter side
 
output_of_rect_filter = conv(upsampled_x,pt);
 

subplot(4,1,1)
stem(output_of_rect_filter);
title('Output of Rectangular Filter at Tx side')
xlabel('Samples')
ylabel('Amplitude')

for k=1:length(SNR)

%Adding noise to the signal due to AWGN channel

noised_output_of_rect_filter = awgn(complex(output_of_rect_filter),SNR(k));

subplot(4,1,2,'replace')
stem(noised_output_of_rect_filter);
title('Output of Rectangular signal with noise travveling through the channel')
xlabel('Samples')
ylabel('Amplitude')

%Receiver side; Using a matched filter (that is matched to the rect pulse in the transmitter)
 
yy = conv(noised_output_of_rect_filter,pt);

subplot(4,1,3,'replace')
stem(yy)
title('Matched filter output at Rx side')
xlabel('Samples')
ylabel('Amplitude')

%Downsampling by 4, since the actual value of the output is shifted to 4th sample
 
y_down = downsample(yy,OVERSAMPLING,OVERSAMPLING-1);
 
subplot(4,1,4,'replace')
stem(y_down);
title('Downsampled output');
xlabel('Samples');
ylabel('Amplitude');

disp(['SNR = ', num2str(SNR(k))])
disp('Press enter to see the graph for the next SNR value you entered')
pause;

end