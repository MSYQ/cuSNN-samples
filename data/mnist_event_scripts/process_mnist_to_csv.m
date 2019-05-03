% This script transforms the originally recorded MNIST-DVS database into a replica with the following changes:

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
            mkdir(name_dir1);
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
                subFolderName = sprintf('processed_data%d/scale%d/mnist_%d_scale%02d_%04d',dig,sc,dig,sc,i);
                if exist(subFolderName,'dir') ~= 0
                    error('Directory %s already exists',subFolderName);
                else
                    mkdir(subFolderName)
                end
                fname_out_events=strcat(subFolderName,'/events.csv');
                fname_out_numStep=strcat(subFolderName,'/num_steps.csv');
                dd=dat2csvmat(fname_in);
                csvwrite(fname_out_events, dd(:,[1,4,5,6]));  
                csvwrite(fname_out_numStep, floor(dd(end,1)/1000));  
            end
        end
    end
