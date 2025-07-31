<cfquery name="clientCount" datasource="clients">
    {call spGetDashboardClientCount}
</cfquery>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Management System</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Client Management System</h1>
            <nav>
                <ul>
                    <li><a href="index.cfm" class="active">Home</a></li>
                    <li><a href="clients.cfm">Clients</a></li>
                    <li><a href="add-client.cfm">Add Client</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <div class="welcome-section">
                <h2>Welcome to Client Management</h2>                
                <div class="stats">
                    <div class="stat-card">
                        <h3>Total Clients</h3>
                        <p class="stat-number"><cfoutput>#clientCount.total#</cfoutput></p>
                    </div>
                </div>
                
                <div class="quick-actions">
                    <h3>Quick Actions</h3>
                    <a href="clients.cfm" class="btn btn-primary">View All Clients</a>
                    <a href="add-client.cfm" class="btn btn-success">Add New Client</a>
                </div>
            </div>
        </main>
    </div>
    
    <script src="assets/js/main.js"></script>
</body>
</html>
