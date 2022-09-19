trigger AccountTrigger on Account (before insert,before update, before delete,after insert, after update, after delete) {
    if(Trigger.isBefore) {
        if (Trigger.isInsert) {
            System.debug('Before Insert Trigger Start...');
            System.debug('Trigger.Size > ' + Trigger.size);
            System.debug('Trigger.new > ' + Trigger.new);
            System.debug('Trigger.newMap >' + Trigger.newMap);
            System.debug('Trigger.old >' + Trigger.old);
            System.debug('Trigger.oldMap >' + Trigger.oldMap);

            for(Account obj : Trigger.new){
                if(obj.Rating == null) {
                    obj.addError('레코드가 Insert 될 때, Rating 값은 필수입니다.');
                    //obj.Rating = 'Cold';
                }
            }

        } else if (Trigger.isUpdate) {
            //Before Update Trigger Start..
            for(Account obj : Trigger.new){
                // Rating 필드가 현재 Hot이고 변경 전에도 Hot이면 변경 불가
                if (obj.Rating == 'Hot' && Trigger.oldMap.get(obj.Id).Rating == 'Hot'){
                    obj.addError('레코드를 수정할 수 없습니다.');
                }
            }
        } else if (Trigger.isDelete) {
            //Before Delete Trigger Start..
            for(Account obj : Trigger.old){
                if(obj.Rating == 'Hot'){
                    obj.addError('레코드를 삭제할 수 없습니다.');
                }
            }
        }
    }
    else if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            System.debug('After Insert Trigger Start...');
            System.debug('Trigger.Size > ' + Trigger.size);
            System.debug('Trigger.new > ' + Trigger.new);
            System.debug('Trigger.newMap >' + Trigger.newMap);
            System.debug('Trigger.old >' + Trigger.old);
            System.debug('Trigger.oldMap >' + Trigger.oldMap);
        }
    }
}