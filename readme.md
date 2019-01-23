# PSDUO - A PowerShell module for DUO
The Admin API provides programmatic access to the administrative functionality of Duo Security's two-factor authentication platform.

### DUO API Reference Methods & Params
https://duo.com/docs/adminapi

## DUO API Call Details

The Module handles most of the rules in order to format the calls properly to Duo's API.

**Base API URL**

https://api-XXXXXXXX.duosecurity.com

All API methods use your API hostname. Methods always use HTTPS. Unsecured HTTP is not supported.

**Request Format**

If the request method is GET or DELETE, URL-encode parameters and send them in the URL query string like this:
/admin/v1/users?realname=First%20Last&username=root. They still go on a separate line when creating the string to sign for an Authorization header.

Send parameters for POST requests in the body as URL-encoded key-value pairs (the same request format used by browsers to submit form data).
The header “Content-Type: application/x-www-form-urlencoded” must also be present.

When URL-encoding, all bytes except ASCII letters, digits, underscore (“_”), period (“.”), tilde (“~”), and hyphen (“-“) are replaced by a percent sign
(“%”) followed by two hexadecimal digits containing the value of the byte. For example, a space is replaced with “%20” and an at-sign (“@”) becomes “%40”.
Use only upper-case A through F for hexadecimal digits.

**Response Format**

Responses are formatted as a JSON object with a top-level stat key.
Successful responses will have a stat value of “OK” and a response key. The response will either be a single object or a sequence of other JSON types, depending on which endpoint is called.

# Getting Started
## Download or Clone the module
    git clone https://github.com/PWSHNinja/PSDuo.git

Save it wherever you would like, or directly to a $PSModulePath and
Import the module into PowerShell

```powershell
Import-Module PSDuo
Or
Import-Module C:\{PathTo}\PSDUO\PSDUO.PSM1
```

```powershell
Get-Command -Module PSDUO
    CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Convertto-DuoRequest                               0.1        PSDuo
Function        Get-DUOuser                                        0.1        PSDuo
Function        Invoke-DuoAuth                                     0.1        PSDuo
Function        Invoke-DuoPreAuth                                  0.1        PSDuo
Function        New-DuoConfig                                      0.1        PSDuo
Function        New-DUOuser                                        0.1        PSDuo
Function        Set-Duouser                                        0.1        PSDuo

New-DuoConfig [-iKey] <String> [-sKey] <String> [-apiHost] <String> [-SaveConfig] [<CommonParameters>]
```