% 根据各种状态节点数目来判断系统状态1-4以及确定主节点
function [sys_state,master] = system_state_history(ns,prev,i,master)
    sys_state = 2; % 状态2：系统确定能有效工作
    
    PFidx = find(ns==0); % PF的节点的下标 
    DMidx = find(ns==2); % DM的节点的下标
    MOidx = find(ns==3); % MO的节点的下标
    
    PF = length(PFidx); % perfectly functioning的节点个数
    SO = length(find(ns==1)); % slave only的节点个数
    DM = length(DMidx); % disable/master的节点个数
    MO = length(MOidx); % master only的节点个数
    FB = length(find(ns==5)); % failed bus的节点个数
    
    % 判断系统是否处于状态1
    if MO + DM > 0
        ttmp = 1;
    else
        ttmp = 0;
    end
    if FB>=1 || MO>=2 || PF+MO+DM==0 || PF+SO+ttmp<3
        sys_state = 1; % 状态1：系统确定不能有效工作
    end
    
    % 在以下情况下需要进行主节点重选
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

    % 判断其他系统状态
    if sys_state ~= 1 && FB+MO==0 && (PF>=1&&PF+SO==2&&DM>=1)
        if ns(master) == 2
            sys_state = 3; % 状态3：系统恰能有效工作
        else
            sys_state = 4; % 状态4：系统恰不能有效工作
        end
    end
