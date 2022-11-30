function O = bilateralfilter(I, sigma_s, sigma_r, window_size)
% BILATERALFILTER   Performs bilateral filtering on the given image using provided parameters.
%
%   Eg. O = BILATERALFILTER(I, 5, 0.1, 0.5) uses a 5x5 filter.
%
%   Parameters
%       I               The observed image matrix 
%       sigma_s         The sigma_s
%       sigma_r         The sigma_r
%       window_size     The size of filter window
% 
%   Formula
%       O = 1/W * Σ (G_sigma_s ||p - q||) * (G_sigma_r |I_p - I_q|) * I_q            ... (1)
%
%   Notation of Terms
%       O                           The output image
%       W                           The normalization factor
%       G_sigma_s * ||p - q||       The spatial distance (or the space weight)       ... (2)  
%       G_sigma_r * |I_p - I_q|     The photometric distance (or the range weight)   ... (3)  
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
    [row, col, m] = size(A);

    % Gray images only
    if m > 2
        A = rgb2gray(A);
    end

    O = zeros(size(A));

    % Spatial Distance
    %   - Computed beforehand.
    %   - Represented by Eq. (2) in Eq. (1)
    
    for i = 1 : row
        for j = 1 : col
            % Photometric Distance
            %   - Computed iteratively.
            %   - Represented by Eq. (3) in Eq. (1)
        end
    end
end
