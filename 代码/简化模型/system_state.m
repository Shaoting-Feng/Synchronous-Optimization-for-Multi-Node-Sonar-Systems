% 根据各种状态节点数目来判断系统状态1-4
function [sys_state] = system_state(PF,SO,DM,MO,FB)
    if FB==0 && ((MO==1&&PF+SO>=2) || ((MO==0&&PF>=1&&PF+SO>=3)||(MO==0&&PF==0&&DM>=1&&SO>=2)))
        sys_state = 2; % 状态2：系统确定能有效工作
    elseif FB+MO==0 && (PF>=1&&PF+SO==2&&DM>=1)
        pr = rand(1,1);
        if pr < DM / (DM+PF)
            sys_state = 3; % 状态3：系统恰能有效工作
        else
            sys_state = 4; % 状态4：系统恰不能有效工作
        end
    else
        sys_state = 1; % 状态1：系统确定不能有效工作
    end
