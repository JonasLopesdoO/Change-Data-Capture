@isTest
private class TestEmployeeChangeTrigger {
    @isTest 
    static void testCreateEmployee() {
        // Enable all Change Data Capture entities for notifications.
        Test.enableChangeDataCapture();
        
        // Insert an Employee test record
        Employee__c employee = new Employee__c(
            First_Name__c = 'Astro',
            Last_Name__c = 'Test',
            Tenure__c = 1
        );
        insert employee;

        // Call deliver to fire the trigger and deliver the test change event.
        Test.getEventBus().deliver();
        
        // VERIFICATIONS
        // Check that the change event trigger created a task.
        List<Task> taskList = [SELECT Id, Subject FROM Task];
        System.assertEquals(1, taskList.size(), 'The change event trigger did not create the expected task.');
        
        // Update employee record
        List<Employee__c> empRecords = [SELECT Id, OwnerId, First_Name__c, Tenure__c FROM Employee__c];
        Employee__c emp = empRecords.get(0);
        
        // Update one field and empty another
        emp.First_Name__c = 'Codey';
        emp.Tenure__c = null;
        update emp;
        
        // Call deliver to fire the trigger for the update operation.
        Test.getEventBus().deliver();
        
        // VERIFICATIONS
        // Check that the change event trigger created a task.
        // We should have two tasks now, including one from the first trigger invocation.
        List<Task> taskList2 = [SELECT Id, Subject FROM Task];
        System.assertEquals(2, taskList2.size(), 'The change event trigger did not create the expected task.');
    }
    
    @isTest 
    static void testCreateEmployeeWithStartStopBlock() {
        // Enable all Change Data Capture entities for notifications.
        Test.enableChangeDataCapture();
        
        // Insert an Employee test record
        Employee__c employee = new Employee__c(
            First_Name__c = 'Codey',
            Last_Name__c = 'Test',
            Tenure__c = 1
        );
       
        Test.startTest();
            insert employee;
        Test.stopTest();
        
        // VERIFICATIONS
        // Check that the change event trigger created a task.
        // We should have two tasks now, including one from the first trigger invocation.
        List<Task> taskList = [SELECT Id, Subject FROM Task];
        System.assertEquals(1, taskList.size(), 'The change event trigger did not create the expected task.');
    }
}