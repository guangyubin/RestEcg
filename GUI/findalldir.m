
function drt=findalldir(path)


  list = dir(path);
  drt = cell(0,0);
  for ii = 1:length(list)
     if list(ii).isdir==1 && isempty(strfind(list(ii).name,'.'))           
         drt = [ drt, fullfile(path,list(ii).name)];        
         drt = [drt ,findalldir(fullfile(path,list(ii).name))];                
     end
  end

