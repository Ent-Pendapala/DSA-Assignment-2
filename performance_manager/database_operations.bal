import ballerina/io;
import mysql/mysql.driver;

// Create a MySQL client configuration.
mysql:ClientConfiguration userDBConfig = {
    host: "localhost",
    port: 3306,
    username: "root",
    password: "canopisA88",
    dbOptions: { useSSL: false } // Adjust options as needed.
};

// Initialize the MySQL client.
mysql:Client userDB = new (userDBConfig);

// View all users.
function viewAllUsers() returns json {
    var result = userDB->select("SELECT * FROM Users");
    return result;
}

// View a user by ID.
function viewUserById(int userId) returns json {
    var result = userDB->select("SELECT * FROM Users WHERE userId = ?", userId);
    return result;
}

// Insert a new user.
function insertUser(UserInput userInput) returns int {
    var result = userDB->insert("INSERT INTO Users (firstName, lastName, jobTitle, userRole, departmentId, supervisorId) VALUES (?,?,?,?,?,?)",
            userInput.firstName, userInput.lastName, userInput.jobTitle, userInput.roleId.toString(), userInput.departmentId, userInput.supervisorId);
    return result.lastInsertId;
}

// Update an existing user.
function updateUser(int userId, UserInput userInput) returns int {
    var result = userDB->update("UPDATE Users SET firstName=?, lastName=?, jobTitle=?, userRole=?, departmentId=?, supervisorId=? WHERE userId=?",
            userInput.firstName, userInput.lastName, userInput.jobTitle, userInput.roleId.toString(), userInput.departmentId, userInput.supervisorId, userId);
    return result.affectedRows;
}

// Delete a user by ID.
function deleteUser(int userId) returns int {
    var result = userDB->delete("DELETE FROM Users WHERE userId=?", userId);
    return result.affectedRows;
}

// View all departments.
function viewAllDepartments() returns json {
    var result = departmentDB->select("SELECT * FROM Departments");
    return result;
}

// View a department by ID.
function viewDepartmentById(int departmentId) returns json {
    var result = departmentDB->select("SELECT * FROM Departments WHERE departmentId = ?", departmentId);
    return result;
}

// Insert a new department.
function insertDepartment(DepartmentObjectiveInput departmentInput) returns int {
    var result = departmentDB->insert("INSERT INTO Departments (departmentName) VALUES (?)", departmentInput.name);
    return result.lastInsertId;
}

// Update an existing department.
function updateDepartment(int departmentId, DepartmentObjectiveInput departmentInput) returns int {
    var result = departmentDB->update("UPDATE Departments SET departmentName=? WHERE departmentId=?", departmentInput.name, departmentId);
    return result.affectedRows;
}

// Delete a department by ID.
function deleteDepartment(int departmentId) returns int {
    var result = departmentDB->delete("DELETE FROM Departments WHERE departmentId=?", departmentId);
    return result.affectedRows;
}

// View all KPIs.
function viewAllKPIs() returns json {
    var result = kpiDB->select("SELECT * FROM KPIs");
    return result;
}

// View a KPI by ID.
function viewKPIById(int kpiId) returns json {
    var result = kpiDB->select("SELECT * FROM KPIs WHERE kpiId = ?", kpiId);
    return result;
}

// Insert a new KPI.
function insertKPI(KPIInput kpiInput) returns int {
    var result = kpiDB->insert("INSERT INTO KPIs (supervisorId, kpiName) VALUES (?, ?)", kpiInput.supervisorId, kpiInput.name);
    return result.lastInsertId;
}

// Update an existing KPI.
function updateKPI(int kpiId, KPIInput kpiInput) returns int {
    var result = kpiDB->update("UPDATE KPIs SET supervisorId=?, kpiName=? WHERE kpiId=?", kpiInput.supervisorId, kpiInput.name, kpiId);
    return result.affectedRows;
}

// Delete a KPI by ID.
function deleteKPI(int kpiId) returns int {
    var result = kpiDB->delete("DELETE FROM KPIs WHERE kpiId=?", kpiId);
    return result.affectedRows;
}