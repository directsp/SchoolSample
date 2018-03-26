
/*
#MetaStart 
{
	"ExecuteMode": "ReadSnapshot" 
} 
#MetaEnd
*/

CREATE PROCEDURE [api].[System_Api]
	@Context TCONTEXT OUTPUT, @Api TJSON = NULL OUT
WITH EXECUTE AS OWNER
AS
BEGIN
	EXEC dbo.Context_Verify @Context = @Context OUT, @ProcId = @@PROCID;

	-- Call dspUtil
	EXEC dspUtil.Metadata_StoreProcedures @Json = @Api OUTPUT;
END;