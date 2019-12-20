function answer = wrk_space_dialogue(default_name)
prompt={'Name of Variable to be Stored in Workspace'};
name='Export to Workspace';
numlines=1;         
defaultanswer={default_name};
answer = inputdlg(prompt,name,numlines,defaultanswer);
end
