--DROP TRIGGER AOTriggerAfterUpdateHTKBAdminLevel

CREATE TRIGGER AOTriggerAfterUpdateHTKBAdminLevel
ON Users
AFTER Update
AS
	
GO