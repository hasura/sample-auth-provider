# Sample provider for Auth service

This is a boilerplate for adding a custom auth provider to Auth service.

## Use-case

This auth provider only allows those with an email ending with `@hasura.io`.

## Quick walkthrough

Read the [docs](https://docs.platform.hasura.io/0.15/platform/manual/auth/authentication/providers/custom-provider.html).

The main APIs that are to be supported are:

- `\signup`
- `\login`
- `\merge`

These are implemented in https://github.com/hasura/sample-auth-provider/blob/master/app/controllers/users_controller.rb
