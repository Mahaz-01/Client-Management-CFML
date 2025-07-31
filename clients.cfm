<cfquery name="clients" datasource="clients">
    {call spGetAllClients}
</cfquery>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clients - Client Management System</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Client Management System</h1>
            <nav>
                <ul>
                    <li><a href="index.cfm">Home</a></li>
                    <li><a href="clients.cfm" class="active">Clients</a></li>
                    <li><a href="add-client.cfm">Add Client</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <div class="clients-section">
                <div class="section-header">
                    <h2>Client List</h2>
                    <a href="add-client.cfm" class="btn btn-success">Add New Client</a>
                </div>
                
                <cfif structKeyExists(session, "message") AND len(session.message)>
                    <div class="alert alert-success">
                        <cfoutput>#session.message#</cfoutput>
                    </div>
                    <cfset session.message = "">
                </cfif>
                
                <cfif clients.recordCount GT 0>
                    <div class="clients-table">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Company</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <cfoutput query="clients">
                                    <tr>
                                        <td>#id#</td>
                                        <td>#name#</td>
                                        <td>#email#</td>
                                        <td>#phone#</td>
                                        <td>#company#</td>
                                        <td class="actions">
                                            <a href="edit-client.cfm?id=#id#" class="btn btn-small btn-primary">Edit</a>
                                            <a href="delete-client.cfm?id=#id#" class="btn btn-small btn-danger" onclick="return confirm('Are you sure you want to delete this client?')">Delete</a>
                                        </td>
                                    </tr>
                                </cfoutput>
                            </tbody>
                        </table>
                    </div>
                <cfelse>
                    <div class="empty-state">
                        <h3>No clients found</h3>
                        <a href="add-client.cfm" class="btn btn-primary">Add First Client</a>
                    </div>
                </cfif>
            </div>
        </main>
    </div>
    
</body>
</html>
