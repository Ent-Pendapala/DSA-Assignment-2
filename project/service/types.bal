import ballerina/graphql;

type schema service object {
    *graphql:Service;
    resource function get getDepartmentalScores(string departmentName) returns float?;
    remote function assignHodToDepartment(string hodID, string departmentName) returns departmentAssignment?;
    remote function assignEmployeeToSupervisor(string employeeID, string supervisorID) returns employeeAssignment?;
    remote function gradeEmployeePerformance(string employeeID, float score) returns EmployeeGrade?;
};

public type EmployeeGrade record {|
    string employeeStaffNumber;
    int score;
|};

public type departmentAssignment record {|
    string hodID;
    string departmentName;
|};

public type Department record {|
    readonly string departmentName;
    string[] objectives;
    string description;
    float percentage;
|};

public type Employee record {|
    readonly int employeeStaffNumber;
    string firstName;
    string lastName;
    string jobTitle;
    string department;
    string role;
    int supervisorStaffNumber;
    int employeeScore;
|};

public type employeeAssignment record {|
    string employeeStaffNumber;
    string supervisorStaffNumber;
|};

public type HOD record {|
    readonly int hodStaffNumber;
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
    readonly int supervisorStaffNumber;
    string firstName;
    string lastName;
    string jobTitle;
    string role;
    int supervisorScore;
    string departmentName;
    int[] employeeStaffNumber
|};
