function plotdft(X, K)
% Plot magnitude and phase response of X (DFT response)
% K: frequency resolution
magX = abs(X); angX = angle(X);
subplot(2,1,1); plot((-K:K)/K, magX); grid on;
title('Magnitude of X in pi unit');
subplot(2,1,2); plot((-K:K)/K, angX); grid on;
title('Phase response of X in pi unit');
end