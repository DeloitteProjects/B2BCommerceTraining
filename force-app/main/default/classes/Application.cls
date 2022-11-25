public with sharing class Application {

    public static final ServiceFactory service = new ServiceFactory(
        new Set<Type> {
            ExampleService.class
        }
    );

    public class ServiceFactory {

        private Set<Type> registeredServices;
        private Map<Type, Object> serviceInterfaceType2MockInstance;

        public ServiceFactory(Set<Type> registeredServices) {
            this.registeredServices = registeredServices;
            this.serviceInterfaceType2MockInstance = new Map<Type, Object>();
        }

        public Object newInstance(Type serviceType) {
            if (!registeredServices.contains(serviceType)) {
                throw new DeveloperException(serviceType.getName() + ' is not registered as a service.');
            }

            if (serviceInterfaceType2MockInstance.containsKey(serviceType)) {
                return serviceInterfaceType2MockInstance.get(serviceType);
            }

            return serviceType.newInstance();
        }

        @TestVisible
        private void setMock(Type serviceType, Object mockInstance) {
            serviceInterfaceType2MockInstance.put(serviceType, mockInstance);
        }

    }

    public class DeveloperException extends Exception {}

}