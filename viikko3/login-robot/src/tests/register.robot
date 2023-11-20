*** Settings ***
Resource  resource.robot
Test Setup  Create Test User

*** Test Cases ***
Register With Valid Username And Password
    Input  new
    Input Credentials  pasi  pasi1234
    Output Should Contain  New user registered
     

Register With Already Taken Username And Valid Password
    Input  new
    Input Credentials  kalle  kalle123
    Output Should Contain  User with username kalle already exists

Register With Too Short Username And Valid Password
    Input  new
    Input Credentials  ka  kalle123
    Output Should Contain  Käyttäjätunnuksen pituuden tulee tulee olla ainakin 3 merkkiä

Register With Enough Long But Invalid Username And Valid Password
    Input  new
    Input Credentials  kalle1  kalle123
    Output Should Contain  Käyttäjätunnuksen tulee koostua merkeistä a-z

Register With Valid Username And Too Short Password
    Input  new
    Input Credentials  pasi  pasi123
    Output Should Contain  Salasanan pituuden tulee tulee olla ainakin 8 merkkiä


Register With Valid Username And Long Enough Password Containing Only Letters
    Input  new
    Input Credentials  pasi  pasipasi
    Output Should Contain  Salasana ei saa koostua pelkästään kirjaimista a-z

*** Keywords ***
Create Test User
    Create User  kalle  kalle123


