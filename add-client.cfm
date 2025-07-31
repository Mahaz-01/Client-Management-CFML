<cfif structKeyExists(form, "submit")>
    <cfset newId = createUUID()>
    <cfset currentDateTime = now()>

    <cfstoredproc procedure="spAddClient" datasource="clients">
        <cfprocparam type="in" cfsqltype="cf_sql_varchar" value="#newId#">
        <cfprocparam type="in" cfsqltype="cf_sql_varchar" value="#trim(form.name)#">
        <cfprocparam type="in" cfsqltype="cf_sql_varchar" value="#trim(form.email)#">
        <cfprocparam type="in" cfsqltype="cf_sql_varchar" value="#trim(form.phone)#" null="#not len(trim(form.phone))#">
        <cfprocparam type="in" cfsqltype="cf_sql_varchar" value="#trim(form.company)#" null="#not len(trim(form.company))#">
        <cfprocparam type="in" cfsqltype="cf_sql_varchar" value="#trim(form.address)#" null="#not len(trim(form.address))#">
        <cfprocparam type="in" cfsqltype="cf_sql_timestamp" value="#currentDateTime#">
    </cfstoredproc>

    <cfset session.message = "Client added successfully.">
    <cflocation url="clients.cfm" addtoken="false">
</cfif>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Client - Client Management System</title>
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
                    <li><a href="add-client.cfm" class="active">Add Client</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <div class="form-section">
                <h2>Add New Client</h2>
                <form action="add-client.cfm" method="post" class="client-form">
                    <div class="form-group">
                        <label for="name">Client Name *</label>
                        <input type="text" id="name" name="name" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email *</label>
                        <input type="email" id="email" name="email" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="tel" id="phone" name="phone">
                    </div>

                    <div class="form-group">
                        <label for="company">Company</label>
                        <input type="text" id="company" name="company">
                    </div>

                    <div class="form-group">
                        <label for="address">Address</label>
                        <textarea id="address" name="address" rows="3"></textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" name="submit" class="btn btn-success">Add Client</button>
                        <a href="clients.cfm" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <script src="assets/js/main.js"></script> 
</body>
</html>
