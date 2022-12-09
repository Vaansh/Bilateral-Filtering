function [O] = bilateralfilter(I, window, sigmad, sigmar)
% BILATERALFILTER   Performs Bilateral filtering on the given image using
%                   the parameters provided.
%
%   Parameters
%       I      = The input image
%       window = The size of filter window
%       sigmad = The standard deviation used for the domain (spatial) filter
%       sigmar = The standard deviation used for the range (photometric) filter
%
%   Equations
%       O = N ∫∫ f(ξ) * c(ξ,x) * s(f(ξ), f(x)) dξ                              ... (1)
%       Where
%           O = output image with bilateral filtering applied
%           N = normalization factor   = ∫∫ c(ξ,x) * s(f(ξ), f(ξ)) dξ
%           and geometric closeness    = c(ξ,x)
%           and photometric similarity = s(f(ξ), f(x))
%      
%       c(ξ, x) = e ^ -1/2 (d(ξ, x) / σd) ^ 2                                  ... (2)
%       Where
%           Euclidean distance = d(ξ, x) = ||ξ - x||
%
%       s(ξ, x) = e ^ -1/2 (d(f(ξ), f(x)) / σr) ^ 2                            ... (3)
%       Where
%           Euclidean distance  = d(f(ξ), f(x))
%
    I = im2double(I);
    w = (window - 1) / 2;
    
    % Domain filter can be computed beforehand (spatial)                    [Eqn. (2)]
    [W, H] = meshgrid(-w : w);
    D = exp((W.^2 + H.^2) / (-2 * sigmad ^ 2));
    
    % get size
    [row, col, x] = size(I);
    
    % grayscale images only
    if x > 2
        I = rgb2gray(I);
    end
    
    % padded image
    P = padarray(I, [w w], "symmetric");
    
    % output image canvas
    O = zeros(row, col);
    for r = 1 + w : w + row
        for c = 1 + w : w + col
            % local window
            F = P(r - w : r + w, c - w : c + w);

            % Range filter is computed iteratively (photometric)            [Eqn. (3)]
            R = exp((I(r - w, c - w) - F) .^2 / (-2 * sigmar ^ 2));

            % to calculate normalization factor
            N = D .* R;

            % resulting bilateral filter
            B = F .* D .* R;

            % get the sums
            [norm, res] = deal(sum(N(:)), sum(B(:)));

            % get the final result
            res = res / norm;

            % output image                                                  [Eqn. (1)]
            O(r - w, c - w) = res;
        end
    end
end