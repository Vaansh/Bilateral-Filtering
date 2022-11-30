% CONSTANTS
SIGMA_S     = 0.1
SIGMA_R     = 0.1
WINDOW_SIZE = 5

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
    files = dir("input/*.png");
    for file = files'
        I = imread(file)
        bilateralfilter(I, SIGMA_S, SIGMA_R, WINDOW_SIZE)
    end
end