function para = pulsepara()
% ================================

% para.images = 'D:\Researching\myWorks\IMPULSENOISE\matColor\images\voit.png'; 
para.images = '.\testImg\pepper.png'; 
para.imgName = 'Pepper';
% -----  the parameters which descripts the feature of noise ----------
para.missingPixelsRatio = [0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9];
para.missingText = [5, 10, 20, 30, 40, 50, 60, 70, 80, 90];
% para.missingPixelsRatio = 0.2;
% para.missingText = 20;

 para.noiseSigma = 0;
para.initalState = 2020;
% noiseType = (isCouplingNoise, isSaltandPepers)
para.isCouplingNoise = 0; % '0' components are not coupled; '1' are coupled 
para.isSaltandPepers = 1; % '1' stands for salt-and-pepper, '0' stands for random impulse.

% ------  detective parameters    --------
para.patchSize = 5;
para.thrVal = 50;
para.numThr = 2;

% ------  denoisy parameters    --------
para.iteration = 150; % 26
para.delta_t = 1/7;
para.kappa = 180;
para.option = 2;

% ---------- initializing image ----------
% if para.missingPixelsRatio <= 0.1 % in practic, 3
%     para.winSize = 3;
% elseif para.missingPixelsRatio <= 0.2 % 3
%     para.winSize = 5;
% elseif para.missingPixelsRatio <= 0.3
%     para.winSize = 7;
% elseif para.missingPixelsRatio <= 0.5
%     para.winSize = 9;
% elseif para.missingPixelsRatio <= 0.7
%     para.winSize = 11;
% elseif para.missingPixelsRatio <= 0.99
%     para.winSize = 13;
% end
    

