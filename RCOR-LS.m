% -*- coding: gbk -*-
% File          : RCOR-LS.m
% Creation Date : 2015-06-12
% Description   : ��ض�����, chapter 6
% 

for k = k0:Inter:L
    % ��ʼ��
    if k == k0
        for i = 1:N
            P(i, i, 1) = 1.0e+12;
        end
    end
    
    % ����غ���ʱ��������
    for l = 2:Lr+1
        % ������������
        for i = 1:na
            h(i, l) = -Ruz(k, l + Lr1 - Lr0 - 1 - i);
        end
        
        for i = 1:nb
            h(na + i, l) = Ru(k, l + Lr1 - Lr0 - 1 - i);
        end
        
        % ��ʶ�㷨
        Ruz(k, l) = Ruz(k, l + Lr1 - Lr0 - 1);
        s(l) = h(:, l)' * P(:, :, l-1) * h(:, l) + 1.0;
        Inn(l) = Ruz(k, l) - h(:, l)' * Theta(:, l-1);
        K(:, l) = P(:, :, l-1) * h(:, l) / s(l);
        P(:, :, l) = P(:, :, l-1) - K(:, l) * K(:, l)' * s(l);
        Theta(:, l) = Theta(:, l-1) + K(:, l) * Inn(l);
        
        % ��ʧ����
        J(l) = J(l-1) + Inn(l)^2 / s(l);
    end
end
