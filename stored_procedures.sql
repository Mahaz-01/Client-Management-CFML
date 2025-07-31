-- =============================================
-- Client Management System Stored Procedures
-- MS SQL Server Version
-- =============================================

-- =============================================
-- Get total client count
-- =============================================
CREATE PROCEDURE [dbo].[spGetClientCount]
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT COUNT(*) AS clientCount 
    FROM clients;
END
GO

-- =============================================
-- Check if client exists by ID
-- =============================================
CREATE PROCEDURE [dbo].[spClientExists]
    @ClientId NVARCHAR(36)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT COUNT(*) AS clientCount 
    FROM clients 
    WHERE id = @ClientId;
END
GO

-- =============================================
-- Get all clients ordered by name
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllClients]
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT id, name, email, phone, company, address, createdDate, modifiedDate
    FROM clients 
    ORDER BY name;
END
GO

-- =============================================
-- Get client by ID
-- =============================================
CREATE PROCEDURE [dbo].[spGetClientById]
    @ClientId NVARCHAR(36)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT id, name, email, phone, company, address, createdDate, modifiedDate
    FROM clients 
    WHERE id = @ClientId;
END
GO

-- =============================================
-- Search clients by name, email, or company
-- =============================================
CREATE PROCEDURE [dbo].[spSearchClients]
    @SearchTerm NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT id, name, email, phone, company, address, createdDate, modifiedDate
    FROM clients 
    WHERE name LIKE @SearchTerm 
       OR email LIKE @SearchTerm 
       OR company LIKE @SearchTerm
    ORDER BY name;
END
GO

-- =============================================
-- Add new client
-- =============================================
CREATE PROCEDURE [dbo].[spAddClient]
    @ClientId NVARCHAR(36),
    @Name NVARCHAR(255),
    @Email NVARCHAR(255),
    @Phone NVARCHAR(50) = NULL,
    @Company NVARCHAR(255) = NULL,
    @Address NVARCHAR(500) = NULL,
    @CreatedDate DATETIME2
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO clients (id, name, email, phone, company, address, createdDate)
    VALUES (@ClientId, @Name, @Email, @Phone, @Company, @Address, @CreatedDate);
END
GO

-- =============================================
-- Update existing client
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateClient]
    @ClientId NVARCHAR(36),
    @Name NVARCHAR(255),
    @Email NVARCHAR(255),
    @Phone NVARCHAR(50) = NULL,
    @Company NVARCHAR(255) = NULL,
    @Address NVARCHAR(500) = NULL,
    @ModifiedDate DATETIME2
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE clients 
    SET name = @Name,
        email = @Email,
        phone = @Phone,
        company = @Company,
        address = @Address,
        modifiedDate = @ModifiedDate
    WHERE id = @ClientId;
END
GO

-- =============================================
-- Delete client by ID
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteClient]
    @ClientId NVARCHAR(36)
AS
BEGIN
    SET NOCOUNT ON;
    
    DELETE FROM clients 
    WHERE id = @ClientId;
END
GO

-- =============================================
-- Get client count for dashboard
-- =============================================
CREATE PROCEDURE [dbo].[spGetDashboardClientCount]
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT COUNT(*) AS total 
    FROM clients;
END
GO 