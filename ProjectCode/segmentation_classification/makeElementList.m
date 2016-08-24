function [pt_htable]=makeElementList(varargin)
tableName='myhashtable';
if ispc
   datadir = char(java.lang.System.getProperty('user.dir'));
else
   datadir = getenv('HOME');
end;
tableName = fullfile(datadir, tableName);
 FOS = java.io.FileOutputStream(tableName);
 FOS.close;

pt_htable = java.util.Properties;
try
   FIS = java.io.FileInputStream(tableName);
catch
   error('Failed to open %s for reading.', tableName);
end;
pt_htable.load(FIS);
FIS.close;
fid = fopen('periodicTable.txt','rt');
while true
    thisline = fgetl(fid);
    if thisline == -1
        break
    end   
    ptAdd(pt_htable, thisline);
end
end