function make_struct_in_base(var_name)
    S.map = [];    
    S.type = [];
    S.ave = [];
    S.name = '';
    S.r = [];
    S.e = 0.0;
    S.info = [];
    S.ops = '';
    S.var = '';
    
    assignin('base',var_name,S)
end

 