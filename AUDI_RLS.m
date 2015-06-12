% -*- coding: gbk -*-
% File          : AUDI_RLS.m
% Creation Date : 2015-06-12
% Description   : AUDI ��С���˷�, chapter 11
% 

for k = 1+n : L+n
    % ����������������
    for i = 0:n-1
        Phi(2*i + 1, k) = -z(k - n + i);
        Phi(2*i + 2, k) = u(k - n + i);
    end
    Phi(2*n + 1, k) = -z(k);
    
    % AUDI��ʶ�㷨
    f(:, k) = U(:, :, k-1)' * Phi(:, k);
    g(:, k) = D(:, :, k-1) * f(:, k);
    Beta(1) = 1.0;
    
    for j = 1:N
        Beta(j+1) = Beta(j) + f(j, k) * g(j, k);
        D(j, j, k) = D(j, j, k-1) * Beta(j) / Beta(j+1);
        E(j) = -f(j, k) / Beta(j);
        K(j) = g(j, k);
        
        for i = 1:j-1
            U(i, j, k) = U(i, j, k-1) + K(i) * E(j);
            K(i) = K(i) + U(i, j, k-1) * g(j, k);
        end
        
        U(j, j, k) = 1.0;
    end
end
