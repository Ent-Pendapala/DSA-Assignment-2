import ballerina/graphql;

type schema service object {
    *graphql:Service;
    resource function get getDepartmentalScores(string departmentName) returns float?;
    remote function assignHodToDepartment(string hodID, string departmentName) returns departmentAssignment?;
    remote function assignEmployeeToSupervisor(string employeeID, string supervisorID) returns employeeAssignment?;
    remote function gradeEmployeePerformance(string employeeID, float score) returns EmployeeGrade?;
};

public type EmployeeGrade record {|
    string employeeID;
    float score;
|};

public type departmentAssignment record {|
    string hodID;
    string departmentName;
|};

public type departmentObjectives record {|
    string departmentID;
    string departmentName;
    string objectiveName;
    string description;
    float percentage;
|};

public type employee record {|
    string employeeID;
    string firstName;
    string lastName;
    string job;
    string departmentName;
    int supervisorID;
|};

public type employeeAssignment record {|
    string employeeID;
    string supervisorID;
|};

public type hod record {|
    string hodID;
    string firstName;
    string lastName;
    string position;
    string departmentName;
|};

public type kpi record {|
    string kpiID;
    int supervisorID;
    string kpiName;
    int kpiValue;
|};

public type performanceRecord record {|
    string performanceRecordID;
    int employeeID;
    int kpiID;
    float employeeScore;
|};

public type supervisor record {|
    string supervisorID;
    string firstName;
    string lastName;
    string position;
    string departmentName;
|};
