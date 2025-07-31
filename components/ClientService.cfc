component {

    public numeric function getClientCount() {
        var result = queryExecute(
            "SELECT COUNT(*) as clientCount FROM clients",
            {},
            {datasource: "clients"}
        );
        return result.clientCount[1];
    }

    public boolean function clientExists(required string id) {
        var result = queryExecute(
            "SELECT COUNT(*) as clientCount FROM clients WHERE id = ?",
            [arguments.id],
            {datasource: "clients"}
        );
        return result.clientCount[1] > 0;
    }

    public query function searchClients(required string searchTerm) {
        var term = "%" & trim(arguments.searchTerm) & "%";
        var result = queryExecute(
            "SELECT * FROM clients 
             WHERE name LIKE ? 
             OR email LIKE ? 
             OR company LIKE ?
             ORDER BY name",
            [term, term, term],
            {datasource: "clients"}
        );
        return result;
    }

    public query function getAllClients() {
        var result = queryExecute(
            "SELECT * FROM clients ORDER BY name",
            {},
            {datasource: "clients"}
        );
        return result;
    }

    public query function getClientById(required string id) {
        var result = queryExecute(
            "SELECT * FROM clients WHERE id = ?",
            [arguments.id],
            {datasource: "clients"}
        );
        return result;
    }

    public boolean function addClient(required struct clientData) {
        try {
            var newId = createUUID();
            var currentDateTime = now();
            
            queryExecute(
                "INSERT INTO clients (id, name, email, phone, company, address, createdDate) 
                 VALUES (?, ?, ?, ?, ?, ?, ?)",
                [
                    newId,
                    trim(arguments.clientData.name),
                    trim(arguments.clientData.email),
                    trim(arguments.clientData.phone),
                    trim(arguments.clientData.company),
                    trim(arguments.clientData.address),
                    currentDateTime
                ],
                {datasource: "clients"}
            );
            return true;
        } catch (any e) {
            return false;
        }
    }

    public boolean function updateClient(required string id, required struct clientData) {
        try {
            var result = queryExecute(
                "UPDATE clients 
                 SET name = ?, email = ?, phone = ?, company = ?, address = ?, modifiedDate = ?
                 WHERE id = ?",
                [
                    trim(arguments.clientData.name),
                    trim(arguments.clientData.email),
                    trim(arguments.clientData.phone),
                    trim(arguments.clientData.company),
                    trim(arguments.clientData.address),
                    now(),
                    arguments.id
                ],
                {datasource: "clients"}
            );
            return true;
        } catch (any e) {
            return false;
        }
    }

    public boolean function deleteClient(required string id) {
        try {
            queryExecute(
                "DELETE FROM clients WHERE id = ?",
                [arguments.id],
                {datasource: "clients"}
            );
            return true;
        } catch (any e) {
            return false;
        }
    }
}