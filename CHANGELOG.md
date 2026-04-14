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

## v1.3.4
- feat: add Sign Out action to EmailVerified AppBar

## v1.3.5
- fix: cancel auto-polling timer in dispose() to avoid leaks

## v1.3.6
- style: add animated scale icon to EmailVerified header

## v1.3.7
- feat: add fetchCategories() function to api_call.dart

## v1.3.8
- feat: add fetchProductsByCategory() to api_call.dart

## v1.3.9
- feat: add fetchProductById() to api_call.dart

## v1.4.0
- refactor: extract base URL as constant in api_call.dart

## v1.4.1
- feat: add Hero animation tag to ProductCard image

## v1.4.2
- feat: add image loading progress indicator to ProductCard

## v1.4.3
- feat: add broken image fallback widget to ProductCard

## v1.4.4
- style: add category chip badge to ProductCard

## v1.4.5
- feat: add half-star rating support to ProductCard

## v1.4.6
- feat: navigate to ProductDetailScreen on ProductCard tap

## v1.4.7
- style: change price color to deepPurple in ProductCard

## v1.4.8
- feat: add search bar to HomePage with real-time filtering

## v1.4.9
- feat: add category filter chips row to HomePage

## v1.5.0
- feat: add user greeting with first name to HomePage

## v1.5.1
- feat: add user profile dialog with Google avatar in HomePage

## v1.5.2
- feat: add product count label to HomePage grid

## v1.5.3
- feat: add empty state view when no products match search

## v1.5.4
- feat: add error/retry state to HomePage FutureBuilder

## v1.5.5
- refactor: move product grid to GridView in HomePage

## v1.5.6
- feat: create ProductDetailScreen with Hero image display

## v1.5.7
- feat: add quantity selector (+/-) to ProductDetailScreen

## v1.5.8
- feat: add animated wishlist heart button to ProductDetailScreen

## v1.5.9
- feat: add total price calculation to ProductDetailScreen

## v1.6.0
- feat: add Add to Cart snackbar to ProductDetailScreen

## v1.6.1
- feat: add Buy Now button (coming soon) to ProductDetailScreen

## v1.6.2
- style: add category badge to ProductDetailScreen header

## v1.6.3
- feat: add search bar to ProductScreen with live filtering

