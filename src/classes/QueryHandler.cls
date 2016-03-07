public interface QueryHandler {

	//Define the method signature to be implemented in classes that implements the interface
	//Example method
	void queryBase(List<sObject> sObjectList);
    void queryDataBefore(List<sObject> sObjectList);
    void queryDataAfter(List<sObject> sObjectList);
}