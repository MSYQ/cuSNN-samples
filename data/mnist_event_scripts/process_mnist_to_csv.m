% This script transforms the originally recorded MNIST-DVS database into a replica with the following changes:
%
% a) If "Remove_75hz" is set to '1' it will reshuffle timestamps to eliminate the 75hz LCD screen refresh rate harmonic
%    in the timestamp sequence. Events order is preserved, but timesptamps are recomputed randomly. Randomness can be adjusted
%    through parameter "Nosie_factor". According to our experience, setting it to '2' results in a similar noise floor
%    than the one orignally available.
%
% b) The MNIST-DVS digits move along the screen. By setting "Stabilize = 1" the moving trajectory of the center is subtracted
%    from the (x,y) event coordinates. This way, digits appear stabilized in the center (although not perfectly).
%
% c) MNIST-DVS events include a polarity bit which indicates whether light increased or decreased at that pixel location.
%    Many times, specially when doing object recognition, this polarity bit is not used. This polarity bit can be set
%    constant by setting parameter "Remove_Polarity = 1". This way, when displaying the resulting processed MNIST-DVS digits
%    on jAER, all events will be displayed with the same polarity.
%
% 
% This script should be run from the directory where the originally recorded "grabbed_dataxxx" folders are stored,
% and will generate a set of parallel folders named "processed_dataxxx".
%
% Script written by Bernabe Linares-Barranco, in Oct-2015. For questions and comments please contact bernabe(at)imse-cnm.csic.es
%
%



clear

Noise_factor=2;
Remove_75hz=1;
Stabilize = 1;
Remove_Polarity = 1;
TT = 0.2982
dd2=[];

    scale=[4 8 16];
    addpath(cd);
    nsamp = 1000;
    if nsamp>1000
        error('nsamp must be <= 1000');
    end
    
    for dig=0:9
        name_dir1 = sprintf('processed_data%d',dig);
        if exist(name_dir1,'dir') ~= 0
            error('Directory %s already exists',name_dir1);
        else
           %mkdir(name_dir1);
        end
        for isc=1:3
            sc=scale(isc);
            name_dir2 = sprintf('processed_data%d/scale%d',dig,sc);
            if exist(name_dir2,'dir') ~= 0
                error('Directory %s already exists',name_dir2);
            else
                mkdir(name_dir2)
            end
            
            for i=1:nsamp
                fname_in=sprintf('grabbed_data%d/scale%d/mnist_%d_scale%02d_%04d.aedat',dig,sc,dig,sc,i);
                fname_out=sprintf('processed_data%d/scale%d/mnist_%d_scale%02d_%04d.csv',dig,sc,dig,sc,i);
                dd=dat2csvmat(fname_in);
                csvwrite(fname_out, dd(:,[1,4,5,6]));                              
            end
        end
    end
