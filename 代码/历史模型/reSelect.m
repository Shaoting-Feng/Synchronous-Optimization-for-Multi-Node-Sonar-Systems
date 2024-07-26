function master = reSelect(PFidx,DMidx,PF,DM)
    randIDX = randi([1 PF+DM]);
    allIDX = [PFidx DMidx];
    master = allIDX(randIDX);