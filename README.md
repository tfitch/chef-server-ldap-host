# chef-server-ldap-host

This will create a Windows 2012r2 Server with an AD domain of `chefio.local` and users `chef1` through `chef10`

## Machine restart will happen
When running in Test Kitchen you need to run `kitchen converge` twice.  Wait until the VM is running again before the second `converge`.  This can take a minute or two, so running `converge` immediately won't count as a "second run".

Joining the AD domain causes a restart of the server in the middle of the recipe run.  Normally this is fine, but Test Kitchen will say there's an "error".  Thus the two `kitchen converge` commands.

## TODO:
* Put a SSO frontend on the Domain controller

## Verify the AD domain is running
Run the command

`ldapsearch -LLL -H ldap://localhost:8389 -b 'CN=Users,DC=chefio,DC=local' -D 'CN=Chef 2,CN=Users,DC=chefio,DC=local' -W '(sAMAccountName=chef2)’`

and when prompted enter the password `Passw0rd`

You should get a reply that looks like
```
dn: CN=Chef 2,CN=Users,DC=chefio,DC=local
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: user
cn: Chef 2
sn: 2
givenName: Chef
distinguishedName: CN=Chef 2,CN=Users,DC=chefio,DC=local
instanceType: 4
whenCreated: 20151021224001.0Z
whenChanged: 20151021224015.0Z
displayName: 2, Chef
uSNCreated: 12837
uSNChanged: 12892
name: Chef 2
objectGUID:: GvOItLO13U+YyG4jn2aSGQ==
userAccountControl: 512
badPwdCount: 0
codePage: 0
countryCode: 0
badPasswordTime: 0
lastLogoff: 0
lastLogon: 0
pwdLastSet: 130899408012794471
primaryGroupID: 513
objectSid:: AQUAAAAAAAUVAAAAkPIV0+qgSnox1+5SUgQAAA==
accountExpires: 9223372036854775807
logonCount: 0
sAMAccountName: chef2
sAMAccountType: 805306368
userPrincipalName: chef2@chefio.local
objectCategory: CN=Person,CN=Schema,CN=Configuration,DC=chefio,DC=local
dSCorePropagationData: 16010101000000.0Z
lastLogonTimestamp: 130899408152804203
```
