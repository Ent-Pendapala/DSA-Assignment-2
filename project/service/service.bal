import ballerina/graphql;

configurable int port = 9090;

service schema on new graphql:Listener(port) {

    postgresql:Client|sql:Error dbClient = new ("localhost", "postgres", "marcusaggripa20!","dsa", 5432);
    resource function get getDepartmentalScores(string departmentName) returns float? {
        sql:ParameterizedQuery query = SELECT score FROM department;  
        stream<Department, error?> resultStream = check dbClient->query(query);

        check from record {} score in resultStream
            do {
                io:println("The" +  departmentname + "score is: " + score.value["score"]);
            }; 
    }

    remote function assignHodToDepartment(string hodID, string departmentName) returns departmentAssignment? {
    }

    remote function assignEmployeeToSupervisor(string employeeID, string supervisorID) returns employeeAssignment? {

    }

    remote function gradeEmployeePerformance(string employeeID, float score) returns EmployeeGrade? {
    }

    remote function createDepartmentObjectives(string departmentName) returns string[]{

    }

    remote function deleteDepartmentObjective(string departmentName) returns string{

    }

    remote function addKPI(){

    }

    remote function deleteKPI(int employeeStaffNumber) returns string{

    }

    remote function updateKPI(int employeeStaffNumber) returns string{

    }

    remote function viewEmployeeScore(int employeeStaffNumber) returns Employee{

    }

    remote function createSupervisorScore(int supervisorStaffNumber) return{

    }
    remote function get employeeScore(int employeeStaffNumber)


}
