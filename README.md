# Blocipedia: A Wiki Collaboration Tool

Blocipedia is a Wiki app that allows users to collaborate on public and private wikis. Blocipedia also features three types of users: standard, premium, and admin. This app uses the Pundit gem for authorization and the Devise gem for authentication of users.

## Blocipedia has the ability to:

* create a new standard user account with an email address and password
* edit existing wikis that are public as a standard user
* upgrade to premium status via the stripe gem so you can create public and private wikis, delete wikis you've created, and add collaborators to wikis you've created.
* downgrade back from a premium to a standard user, which makes all of your private wikis become public
* delete your user account, which deletes any wikis you created
 * create, edit, or delete any wiki as an admin
 * use markdown via the redcarpet gem
