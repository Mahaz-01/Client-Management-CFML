<cfparam name="url.id" default="">

<cfif not len(trim(url.id))>
    <cfset session.message = "No client ID provided!">
    <cflocation url="clients.cfm" addtoken="false">
</cfif>

<cfstoredproc procedure="spClientExists" datasource="clients">
    <cfprocparam type="in" cfsqltype="cf_sql_varchar" value="#url.id#">
    <cfprocresult name="checkClient">
</cfstoredproc>

<cfif checkClient.clientCount[1] GT 0>
    <cftry>
        <cfstoredproc procedure="spDeleteClient" datasource="clients">
            <cfprocparam type="in" cfsqltype="cf_sql_varchar" value="#url.id#">
        </cfstoredproc>
        <cfset session.message = "Client deleted successfully!">
        <cfcatch>
            <cfset session.message = "Error deleting client. Please try again.">
        </cfcatch>
    </cftry>
<cfelse>
    <cfset session.message = "Client not found!">
</cfif>

<cflocation url="clients.cfm" addtoken="false">
