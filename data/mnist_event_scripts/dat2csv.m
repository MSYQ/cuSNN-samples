function dat2csv(file)
[folder, baseFileName, extension] = fileparts(file);
csvRet = dat2mat(file);
csvwrite(strcat(baseFileName,'.csv'), csvRet(:,[1,4,5,6]));