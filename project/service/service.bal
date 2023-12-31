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

    remote function assignHodToDepartment(string hodStaffNumber, string departmentName) returns departmentAssignment? {
        sql:ParameterizedQuery query = `INSERT INTO department(hod_staff_number, department_name)
                                  VALUES (${hodStaffNumber}, ${departmentName})`;
        sql:ExecutionResult result = check dbClient->execute(query);
    }

    remote function assignEmployeeToSupervisor(string supervisorStaffNumber, string employeeStaffNumber) returns employeeAssignment? {
        sql:ParameterizedQuery query = `INSERT INTO supervisor(supervisor_staff_number, employee_staff_number)
                                  VALUES (${supervisorStaffNumber}, ${employeeStaffNumber})`;
        sql:ExecutionResult result = check dbClient->execute(query);

        sql:ParameterizedQuery query2 = `INSERT INTO employee(employee_staff_number, supervisor_staff_number)
                                  VALUES (${employeeStaffNumber}, ${supervisorStaffNumber})`;
        sql:ExecutionResult result2 = check dbClient->execute(query2);        
    }

    remote function gradeEmployeePerformance(string employeeStaffNumber, int employeeScore) returns EmployeeGrade? {
        sql:ParameterizedQuery query = `INSERT INTO employee(department_name, employee_score)
                                  VALUES (${employeeStaffNumber}, ${employeeScore})`;
        sql:ExecutionResult result = check dbClient->execute(query);
    }

    remote function createDepartmentObjectives(string departmentName, string[] objectives) returns string[]{
        sql:ParameterizedQuery query = `INSERT INTO department(department_name, objectives)
                                  VALUES (${departmentName}, ${objectives})`;
        sql:ExecutionResult result = check dbClient->execute(query);
    }

    remote function deleteDepartmentObjective(string departmentName, string objective) returns string{
        sql:ParameterizedQuery query = `DELETE from department WHERE objective = ${objective}`;
        sql:ExecutionResult result = check dbClient->execute(query);
    }

    remote function addKPI(int employeeStaffNumber, 
    int studentPassrate,
    int researchOutput,
    string supervisorOpinion,
    string peerOpinion  ){
        sql:ParameterizedQuery query = `INSERT INTO employee(employee_staff_number, student_passrate, research_output, supervisor_opinion, peer_opinion)
                                  VALUES (${employeeStaffNumber}, ${studentPassrate},${researchOutput}, ${supervisorOpinion}, ${peerOpinion} )`;
        sql:ExecutionResult result = check dbClient->execute(query);
    }

    remote function deleteKPI(int employeeStaffNumber, 
    int studentPassrate,
    int researchOutput,
    string supervisorOpinion,
    string peerOpinion  ) returns string{

        sql:ParameterizedQuery query = `DELETE from employee WHERE employee_staff_number = ${employeeStaffNumber}`;
        sql:ExecutionResult result = check dbClient->execute(query);
    }

    remote function updateKPI(int employeeStaffNumber, 
    int studentPassrate,
    int researchOutput,
    string supervisorOpinion,
    string peerOpinion ) returns string{

        sql:ParameterizedQuery query = `UPDATE employee SET name = ${employeeStaffNumber} WHERE student_passrate = ${studentPassrate}`;
        sql:ExecutionResult result = check dbClient->execute(query);

        sql:ParameterizedQuery query2 = `UPDATE employee SET name = ${employeeStaffNumber} WHERE research_output = ${researchOutput}`;
        sql:ExecutionResult result2 = check dbClient->execute(query2);

        sql:ParameterizedQuery query3 = `UPDATE employee SET name = ${employeeStaffNumber} WHERE supervisor_opinion = ${supervisorOpinion}`;
        sql:ExecutionResult result3 = check dbClient->execute(query3);


        sql:ParameterizedQuery query4 = `UPDATE employee SET name = ${employeeStaffNumber} WHERE peer_opinion = ${peerOpinion}`;
        sql:ExecutionResult result4 = check dbClient->execute(query4);


    }

    remote function createSupervisorScore(int supervisorStaffNumber, int supervisorScore) return{
        sql:ParameterizedQuery query = `INSERT INTO supervisor(supervisor_staff_number, supervisor_score)
                                  VALUES (${supervisorStaffNumber}, ${supervisorScore})`;
        sql:ExecutionResult result = check dbClient->execute(query);
    }
    remote function get employeeScore(int employeeStaffNumber)
        sql:ParameterizedQuery query = SELECT employee_score FROM employee;  
        stream<Employee, error?> resultStream = check dbClient->query(query);

        check from record {} employee_score in resultStream
            do {
                io:println("The employee with staff number: " +  employeeStaffNumber + "has a score of : " + employee_score.value["employee_score"]);
            }; 
    }

}
