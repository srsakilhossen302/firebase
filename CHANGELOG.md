## v1.1.0
- refactor: migrate to Material3 design system

## v1.1.1
- style: apply deepPurple as primary brand color

## v1.1.2
- fix: remove unused SignIn import from main.dart

## v1.1.3
- feat: implement Wrapper loading state with CircularProgressIndicator

## v1.1.4
- fix: typed StreamBuilder<User?> to avoid null issues in Wrapper

## v1.1.5
- feat: add form key and GlobalKey<FormState> to SignIn page

## v1.1.6
- feat: add email regex validation to SignIn form

## v1.1.7
- feat: add password length validation to SignIn form

## v1.1.8
- fix: null-safe Google sign-in with early return on cancel

## v1.1.9
- style: add OR divider between email and Google sign-in buttons

## v1.2.0
- feat: add show/hide password toggle to SignIn page

## v1.2.1
- feat: add loading spinner on SignIn ElevatedButton

## v1.2.2
- feat: add loading spinner on Google sign-in OutlinedButton

## v1.2.3
- style: replace Forget Password link with right-aligned TextButton

## v1.2.4
- feat: add confirm password field to SignUp page

## v1.2.5
- feat: add password mismatch validator to SignUp

## v1.2.6
- feat: send email verification after successful SignUp

## v1.2.7
- fix: add dispose() to SignUp controllers to prevent memory leak

## v1.2.8
- style: add account creation icon header to SignUp page

## v1.2.9
- feat: add success view after password reset email sent

## v1.3.0
- feat: auto-dismiss ForgetPassword page on success

## v1.3.1
- fix: add dispose() to ForgetPassword email controller

## v1.3.2
- feat: add auto-polling Timer every 5s in EmailVerified

## v1.3.3
- feat: add resend verification email button to EmailVerified

