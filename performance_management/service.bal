import ballerina/config;
import ballerina/mysql;

// Define a MySQL data source configuration
mysql:DataSourceConfiguration dataSourceConfig = {
    host: config:getAsString("database.host"),
    port: config:getAsString("database.port"),
    username: config:getAsString("database.username"),
    password: config:getAsString("database.password"),
    databaseName: config:getAsString("database.name"),
    options: {}
};

// Create a MySQL client using the data source configuration
mysql:Client mysqlClient = new (dataSourceConfig);

function getUsers() returns User[] {
    var query = "SELECT * FROM Users";
    var result = mysqlClient->select(query);
    var users = check getMappedResults(result, User);
    return users;
}
