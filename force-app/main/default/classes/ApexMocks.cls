/**
 * Provides the ability to mock Apex classes. Simplified version of fflib_ApexMocks
 */
@IsTest
public inherited sharing class ApexMocks implements System.StubProvider {

    private static final String MSG_RESPONSE_OR_EXCEPTION = 'Specify either a Response or an Exception.';

    private Map<String, StubResponse> methodSignature2StubResponse = new Map<String, StubResponse>();
    private Boolean isStubbing = false;
    private Boolean isVerifying = false;
    private StubResponse currentStubResponse;
    private Integer currentExpectedCallCount;

    /**
     * Creates mock object of given class or interface.
     *
     * @param classToMock class or interface to mock
     * @return mock object
     */
    public Object mock(Type classToMock) {
        return Test.createStub(classToMock, this);
    }

    public void startStubbing() {
        isStubbing = true;
    }

    public void stopStubbing() {
        isStubbing = false;
    }

    public StubResponse when(Object mock) {
        return currentStubResponse;
    }

    public Object verify(Object mock, Integer callCount) {
        isVerifying = true;
        currentExpectedCallCount = callCount;
        return mock;
    }

    /**
     * Inherited from StubProvider.
     * @param stubbedObject The stubbed object.
     * @param stubbedMethodName The name of the invoked method.
     * @param returnType The return type of the invoked method.
     * @param listOfParamTypes A list of the parameter types of the invoked method.
     * @param listOfParamNames A list of the parameter names of the invoked method.
     * @param listOfArgs The actual argument values passed into this method at runtime.
     * @return The stubbed return value. Null by default, unless you prepared one that matches this method and argument values in stubbing.
     */
    public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, Type returnType,
        List<Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
        String methodSignature = getMethodSignature(stubbedObject, stubbedMethodName, listOfArgs);
        if (isStubbing) {
            createStubResponse(methodSignature);
            return null;
        } else if (isVerifying) {
            if (methodSignature2StubResponse.get(methodSignature) == null) {
                throw new MockingException(
                    String.format('Method {0} was never mocked.', new List<String> {
                        methodSignature
                    })
                );
            }
            System.assertEquals(currentExpectedCallCount,
                methodSignature2StubResponse.get(methodSignature).callCount,
                String.format('Wrong number of method calls for {0} method.', new List<String> {
                    methodSignature
                })
            );
            isVerifying = false;
            return null;
        } else {
            StubResponse sr = methodSignature2StubResponse.get(methodSignature);
            if (sr == null) {
                return null;
            }
            sr.callCount++;
            if (sr.exceptionToThrow != null) {
                throw sr.exceptionToThrow;
            }
            return sr.response;
        }
    }

    private String getMethodSignature(Object instance, String methodName, List<Object> listOfArgs) {
        return extractTypeName(instance) + '.' + methodName + String.valueOf(listOfArgs);
    }

    private String extractTypeName(Object instance) {
        return String.valueOf(instance).split(':').get(0);
    }

    private void createStubResponse(String methodSignature) {
        currentStubResponse = new StubResponse(methodSignature);
        methodSignature2StubResponse.put(currentStubResponse.methodSignature, currentStubResponse);
    }

    public class StubResponse {
        private String methodSignature;
        private Object response;
        private Exception exceptionToThrow;
        private Integer callCount = 0;

        private StubResponse(String methodSignature) {
            this.methodSignature = methodSignature;
        }

        public void thenReturn(Object response) {
            if (exceptionToThrow != null) {
                throw new MockingException(MSG_RESPONSE_OR_EXCEPTION);
            }
            this.response = response;
        }

        public void thenThrow(Exception exceptionToThrow) {
            if (response != null) {
                throw new MockingException(MSG_RESPONSE_OR_EXCEPTION);
            }
            this.exceptionToThrow = exceptionToThrow;
        }

    }

    public class MockingException extends Exception {}

}