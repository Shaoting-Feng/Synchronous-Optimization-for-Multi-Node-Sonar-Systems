% ���ݸ���״̬�ڵ���Ŀ���ж�ϵͳ״̬1-4�Լ�ȷ�����ڵ�
function [sys_state,master] = system_state_history(ns,prev,i,master)
    sys_state = 2; % ״̬2��ϵͳȷ������Ч����
    
    PFidx = find(ns==0); % PF�Ľڵ���±� 
    DMidx = find(ns==2); % DM�Ľڵ���±�
    MOidx = find(ns==3); % MO�Ľڵ���±�
    
    PF = length(PFidx); % perfectly functioning�Ľڵ����
    SO = length(find(ns==1)); % slave only�Ľڵ����
    DM = length(DMidx); % disable/master�Ľڵ����
    MO = length(MOidx); % master only�Ľڵ����
    FB = length(find(ns==5)); % failed bus�Ľڵ����
    
    % �ж�ϵͳ�Ƿ���״̬1
    if MO + DM > 0
        ttmp = 1;
    else
        ttmp = 0;
    end
    if FB>=1 || MO>=2 || PF+MO+DM==0 || PF+SO+ttmp<3
        sys_state = 1; % ״̬1��ϵͳȷ��������Ч����
    end
    
    % �������������Ҫ�������ڵ���ѡ
    if master == i && sys_state ~= 1 
        if prev == 0 
            if ns(i) == 1 || ns(i) == 4
                master = reSelect(PFidx,DMidx,PF,DM);
            end
        elseif (prev == 3 && ns(i) == 4) || (prev == 2 && ns(i) == 4)
            master = reSelect(PFidx,DMidx,PF,DM);
        end   
    end
    if MO ~= 0
        master = MOidx;
    end

    % �ж�����ϵͳ״̬
    if sys_state ~= 1 && FB+MO==0 && (PF>=1&&PF+SO==2&&DM>=1)
        if ns(master) == 2
            sys_state = 3; % ״̬3��ϵͳǡ����Ч����
        else
            sys_state = 4; % ״̬4��ϵͳǡ������Ч����
        end
    end
