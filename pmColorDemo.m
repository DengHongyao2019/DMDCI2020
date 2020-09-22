%             Function Name: pmColorDemo.m
   % =================================================
   %  The demo codes can be  available at
   %         https://github.com/DengHongyao2019/DMDCI2020,
   %  in which pmColorDemo is the main function, and all the parameters 
   %  of the method can be set in a file called 'pulsepara.m'.
   %  When you execute the program, it will read an image to process, and 
   %  --------------------------------------------------------------------------------------
   %  (1) record the PSNR results to the psnrResult.txt file,
   %  (2) record the MSSIM results to the ssimResult.txt file,
   %  (3) record the PSNR/MSSIM resutls to the testResult.txt file,
   %  (4) save the noise images to the noiseImg folder,
   %  (5) save the restored images to the outputImg folder.
   % ----------------------------------------------------------------------------------------

clear all; close all; clc;

mkdir('outputImg'); mkdir('noiseImg');
% input the parameters for programming
para = pulsepara();
Img = double(imread(para.images));

cardMiss = length(para.missingPixelsRatio);
fp = fopen('testResult.txt','at+');
fp1 = fopen('psnrResult.txt','at+');
fp2 = fopen('ssimResult.txt','at+');
fprintf(fp,'%-15s', para.imgName);
fprintf(fp1,'%-15s', para.imgName);
fprintf(fp2,'%-15s', para.imgName);

multiPSNR = cell(1,cardMiss);
multiSSIM = cell(1,cardMiss);
for k = 1:cardMiss
    [noisyImg, maskImg] = addnoise(Img, para.isCouplingNoise, para.isSaltandPepers, para.missingPixelsRatio(k), para.initalState);
    restoredImg = zeros(size(Img));
    detectMask =  zeros(size(Img));
    imwrite(uint8(noisyImg), strcat('noiseImg\\', 'our-',para.imgName,num2str(para.missingText(k)), '.png'));
    
    for ka = 1:3
        componentNoise = noisyImg(:,:,ka);
        detectMask(:, :, ka) = detectnoise(componentNoise, para.thrVal, para.numThr, para.patchSize, para.isSaltandPepers);
    end
    
    [resultImg, iterPSNR, iterSSIM] = mpmDiff(noisyImg, Img, detectMask, para.iteration, para.delta_t, para.kappa, para.option);
    PSNR = max(iterPSNR);
    SSIM = max(iterSSIM); 
    multiPSNR{1,k}=iterPSNR;
    multiSSIM{1,k}=iterSSIM;
    imwrite(uint8(resultImg), strcat('outputImg\\', 'our-',para.imgName,num2str(para.missingText(k)), '.png'));
    
    fprintf(fp, '%6.2f/%-6.2f', PSNR, SSIM);
    fprintf(fp1, '%9.2f', PSNR);
    fprintf(fp2, '%9.2f', SSIM);    
 end
fprintf(fp,'\n'); fprintf(fp1,'\n'); fprintf(fp2,'\n');
fclose(fp);       fclose(fp1);       fclose(fp2);

