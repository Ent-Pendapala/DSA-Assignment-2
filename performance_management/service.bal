import ballerina/io;
import ballerinax/mysql;

// Define database configurations
mysql:ClientEndpointConfig dbConfig = {
    host: "localhost",
    port: 3306,
    username: "root",
    password: "canopisA88",
    dbOptions: { useSSL: false, allowPublicKeyRetrieval: true }
};

// Create a MySQL client
mysql:Client dbClient = new (dbConfig);

// Function to insert a new user into the database
public function insertUser(UserInput user) returns User {
    var insertQuery = `INSERT INTO Users (firstName, lastName, jobTitle, userRole, departmentId, supervisorId)
                       VALUES (?, ?, ?, ?, ?, ?)`;
    var result = dbClient->executeUpdate(insertQuery, user.firstName, user.lastName, user.jobTitle, user.roleId.toString(),
                                         user.departmentId, user.supervisorId);
    if (result is int) {
        // Successfully inserted, return the user object with generated userId
        return {userId: result.toString(), ...user};
    } else {
        // Handle the error
        io:println("Error: Failed to insert user - " + result.toString());
        return ();
    }
}

// Function to retrieve a user by userId
public function getUserById(int userId) returns User? {
    var selectQuery = "SELECT * FROM Users WHERE userId = ?";
    var result = dbClient->select(selectQuery, userId);
    if (result is table<mysql:Record>) {
        if (table:hasData(result)) {
            var userRecord = table:getFirst(result);
            User user = {
                userId: userRecord.getInt("userId").toString(),
                firstName: userRecord.getString("firstName"),
                lastName: userRecord.getString("lastName"),
                jobTitle: userRecord.getString("jobTitle"),
                department: userRecord.getInt("departmentId").toString(),
                role: Role.fromString(userRecord.getString("userRole")),
                supervisor: userRecord.getInt("supervisorId").toString(),
                performanceRecords: [] // You may fetch performance records here
            };
            return user;
        } else {
            // No data found
            return ();
        }
    } else {
        // Handle the error
        io:println("Error: Failed to retrieve user - " + result.toString());
        return ();
    }
}

