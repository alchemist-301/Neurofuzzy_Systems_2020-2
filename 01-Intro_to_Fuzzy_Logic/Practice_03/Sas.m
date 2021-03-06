function D = Sas(A,B)
%Sas (Algebraic Sum) receives sets A, B and returns the 'a + b - a x b' operation.
% A and B must be the same length

if (length(A) == length(B)) 
    D = A + B - (A .* B);
else
    error('A & B are not the same length');
end
end
