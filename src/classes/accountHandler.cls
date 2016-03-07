public with sharing class accountHandler extends ObjectHandler {


	public accountHandler(List<Account> accountList) {
        Super(accountList);
	}

    public class constructor implements ObjectHandler.IConstructable{
        public ObjectHandler construct(List<sObject> sObjectList){
            return new accountHandler(sObjectList);
        }
    }

    public override void onBeforeInsertBase(){
        for(sObject obj : Records){
            Account accObj = (Account)obj;
            accObj.Type = 'Prospect';
        }
    }
}