component {

    public numeric function getClientCount() {
        var result = queryExecute(
            "{call spGetClientCount}",
            {},
            {datasource: "clients"}
        );
        return result.clientCount[1];
    }

    public boolean function clientExists(required string id) {
        var result = queryExecute(
            "{call spClientExists(?)}",
            [arguments.id],
            {datasource: "clients"}
        );
        return result.clientCount[1] > 0;
    }

    public query function searchClients(required string searchTerm) {
        var term = "%" & trim(arguments.searchTerm) & "%";
        var result = queryExecute(
            "{call spSearchClients(?)}",
            [term],
            {datasource: "clients"}
        );
        return result;
    }

    public query function getAllClients() {
        var result = queryExecute(
            "{call spGetAllClients}",
            {},
            {datasource: "clients"}
        );
        return result;
    }

    public query function getClientById(required string id) {
        var result = queryExecute(
            "{call spGetClientById(?)}",
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
                "{call spAddClient(?, ?, ?, ?, ?, ?, ?)}",
                [
                    newId,
                    trim(arguments.clientData.name),
                    trim(arguments.clientData.email),
                    len(trim(arguments.clientData.phone)) ? trim(arguments.clientData.phone) : javacast("null", ""),
                    len(trim(arguments.clientData.company)) ? trim(arguments.clientData.company) : javacast("null", ""),
                    len(trim(arguments.clientData.address)) ? trim(arguments.clientData.address) : javacast("null", ""),
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
                "{call spUpdateClient(?, ?, ?, ?, ?, ?, ?)}",
                [
                    arguments.id,
                    trim(arguments.clientData.name),
                    trim(arguments.clientData.email),
                    len(trim(arguments.clientData.phone)) ? trim(arguments.clientData.phone) : javacast("null", ""),
                    len(trim(arguments.clientData.company)) ? trim(arguments.clientData.company) : javacast("null", ""),
                    len(trim(arguments.clientData.address)) ? trim(arguments.clientData.address) : javacast("null", ""),
                    now()
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
                "{call spDeleteClient(?)}",
                [arguments.id],
                {datasource: "clients"}
            );
            return true;
        } catch (any e) {
            return false;
        }
    }
}