<cfcomponent>
    <cfscript>
        this.name = "ClientManagementApp";
        this.applicationTimeout = createTimeSpan(0, 2, 0, 0);
        this.sessionManagement = true;
        this.sessionTimeout = createTimeSpan(0, 0, 30, 0);
        this.setClientCookies = true;

        function onApplicationStart() {
            return true;
        }

        function onSessionStart() {
            session.message = "";
            return true;
        }

        function onRequestStart(targetPage) {
            return true;
        }
    </cfscript>
</cfcomponent>