public virtual without sharing class ObjectHandler {

    public List<sObject> Records {get; private set;}

	public ObjectHandler(List<sObject> sObjectList) {
        Records = sObjectList;
	}

    public virtual void onBeforeInsertBase(){}

    public virtual void onBeforeUpdateBase(Map<Id,sObject> existingRecordsBefore){}

    public virtual void onBeforeDeleteBase(){}

    public virtual void onAfterInsertBase(){}

    public virtual void onAfterUpdateBase(Map<Id,sObject> existingRecordsAfter){}

    public virtual void onAfterDeleteBase(){}



    public virtual void onBeforeInsert(){}

    public virtual void onBeforeUpdate(Map<Id,sObject> existingRecordsBefore){}

    public virtual void onBeforeDelete(){}

    public virtual void onAfterInsertB(){}

    public virtual void onAfterUpdate(Map<Id,sObject> existingRecordsAfter){}

    public virtual void onAfterDelete(){}



    public void handleBeforeInsertBase(){
        onBeforeInsertBase();
    }

    public void handleBeforeUpdateBase(Map<Id, sObject> existingRecords){
        onBeforeUpdateBase(existingRecords);
    }

    public void handleBeforeDeleteBase(){
        onBeforeDeleteBase();
    }

    public void handleAfterInsertBase(){
        onAfterInsertBase();
    }

    public void handleAfterUpdateBase(Map<Id, sObject> existingRecords){
        onAfterUpdateBase(existingRecords);
    }

    public void handleAfterDeleteBase(){
        onAfterDeleteBase();
    }


    public interface IConstructable{
        ObjectHandler construct(List<sObject> sObjectList);
    }

    public static void triggerHandler(Type objectHandlerClass, Type queryHandlerClass){
        String domainClassName = objectHandlerClass.getName();
        Type constructableClass = domainClassName.endsWith('Constructor') ? Type.forName(domainClassName) : Type.forName(domainClassName+'.Constructor');
        IConstructable constructor = (IConstructable)constructableClass.newInstance();

        QueryHandler targetQueryClass = (QueryHandler)queryHandlerClass.newInstance();

        triggerHandler(
            objectHandlerClass,
            constructor,
            targetQueryClass,
            Trigger.isBefore,
            Trigger.isAfter,
            Trigger.isInsert,
            Trigger.isUpdate,
            Trigger.isDelete,
            Trigger.new,
            Trigger.oldMap
        );
    }
    private static void triggerHandler(
        Type ObjectHandler,
        IConstructable handleConstructor,
        QueryHandler queryHandler,
        Boolean isBefore,
        Boolean isAfter,
        Boolean isInsert,
        Boolean isUpdate,
        Boolean isDelete,
        List<sObject> newReocrds,
        Map<Id,sObject> oldRecordsMap
    ){
        if(isBefore){
            if(isInsert){
                handleConstructor.construct(newReocrds).handleBeforeInsertBase();
            }else if(isUpdate){
                handleConstructor.construct(newReocrds).handleBeforeUpdateBase(oldRecordsMap);
            }else if(isDelete){
                handleConstructor.construct(oldRecordsMap.values()).handleBeforeDeleteBase();
            }
        }

        if(isAfter){
            if(isInsert){
                handleConstructor.construct(newReocrds).handleAfterInsertBase();
            }else if(isUpdate){
                handleConstructor.construct(newReocrds).handleAfterUpdateBase(oldRecordsMap);
            }else if(isDelete){
                handleConstructor.construct(oldRecordsMap.values()).handleAfterDeleteBase();
            }
        }
    }
}