function [t] = arrow_type(operand)

t_left = up_down_arrow_type(rot90(operand));
t_right = up_down_arrow_type(rot90(operand, -1));

if ((strcmp(t_left,'v')) && (strcmp(t_right, '^')))
    t = '<-';
elseif ((strcmp(t_left,'^')) && (strcmp(t_right, 'v')))
    t = '->';
else
    t = '<->';
end
end
