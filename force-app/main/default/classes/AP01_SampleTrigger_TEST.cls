@isTest
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 
*@description to test owner update on status 'preparation/shipment and read/write access on account manager
*/
private class AP01_SampleTrigger_TEST{
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testCreateSampleGatekeeper() {
        TestDataFactory.testCreateSampleGatekeeper();
    } 
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testUpdateSampleGatekeeper() {
        TestDataFactory.testUpdateSampleGatekeeper();
    }    
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/18/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testCreateSampleAccess() {
        TestDataFactory.testcreateSampleShare();
    }
 /**
*@author Geerusting Govind Kumar
*@Date Creation 10/18/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    @isTest static void testUpdateSampleAccess() {
        TestDataFactory.testUpdateSampleShare();
    }
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/18/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    @isTest static void testDeleteSampleAccess() {
        TestDataFactory.testDeleteSampleShare();
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
    }  */    
      
/**
*@author Geerusting Govind Kumar
*@Date Creation 2/7/2018
*@Date modification
*@param 
*@ExcptionName
*@return error message in custom label 
*/   
    @isTest static void testsampleApproverShr() {
        TestDataFactory.testsampleApproverShr();
    } 
    
/**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 26/10/2021
*@Date modification
*@param 
*@ExcptionName
*@return error message in custom label 
*/   
    @isTest static void testFillMarketSegment(){
       TestDataFactory.fillMarketSegmentSample();
	}
      
           
     
}