% ���ݸ���״̬�ڵ���Ŀ���ж�ϵͳ״̬1-4
function [bug_state] = system_state_dual(PF,SO,DM,MO,FB)
    master = 0;    
    if MO + DM > 0
        master = 1;
    end
    if PF + SO + master < 3
        bug_state = 1; % C4������Ч�ڵ�������3��
    elseif (MO==0&&FB<=1) && (PF>=1&&PF+SO==2&&DM>=1)
        pr = rand(1,1);
        if pr >= DM / (DM+PF)
            bug_state = 2; % sys4������Ч�ڵ�������3��
        else
            bug_state = 0;
        end
    elseif PF + MO + DM == 0
        bug_state = 3; % ���ڵ���������
    elseif FB >= 2 || (FB==1&&MO>=2) || (FB==0&&MO>=3)
        bug_state = 4; % ��������
    else 
        bug_state = 0;
    end
