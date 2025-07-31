<cfparam name="url.id" default="">

<cfif not len(trim(url.id))>
    <cfset session.message = "No client ID provided!">
    <cflocation url="clients.cfm" addtoken="false">
</cfif>

<cfquery name="checkClient" datasource="clients">
    {call spClientExists(?)}
    <cfqueryparam value="#url.id#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif checkClient.clientCount[1] GT 0>
    <cftry>
        <cfquery datasource="clients">
            {call spDeleteClient(?)}
            <cfqueryparam value="#url.id#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfset session.message = "Client deleted successfully!">
        <cfcatch>
            <cfset session.message = "Error deleting client. Please try again.">
        </cfcatch>
    </cftry>
<cfelse>
    <cfset session.message = "Client not found!">
</cfif>

<cflocation url="clients.cfm" addtoken="false">
