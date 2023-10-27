type User record {
    string userId;
    string firstName;
    string lastName;
    string jobTitle;
    Department department;
    Role role;
    User supervisor;
    PerformanceRecord[] performanceRecords;
};

enum Role {
  HoD,
  Supervisor,
  Employee
};

type PerformanceRecord record {
    string recordId;
    KPI kpi;
    User employee;
    float score;
    string unitType;
};

enum UnitType {
    PERCENTAGE,
    TIME,
    COUNT,
    CURRENCY,
    SCORE,
    RATIO,
    UNIT,
    DISTANCE
};

type KPI record {
    string kpiId;
    User supervisor;
    string name;
    DepartmentObjective[] objectives;
};

type DepartmentObjective record {
    string objectiveId;
    Department department;
    string name;
    string? description;
    float percentage;
};

type Department record {
    string departmentId;
    string name;
    DepartmentObjective[] objectives;
    User[] employees;
};

type UserInput record {
    string firstName;
    string lastName;
    string jobTitle;
    string departmentId;
    Role roleId;
    string supervisorId?;
};

type PerformanceRecordInput record {
    string kpiId;
    string employeeId;
    float score;
    string unitType;
};

type KPIInput record {
    string name;
    string supervisorId;
};

type DepartmentObjectiveInput record {
    string departmentId;
    string name;
    string description?;
    float percentage;
};
