@isTest
private class MyEmergencyClassTest {
    @isTest
    static void testGetStatus() {
        // Start the test
        Test.startTest();
        String status = MyEmergencyClass.getStatus();
        Test.stopTest();
        
        // Assert that the result is what we expected
        System.assertEquals('System is stable', status, 'The status should be stable');
        System.debug('Test for getStatus completed successfully');
    }
}