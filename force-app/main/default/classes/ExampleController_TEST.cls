@IsTest (IsParallel = true)
private class ExampleController_TEST {

    @IsTest
    static void shouldReturnCalculatedOpp() {
        ApexMocks mocks = new ApexMocks();
        ExampleService serviceMock = (ExampleService) mocks.mock(ExampleService.class);

        mocks.startStubbing();
        mocks.when(serviceMock.getDiscount('0060E00000z4S6MQAU')).thenReturn(0.2);
        mocks.stopStubbing();

        Application.service.setMock(ExampleService.class, serviceMock);

        Test.startTest();
        Opportunity calculatedOpp = ExampleController.getCalculatedOpportunity('0060E00000z4S6MQAU', 10);
        Test.stopTest();

        System.assertEquals(8, calculatedOpp.Amount);
        ((ExampleService) mocks.verify(serviceMock, 1))
            .getDiscount('0060E00000z4S6MQAU');

    }

}