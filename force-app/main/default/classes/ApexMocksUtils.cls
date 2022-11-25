/**
 * Provides various mocking-related utilities.
 * Simplified version off fflib_ApexMocksUtils
 *
 * @author Bartosz Sliwinski (bsliwinski@deloittece.com)
 * @date November 2020
 */
@IsTest
public inherited sharing class ApexMocksUtils {

    /**
     * Provides ability to add child records to a parent (e.g. Account.Contacts).
     * Creates new instances of records in the process.
     *
     * @param parent Parent record to be populated
     * @param relationshipField SObjectField from child object (e.g. Contact.AccountId)
     * @param children Child records to be added to parent
     *
     * @return New instance of parent record with children added
     */
    public static SObject makeRelationship(SObject parent, SObjectField relationshipField, List<SObject> children) {
        List<Schema.ChildRelationship> childRelationships = parent.getSObjectType().getDescribe().getChildRelationships();
        String relationshipName;
        for (Integer i = 0, j = childRelationships.size(); i < j; i++) {
            ChildRelationship childRelationship = childRelationships[i];
            if (childRelationship.getField() == relationshipField) {
                relationshipName = childRelationship.getRelationshipName();
                break;
            }
        }

        Map<String, Object> genericObject = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(parent));
        genericObject.put(relationshipName, new ChildrenNode(children));
        return (SObject) JSON.deserialize(JSON.serialize(genericObject), SObject.class);
    }

    private class ChildrenNode {

        private Integer totalSize;
        private Boolean done = true;
        private List<SObject> records;

        private ChildrenNode(List<SObject> childRecords) {
            this.records = childRecords;
            totalSize = childRecords.size();
        }

    }

}