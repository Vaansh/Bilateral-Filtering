function [O] = bilateralfilter(I, window_size, sigma_s, sigma_p)
% BILATERALFILTER   Performs bilateral filtering on the given image using provided parameters.
%
%   Eg. O = BILATERALFILTER(I, 5, [0.1, 0.5]) uses a 5x5 filter.
%
%   Parameters
%       I               The observed image matrix 
%       window_size     The size of filter window
%       sigma_s         The sandard deviation of the spatial kernel
%       sigma_p         The sandard deviation of the photometric kernel
% 
%   Formula
%       O = 1/W * Σ (g_s ||p - q||) * (f_r |I_p - I_q|) * I_q                       ... (1)
%
%   Notation of Terms
%       O & W               The output image & the normalization factor
%       g_s ||p - q||       The spatial kernel (or the space weight)
%       f_r |I_p - I_q|     The photometric kernel (or the range weight)
% 
%   References
%       [1] C. Tomasi and R. Manduchi, “Bilateral filtering for gray and color images,” in 
%       Sixth International Conference on Computer Vision (IEEE Cat. No.98CH36271), 2002.
% 
%   Written by
%       Vaansh Vikas Lakhwara (vaanshlakhwara AT gmail.com)
%       Shivangi Ahuja (ahujashivangi1301 AT gmail.com)
%
%   Implementation
    % preprocess input image
    I = im2double(I);

    % calculate filter size
    w = floor(window_size / 2);

    % get size
    [row, col, x] = size(I);

    % gray images only
    if x > 2
        I = rgb2gray(I);
    end

    % P = padded image
    P = padarray(I, [w w], "symmetric");

    % O = output image canvas
    O = zeros(row, col);

    % S = spatial mask
    %   - computed beforehand.
    [W, H] = meshgrid(-w : w);
    S = exp((W.^2 + H.^2) / (-2 * sigma_s ^ 2));
    for r = 1 + w : w + row
        for c = 1 + w : w + col
            % window = slice local window
            window = P(r - w : r + w, c - w : c + w);

            % L = photometric mask
            %   - computed iteratively.
            L = exp((I(r - w, c - w) - window)/(2 * sigma_p ^ 2));
            
            % N = resulting g_s * f_r
            N = S .* L;
            norm = sum(N(:));

            % B = resulting bilateral filter
            B = window .* S .* L;
            res = sum(B(:));
            
            % O = output image result
            %   - represented by Eq. (1)
            O(r - w, c - w) = res / norm;
        end
    end
end
