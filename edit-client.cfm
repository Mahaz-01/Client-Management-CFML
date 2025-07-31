<cfparam name="url.id" default="">

<cfif not len(trim(url.id))>
    <cfset session.message = "No client ID provided!">
    <cflocation url="clients.cfm" addtoken="false">
</cfif>

<cfquery name="clientQuery" datasource="clients">
    SELECT * FROM clients WHERE id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif clientQuery.recordCount EQ 0>
    <cfset session.message = "Client not found!">
    <cflocation url="clients.cfm" addtoken="false">
</cfif>

<cfif structKeyExists(form, "submit")>
    <cfquery datasource="clients">
        UPDATE clients
        SET
            name = <cfqueryparam value="#trim(form.name)#" cfsqltype="cf_sql_varchar">,
            email = <cfqueryparam value="#trim(form.email)#" cfsqltype="cf_sql_varchar">,
            phone = <cfqueryparam value="#trim(form.phone)#" cfsqltype="cf_sql_varchar" null="#not len(trim(form.phone))#">,
            company = <cfqueryparam value="#trim(form.company)#" cfsqltype="cf_sql_varchar" null="#not len(trim(form.company))#">,
            address = <cfqueryparam value="#trim(form.address)#" cfsqltype="cf_sql_varchar" null="#not len(trim(form.address))#">
        WHERE id = <cfqueryparam value="#form.id#" cfsqltype="cf_sql_varchar">
    </cfquery>
    <cfset session.message = "Client updated successfully.">
    <cflocation url="clients.cfm" addtoken="false">
</cfif>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Client - Client Management System</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Client Management System</h1>
            <nav>
                <ul>
                    <li><a href="index.cfm">Home</a></li>
                    <li><a href="clients.cfm">Clients</a></li>
                    <li><a href="add-client.cfm">Add Client</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <div class="form-section">
                <h2>Edit Client</h2>
                <form action="edit-client.cfm?id=<cfoutput>#url.id#</cfoutput>" method="post" class="client-form">
                    <input type="hidden" name="id" value="<cfoutput>#clientQuery.id#</cfoutput>">
                    
                    <div class="form-group">
                        <label for="name">Client Name *</label>
                        <input type="text" id="name" name="name" value="<cfoutput>#clientQuery.name#</cfoutput>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email *</label>
                        <input type="email" id="email" name="email" value="<cfoutput>#clientQuery.email#</cfoutput>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="tel" id="phone" name="phone" value="<cfoutput>#clientQuery.phone#</cfoutput>">
                    </div>
                    
                    <div class="form-group">
                        <label for="company">Company</label>
                        <input type="text" id="company" name="company" value="<cfoutput>#clientQuery.company#</cfoutput>">
                    </div>
                    
                    <div class="form-group">
                        <label for="address">Address</label>
                        <textarea id="address" name="address" rows="3"><cfoutput>#clientQuery.address#</cfoutput></textarea>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" name="submit" class="btn btn-primary">Update Client</button>
                        <a href="clients.cfm" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </main>
    </div>
    
    <script src="assets/js/main.js"></script>
</body>
</html>