function similarity = hpsim(imgRef,imgDist,preprocessWithSubsampling)
%HaarPSI Computes the perceptual similarity between a reference image and its
%distorted version based on the discrete Haar wavelet transform. The code
%implements the method proposed in "Reisenhofer, Bosse, Kutyniok and Wiegand
%'A Haar Wavelet-Based Perceptual Similarity Index for Image Quality Assessment', 2016".
%
%Please make sure that grayscale and color values are given in the [0,255]
%interval! If this is not the case, the HaarPSI cannot be computed
%correctly.
%
%
%Usage:
%
% similarity = HaarPSI(imgRef, imgDist);
% similarity = HaarPSI(imgRef, imgDist, preprocessWithSubsampling);
%
%Input:
%
%                       imgRef: RGB or grayscale image with values ranging from 0
%                               to 255.
%                      imgDist: RGB or grayscale image with values ranging from 0
%                               to 255.
%    preprocessWithSubsampling: (optional) If 0, the preprocssing step to acommodate for the 
%                               viewing distance in psychophysical experimentes is omitted.
%                  
%
%Output:
%
% similarity: Value ranging from 0 to 1 denoting the perceptual similarity between
%             imgRef and imgDist.
%
%Example:
%
% imgRef = double(imread('peppers.png'));
% imgDist = imgRef + randi([-20,20],size(imgRef));
% imgDist = min(max(imgDist,0),255);
% similarity = HaarPSI(imgRef,imgDist); 
    if nargin < 3
        preprocessWithSubsampling = 1;
    end
    colorImage = size(imgRef,3) == 3;    
        
    imgRef = double(imgRef);
    imgDist = double(imgDist);
    
    %% initialization and preprocessing   
    
    %constants
    C1 = 40;
    alpha = 0.03;
    
    %transform to YIQ colorspace
    if colorImage        
        C2 = 250;

        imgRefY = 0.299 * (imgRef(:,:,1)) + 0.587 * (imgRef(:,:,2)) + 0.114 * (imgRef(:,:,3));
        imgDistY = 0.299 * (imgDist(:,:,1)) + 0.587 * (imgDist(:,:,2)) + 0.114 * (imgDist(:,:,3));
        imgRefI = 0.596 * (imgRef(:,:,1)) - 0.274 * (imgRef(:,:,2)) - 0.322 * (imgRef(:,:,3));
        imgDistI = 0.596 * (imgDist(:,:,1)) - 0.274 * (imgDist(:,:,2)) - 0.322 * (imgDist(:,:,3));
        imgRefQ = 0.211 * (imgRef(:,:,1)) - 0.523 * (imgRef(:,:,2)) + 0.312 * (imgRef(:,:,3));
        imgDistQ = 0.211 * (imgDist(:,:,1)) - 0.523 * (imgDist(:,:,2)) + 0.312 * (imgDist(:,:,3));
    else
        imgRefY = double(imgRef);
        imgDistY = double(imgDist);
    end
    
    
    %subsampling    
    if preprocessWithSubsampling
        imgRefY = HaarPSISubsample(imgRefY);
        imgDistY = HaarPSISubsample(imgDistY);    
        if colorImage
            imgRefQ = HaarPSISubsample(imgRefQ);
            imgDistQ = HaarPSISubsample(imgDistQ);
            imgRefI = HaarPSISubsample(imgRefI);
            imgDistI = HaarPSISubsample(imgDistI);
        end 
    end
    
    %variables
    weights = zeros([size(imgRefY),2]);
    localSimilarities = zeros([size(imgRefY),2]);  
    
    
    %% Haar wavelet decomposition
    coeffsRefY = HaarPSIDec(imgRefY,4);
    coeffsDistY = HaarPSIDec(imgDistY,4);
    
    if colorImage
        coeffsRefQ = abs(conv2(imgRefQ,ones(2,2)/4,'same'));
        coeffsDistQ = abs(conv2(imgDistQ,ones(2,2)/4,'same'));
        coeffsRefI = abs(conv2(imgRefI,ones(2,2)/4,'same'));
        coeffsDistI = abs(conv2(imgDistI,ones(2,2)/4,'same'));
    end
    
    
    
    %% compute similarities for color channels
    if colorImage         
        similarityI = ((2*coeffsRefI.*coeffsDistI + C2) ./(coeffsRefI.^2 + coeffsDistI.^2 + C2));
        similarityQ = ((2*coeffsRefQ.*coeffsDistQ + C2) ./(coeffsRefQ.^2 + coeffsDistQ.^2 + C2));
        similarityCol = similarityI.*similarityQ;
    end

    %% compute weights and similarity for each orientation
    for ori = 1:2        
        weights(:,:,ori) = max(abs(sum(coeffsRefY(:,:,(1:4) + (ori-1)*4),3)), abs(sum(coeffsDistY(:,:,(1:4) + (ori-1)*4),3)));
        coeffsRefYMag = abs(coeffsRefY(:,:,(1:2) + (ori-1)*4));
        coeffsDistYMag = abs(coeffsDistY(:,:,(1:2) + (ori-1)*4));
        localSimilarities(:,:,ori) = prod((2*coeffsRefYMag.*coeffsDistYMag + C1)./(coeffsRefYMag.^2 + coeffsDistYMag.^2 + C1),3);
        if colorImage            
            localSimilarities(:,:,ori) = localSimilarities(:,:,ori).*similarityCol;            
        end        
    end    
    %% compute final score
    similarity = ((sum(localSimilarities(:).^alpha.*weights(:))) / (sum(weights(:))))^(1/alpha);
end

function coeffs = HaarPSIDec(X,nScales)
    coeffs = zeros([size(X),2*nScales]);    
    for k = 1:nScales
        haarFilter = 2^(-k)*ones(2^k,2^k);
        haarFilter(1:(end/2),:) = -haarFilter(1:(end/2),:);
        coeffs(:,:,k) = conv2(X,haarFilter,'same');
        coeffs(:,:,k + nScales) = conv2(X,haarFilter','same');
    end   
end

function imgSubsampled = HaarPSISubsample(img)
    imgSubsampled = conv2(img, ones(2,2)/4,'same');        
    imgSubsampled = imgSubsampled(1:2:end,1:2:end);
end
