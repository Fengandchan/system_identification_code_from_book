% -*- coding: gbk -*-
% File          : RML.m
% Creation Date : 2015-06-12
% Description   : ������Ȼ��, chapter 8
% 

for k = nMax + 1 : L + nMax
    % ���������������˲���������
    for i = 1:na
        h(i, k) = -z(k - i);
        hf(i, k) = -zf(k - i);
    end
    
    for i = 1:nb
        h(na + i, k) = u(k - i);
        hf(na + i, k) = uf(k - i);
    end
    
    for i = 1:nd
        h(na + nb + i, k) = v1(k - i);
        hf(na + nb + i, k) = v1f(k - i);
    end
    
    % ��ʶ�㷨
    s(k) = hf(:, k)' * P(:, :, k-1) * hf(:, k) + 1.0;
    Inn(k) = z(k) - h(:, k)' * Theta(:, k-1);
    K(:, k) = P(:, :, k-1) * hf(:, k) / s(k);
    P(:, :, k) = P(:, :, k-1) - K(:, k) * K(:, k)' * s(k);
    Theta(:, k) = Theta(:, k-1) + K(:, k) * Inn(k);
    
    % ��ʧ����
    J(k) = J(k-1) + Inn(k)^2 / s(k);
    
    % ��������
    v1(k) = z(k) - h(:, k)' * Theta(:, k);
    
    % ���롢��������������˲�ֵ
    zf(k) = z(k);
    uf(k) = u(k);
    v1f(k) = v1(k);
    for i = 1:nd
        zf(k) = zf(k) - Theta(na + nb + i, k) * zf(k - i);
        uf(k) = uf(k) - Theta(na + nb + i, k) * uf(k - i);
        v1f(k) = v1f(k) - Theta(na + nb + i, k) * v1f(k - i);
    end
end
