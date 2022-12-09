function program()
% PROGRAM   Iterates over .png files in "input" directory, applies the bilateralfilter with various parameters
%           and saves result to the corresponding "output" directory.
    SIGMAD  = [1,   3,    5];
    SIGMAR  = [0.1, 0.25, 10];
    WINDOWS = [23];
    
    files = dir("input/*.png");
    for file = files'
        [p, f, x] = fileparts(file.name);
        folder = fullfile(p, f);
        status = mkdir("output", folder);
        for window = WINDOWS
            for sigmad = SIGMAD
                for sigmar = SIGMAR
                    I = imread(fullfile("input", file.name));
                    O = bilateralfilter(I, window, sigmad, sigmar);
                    
                    filename = strcat("window=", int2str(window), ...
                                      "_sigmad=", int2str(sigmad), ...
                                      "_sigmar=", string(sigmar), ".png");
                    
                    filepath = fullfile("output", folder, filename);
                    imwrite(O, filepath);
                end
            end
        end
    end
end