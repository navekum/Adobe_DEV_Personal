public without sharing class accountQueryHandler implements QueryHandler{
	public accountQueryHandler() {}

    public void queryBase(List<sObject> sObjectList){}

    public void queryDataBefore(List<sObject> sObjectList){


    }

    public void queryDataAfter(List<sObject> sObjectlist){
        Map<Id, Account> accountMap = new Map<Id, Account>();
        Set<Id> accountIds = new Set<Id> ();

        for(sObject record : sObjectlist){
            Account accObj = (Account)record;
            accountIds.add(accObj.Id);
        }
        if(!accountIds.isEmpty() && accountIds != null){
            accountMap = queryAccount(accountIds);
        }

    }
    public static Map<Id, Account> queryAccount(Set<Id> accountIds){
        return new Map<Id, Account>([Select
                Id,
                Name
                FROM Account
                WHERE Id IN : accountIds
                LIMIT 10
            ]);
    }
}