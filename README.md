# Group2NetworkingProject
Sparta Week 11 Networking Project

A multi-user framework that would allow the users to create their own profiles and to add their apps/packages/components as items.
The user can:
*Create to their profiles
*Login to their profiles
*Add/Delete/List the apps/packages/components


##AWS Infrastructure
Apps, Database , Bastion and Proxies are isolated in their own subnets with zero trust model. This is done through individually configuring each NACL and security group for each of the servers.
###App Webserver
Here the specified subnet, route table association, NACL, security group, instance and record53 are created for the app webserver.
3 servers will be created when terraform is applied with the same specifications as the others using count. All their public IP addresses are stored in records. These servers can connect to the internet as they are associated to a route table that allows access to the internet gateway.
###Database
The database contains the hashed passwords of the user’s profiles. Connected through the 3306 port defined in the applications.properties file as well as the given port in the security group. This port allows only MySQL commands to pass through to the database and make the changes. The database is only accessible by the app webserver and the bastion webserver.
###Bastion
The Bastion's purpose is to allow the user access to the private network which in this case are the apps at the IP 10.15.1.0/24.
###Proxy
Implemented a Load Balancer which balances requests to a group of servers that do the same job.

##Security
Login
There is encrypted communication between the user and the proxy. There is no exchange of any sensitive information such as the IP. Having the load balancer ensures that the servers will not know about the
###Ansible

###Jenkins


## Signup

For user to register use the following endpoint:

**POST** `https://[IP address]/auth/signup`

It will also require JSON body, Example to create account for Mike:

```json
{
    "firstname" : "Mike",
    "lastname" : "Smith",
    "username" : "Smith1232133",
    "password" : "bluecat123"
}
```


### Singin

For user to log in with registered account use follwoing endpoint:

**POST** `https://[IP address]/auth/signin`

It will also require JSON body containing login details, example for Mike:

```JSon
{
    "username" : "Smith1232133",
    "password" : "bluecat123"
}
```

This will return Token which will be used for every request, Example of token for Mike:

```
Session Token: eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJTbWl0aDEyMzIxMzMifQ.iR7-GTRaMnxbTtL0w4Hf6oIDStktSSkLPyL_k6bBw5o
```

### Test connection

To test if account is valid, use the following endpoint with **token**:

Example with Mike's token:

**GET** `https://[IP address]/auth/test?token=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJTbWl0aDEyMzIxMzMifQ.iR7-GTRaMnxbTtL0w4Hf6oIDStktSSkLPyL_k6bBw5o`

Response:

```
Authorized
```
### Add Item

To add an item to list use the following endpoint:

Example for Mike account:

**POST** `https://[IP address]/items/add?token=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJTbWl0aDEyMzIxMzMifQ.iR7-GTRaMnxbTtL0w4Hf6oIDStktSSkLPyL_k6bBw5o`

This request will take JSON body, Example:

```json
{
    "item":"tree"
}
```

Response:

```
Item added for Mike
```

### Get list of items

To see list for given account use the following endpoint:

Example for Mike's list:

GET `https://[IP address]/items/all?token=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJTbWl0aDEyMzIxMzMifQ.iR7-GTRaMnxbTtL0w4Hf6oIDStktSSkLPyL_k6bBw5o`

Response

```json
[
    {
        "id": 1,
        "item": "nginx"
    },
    {
        "id": 2,
        "item": "tree"
    },
    {
        "id": 3,
        "item": "nano"
    }
]
```

### Delete item
To delete item from list use the following end point:

Takes two parameters:

1. ID of item
2. Token

Example to delete item from Mike's list:

DELETE `https://[IP address]/items/delete?id=1&token=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJTbWl0aDEyMzIxMzMifQ.iR7-GTRaMnxbTtL0w4Hf6oIDStktSSkLPyL_k6bBw5o`

Response

```json
{
    "Deleted": true
}
```
