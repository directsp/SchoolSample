CREATE PROCEDURE [dspUtil].[MakePassword]
    @Password TSTRINGA, -- NO Unicode Support
    @Algorithm TSTRING = NULL,
    @Iteration INT = 30000,
    @Salt TSTRINGA = NULL , -- NO Unicode Support
    @PasswordString TSTRING OUT
AS
BEGIN
    SET @Algorithm = LOWER(ISNULL(@Algorithm, dspUtil.Algorithm_PBKDF2_SHA512()));
    IF ( @Algorithm = LOWER(dspUtil.Algorithm_PBKDF2_SHA512()) )
    BEGIN
    
        IF ( @Salt IS NULL )
            EXEC dspUtil.GenerateRandomString @Length = 20, @randomString = @Salt OUTPUT;
        DECLARE @PasswordHash TSTRING;
        SET @PasswordHash = dspUtil.Convert_BinaryToBase64(dspUtil.CRYPT_PBKDF2_VARBINARY_SHA512(CAST(@Password AS VARBINARY(MAX)), CAST(@Salt AS VARBINARY(MAX)),
                                                                                           @Iteration, 64));
	   SET @PasswordString = @Algorithm + '$' + dspUtil.ToString(@Iteration) + '$' + @Salt + '$' + @PasswordHash;
    END;
END;