CREATE SCHEMA [api]
    AUTHORIZATION [dbo];


GO
GRANT EXECUTE
    ON SCHEMA::[api] TO [ApiCallers];


GO
EXECUTE sp_addextendedproperty @name = N'InvokerApi', @value = N'1', @level0type = N'SCHEMA', @level0name = N'api';

