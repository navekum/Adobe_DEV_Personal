trigger AccountTrigger on Account (
	before insert,
	before update,
	before delete,
	after insert,
	after update,
	after delete,
	after undelete) {

    system.debug('check-->>'+trigger.new.size());

    ObjectHandler.triggerHandler(accountHandler.class, accountQueryHandler.class);

}