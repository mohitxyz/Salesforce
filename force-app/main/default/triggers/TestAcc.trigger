trigger TestAcc on Account (before insert, before update) {
    for(account a : trigger.new){
       integer p = 999;
        If(a.phone == string.valueOf(p) && Trigger.isBefore ){
            a.addError('Error spoted' + Trigger.isUpdate);
}
}
}