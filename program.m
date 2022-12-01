function program()
% PROGRAM   Goes through all .png files in "input" directory, calls the bilateralfilter
%   method and saves result to the corresponding "output" directory.
% 
%   See also BILATERALFILTER.
% 
%   Written by
%       Vaansh Vikas Lakhwara (vaanshlakhwara AT gmail.com)
%       Shivangi Ahuja (ahujashivangi1301 AT gmail.com)
% 
%   Implementation

    % CONSTANTS
    SIGMA_S     = [1,  3,  10];
    SIGMA_P     = [10, 30, 100, 300];
    WINDOW_SIZE = [11, 25];

    files = dir("input/*.png");
    for file = files'
        [p,f,x] =fileparts(file.name);
        folder = fullfile(p,f);
        status = mkdir("output", folder);
        for window_size = WINDOW_SIZE
            for sigma_s = SIGMA_S
                for sigma_p = SIGMA_P
                    I    = imread(fullfile("input", file.name));
                    O    = bilateralfilter(I, window_size, sigma_s, sigma_p);
                    name = strcat("w=", int2str(window_size), "_s=", int2str(sigma_s), ...
                                 "_p=", int2str(sigma_p), ".png");
                    file_name = fullfile("output", folder, name);
                    imwrite(O, file_name);
                end
            end
        end
    end
end
