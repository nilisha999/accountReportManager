@isTest
public class CaseTriggerHandlerTest_14120224 {
	@isTest
    static void testHandleBeforeInsert_EmailOrigin(){
        // Step 1 : Create a test case with origin as 'Email'
        Case testCase = new Case(
							Origin = 'Email',
            				Subject = 'Test Cases email today 14 dec 2024'
						);
        // Step 2 : Insert the test case
        insert testCase;
        
        // Step 3 : Retrevive the inserted case records
        Case insertedCase = [Select Status, Priority From Case Where Id =: testCase.Id];
        
        // Step 4 : Verify that status and Priority were set correctly
        System.assertEquals('New', insertedCase.Status);
        System.assertEquals('Medium', insertedCase.Priority);
    }
    
    @isTest
    static void testHandleBeforeInsert_WithoutEmailOrigin(){
        //Step 1 : Create a test case with different Origin expect 'Email'
        Case testCaseDiff = new Case(
									Origin = 'Phone',
            						Subject = 'Test Cases Email today with different origin as email'
							);
        // Step 2 : Insert the testCaseDiff
        Insert testCaseDiff;
        
        //Step 3 : Retrevie the inserted case records
        Case insertedCaseDiff = [Select Status, Priority From Case Where Id =: testCaseDiff.Id];
        
        // Step 4 : Verify the status and Priority were set correctly
        System.assertNotEquals('New', insertedCaseDiff.Status);
        System.assertNotEquals('Medium', insertedCaseDiff.Priority);
    }
}