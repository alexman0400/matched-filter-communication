clear all; close all;
%A
disp('First part of lab exercise')
SNR = input('Give SNR values (in dB):\n');   % SNR VALUE
bit_length = input('Give the number of bits the signal must have:\n');
temp = zeros(1,bit_length);

ip = rand(1,bit_length)>0.5;                  % generating 0,1 with equal probability
x = 2*ip-1;                                   % BPSK modulation 0->-1 , 1->0
w = 1./SNR*rand(1,1);

ratios = [];

for k = 1:length(SNR)
    y=awgn(complex(x),SNR(k)); 
    scatterplot(y)% calculating y with AWGN noise
    for j = 1:bit_length                    % trying to find the true value of y
        if y(j)>0
            temp(j) = 1;                    
        else
            temp(j) = 0;
        end
    end
    [number,ratio] = biterr(ip,temp);        % ratio = BER
    disp(['ratio for this is ', num2str(ratio)]);
    ratios = [ratios ratio];                 % appends the new BER value for SNR(k) in the end of the list of all BERs
    disp(['Constilation graph for SNR=', num2str(SNR(k))]);
                                   % CONSTILATION GRAPH
    disp('Press enter to continue');
    pause;
end

figure(1)
title('BER GRAPH')
semilogy(SNR,ratios,'k*-','linewidth',2);
hold on
grid on
xlabel('SNR values')
ylabel('BER values')

