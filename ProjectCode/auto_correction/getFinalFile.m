function [operandCorrect]=getFinalFile(operand_list)

operandNum = size(operand_list,1);
%operatorNum = size(operator_list,1);


% for i=1:operatorNum
%     operatorCorrect{i,1}=(operator_list{i});
% end

for i=1:operandNum
    operandCorrect{i,1}=autoCorrect(operand_list{i});
end
end
