%% learning_rate
function [rate] = learning_rate(student, teacher)
    rate = acos(dot(student, teacher) / (norm(student) * norm(teacher))) / pi;
end