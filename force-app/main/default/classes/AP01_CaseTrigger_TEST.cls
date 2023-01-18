@isTest
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 
*@description to test owner update on status 'Registration' and read/write access on SalesMan
*/
private class AP01_CaseTrigger_TEST{
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 10/26/2017
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testCreateCaseGatekeeper() {
        TestDataFactory.testCreateCaseGatekeeper();
    }
/**
*@author Geerusting Govind Kumar
*@Date Creation 29/08/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testCreateCountryforGatekeeper() {
        TestDataFactory.testCreateCountryforGatekeeper();
    }
/**
*@author Geerusting Govind Kumar
*@Date Creation 29/08/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testUpdateCountryGatekeeper() {
        TestDataFactory.testUpdateCountryforGatekeeper();
    }   
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 10/26/2017
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testUpdateGatekeeper() {
        TestDataFactory.testUpdateCaseGatekeeper();
    } 
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 10/26/2017
*@param 
*@ExcptionName
*@return 
*/
    
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 10/26/2017
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testCreateBulkGatekeeper() {
        TestDataFactory.testCreateBulkGatekeeper(1);
    }    
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 10/26/2017
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testUpdateCaseShare() {
        TestDataFactory.testUpdateCaseShare();
    }
 /**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 10/26/2017
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testDeleteCaseShare() {
        TestDataFactory.testDeleteCaseShare();
    } 
/**
*@author Geerusting Govind Kumar
*@Date Creation 2/7/2018
*@Date modification
*@param 
*@ExcptionName
*@return error message in custom label 
*/  
    /*
    @isTest static void testFillRelationship() {
        TestDataFactory.testFillRelationship();
    }*/
 
/**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 4/8/2021
*@Date modification
*@param 
*@ExcptionName
*@return error message in custom label 
*/ 
    
    @isTest static void testFillMarketSegmentAndAccMgr(){
       TestDataFactory.testFillMarketSegmentAndAccMgr();
	}

/**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 4/8/2021
*@Date modification
*@param 
*@ExcptionName
*@return error message in custom label 
*/   
    @isTest static void testupdateOwnerIdonCreation() {
        TestDataFactory.testupdateOwnerIdonCreation();
    }    
}