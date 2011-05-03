Feature: Basic create / login features

   Scenario: Users can create an account and log in
      Given there are no accounts in the accounts database
      When I create an account with username "frank" and password "p@ssw0rd"
      Then the system response should be "Account created"
      When I attempt to login with username "frank" and password "p@ssw0rd"
      Then the system response should be "Welcome!"

   Scenario: Users cannot create an account if the account name already exists
      When I attempt to create an account with a username that already exists
      Then the system response should be "Account already exists"

   Scenario: Users cannot login with wrong password
      When I create an account with username "michael" and password "p@ssw0rd"
      When I attempt to login with username "michael" and password "bad"
      Then the system response should be "Access denied"

   Scenario: Passwords are case sensitive
      When I create an account with username "fred" and password "p@ssw0rd"
      When I attempt to login with username "fred" and password "P@ssW0rd"
      Then the system response should be "Access denied"

   Scenario: Usernames are case sensitive
      When I create an account with username "fred" and password "p@ssw0rd"
      When I attempt to login with username "Fred" and password "p@ssW0rd"
      Then the system response should be "Access denied"

   Scenario: Account information is persisted
      When I create an account with username "fred" and password "p@ssw0rd"
      Then the accounts database should contain an account "fred" / "p@ssw0rd" in state "active"
  