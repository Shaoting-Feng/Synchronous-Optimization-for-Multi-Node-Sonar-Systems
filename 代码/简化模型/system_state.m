% ���ݸ���״̬�ڵ���Ŀ���ж�ϵͳ״̬1-4
function [sys_state] = system_state(PF,SO,DM,MO,FB)
    if FB==0 && ((MO==1&&PF+SO>=2) || ((MO==0&&PF>=1&&PF+SO>=3)||(MO==0&&PF==0&&DM>=1&&SO>=2)))
        sys_state = 2; % ״̬2��ϵͳȷ������Ч����
    elseif FB+MO==0 && (PF>=1&&PF+SO==2&&DM>=1)
        pr = rand(1,1);
        if pr < DM / (DM+PF)
            sys_state = 3; % ״̬3��ϵͳǡ����Ч����
        else
            sys_state = 4; % ״̬4��ϵͳǡ������Ч����
        end
    else
        sys_state = 1; % ״̬1��ϵͳȷ��������Ч����
    end
