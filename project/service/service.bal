import ballerina/graphql;

configurable int port = 9090;

service schema on new graphql:Listener(port) {
    resource function get getDepartmentalScores(string departmentName) returns float? {
    }

    remote function assignHodToDepartment(string hodID, string departmentName) returns departmentAssignment? {
    }

    remote function assignEmployeeToSupervisor(string employeeID, string supervisorID) returns employeeAssignment? {
    }

    remote function gradeEmployeePerformance(string employeeID, float score) returns EmployeeGrade? {
    }
}
