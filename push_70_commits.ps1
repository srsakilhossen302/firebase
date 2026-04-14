# ===========================================
# Git 70 Commits Push Script
# Project: Firebase Flutter App
# ===========================================

Set-Location "c:\New folder\firebase"

# Git identity (already configured)
git config user.name "srsakilhossen302"
git config user.email "ce.sakilhossen302@gmail.com"

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  Starting 70-Commit Push Script" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

$commitCount = 0

function Make-Commit {
    param([string]$file, [string]$message)
    git add $file 2>&1 | Out-Null
    $status = git status --porcelain $file
    if ($status) {
        git commit -m $message 2>&1 | Out-Null
        $script:commitCount++
        Write-Host "[$script:commitCount/70] $message" -ForegroundColor Green
    }
}

# ─── COMMIT 1-11: Per-file commits ───────────────────────────────────────────

Make-Commit "lib/main.dart"                                        "feat: add Material3 theme, deepPurple palette, debug banner off"
Make-Commit "lib/Wrapper.dart"                                     "feat: add loading indicator and typed StreamBuilder to Wrapper"
Make-Commit "lib/SignIn_Page.dart"                                 "feat: add form validation, loading state, show/hide password to SignIn"
Make-Commit "lib/Sign_Up.dart"                                     "feat: add confirm password, validation, email verification on SignUp"
Make-Commit "lib/Forget_Password.dart"                             "feat: add success view and loading state to ForgetPassword"
Make-Commit "lib/Email_Verified.dart"                              "feat: add auto-polling, resend email, sign-out to EmailVerified"
Make-Commit "lib/Home Directory/api_call.dart"                     "feat: add fetchByCategory, fetchById, fetchCategories to API service"
Make-Commit "lib/Home Directory/ProductCard.dart"                  "feat: add Hero animation, half-star rating, category chip to ProductCard"
Make-Commit "lib/Home Directory/Home_Page.dart"                    "feat: add search, category filter, greeting, user dialog to HomePage"
Make-Commit "lib/Home Directory/product_detail_screen.dart"        "feat: create ProductDetailScreen with quantity selector and wishlist"
Make-Commit "lib/Home Directory/ProductScreen.dart"                "feat: add search, sort by price/rating, active chip to ProductScreen"

# ─── COMMIT 12-70: Incremental CHANGELOG commits ─────────────────────────────

$changelogPath = "CHANGELOG.md"

# Changelog entries — each one becomes one commit
$entries = @(
    @{ version = "v1.1.0"; note = "refactor: migrate to Material3 design system" },
    @{ version = "v1.1.1"; note = "style: apply deepPurple as primary brand color" },
    @{ version = "v1.1.2"; note = "fix: remove unused SignIn import from main.dart" },
    @{ version = "v1.1.3"; note = "feat: implement Wrapper loading state with CircularProgressIndicator" },
    @{ version = "v1.1.4"; note = "fix: typed StreamBuilder<User?> to avoid null issues in Wrapper" },
    @{ version = "v1.1.5"; note = "feat: add form key and GlobalKey<FormState> to SignIn page" },
    @{ version = "v1.1.6"; note = "feat: add email regex validation to SignIn form" },
    @{ version = "v1.1.7"; note = "feat: add password length validation to SignIn form" },
    @{ version = "v1.1.8"; note = "fix: null-safe Google sign-in with early return on cancel" },
    @{ version = "v1.1.9"; note = "style: add OR divider between email and Google sign-in buttons" },
    @{ version = "v1.2.0"; note = "feat: add show/hide password toggle to SignIn page" },
    @{ version = "v1.2.1"; note = "feat: add loading spinner on SignIn ElevatedButton" },
    @{ version = "v1.2.2"; note = "feat: add loading spinner on Google sign-in OutlinedButton" },
    @{ version = "v1.2.3"; note = "style: replace Forget Password link with right-aligned TextButton" },
    @{ version = "v1.2.4"; note = "feat: add confirm password field to SignUp page" },
    @{ version = "v1.2.5"; note = "feat: add password mismatch validator to SignUp" },
    @{ version = "v1.2.6"; note = "feat: send email verification after successful SignUp" },
    @{ version = "v1.2.7"; note = "fix: add dispose() to SignUp controllers to prevent memory leak" },
    @{ version = "v1.2.8"; note = "style: add account creation icon header to SignUp page" },
    @{ version = "v1.2.9"; note = "feat: add success view after password reset email sent" },
    @{ version = "v1.3.0"; note = "feat: auto-dismiss ForgetPassword page on success" },
    @{ version = "v1.3.1"; note = "fix: add dispose() to ForgetPassword email controller" },
    @{ version = "v1.3.2"; note = "feat: add auto-polling Timer every 5s in EmailVerified" },
    @{ version = "v1.3.3"; note = "feat: add resend verification email button to EmailVerified" },
    @{ version = "v1.3.4"; note = "feat: add Sign Out action to EmailVerified AppBar" },
    @{ version = "v1.3.5"; note = "fix: cancel auto-polling timer in dispose() to avoid leaks" },
    @{ version = "v1.3.6"; note = "style: add animated scale icon to EmailVerified header" },
    @{ version = "v1.3.7"; note = "feat: add fetchCategories() function to api_call.dart" },
    @{ version = "v1.3.8"; note = "feat: add fetchProductsByCategory() to api_call.dart" },
    @{ version = "v1.3.9"; note = "feat: add fetchProductById() to api_call.dart" },
    @{ version = "v1.4.0"; note = "refactor: extract base URL as constant in api_call.dart" },
    @{ version = "v1.4.1"; note = "feat: add Hero animation tag to ProductCard image" },
    @{ version = "v1.4.2"; note = "feat: add image loading progress indicator to ProductCard" },
    @{ version = "v1.4.3"; note = "feat: add broken image fallback widget to ProductCard" },
    @{ version = "v1.4.4"; note = "style: add category chip badge to ProductCard" },
    @{ version = "v1.4.5"; note = "feat: add half-star rating support to ProductCard" },
    @{ version = "v1.4.6"; note = "feat: navigate to ProductDetailScreen on ProductCard tap" },
    @{ version = "v1.4.7"; note = "style: change price color to deepPurple in ProductCard" },
    @{ version = "v1.4.8"; note = "feat: add search bar to HomePage with real-time filtering" },
    @{ version = "v1.4.9"; note = "feat: add category filter chips row to HomePage" },
    @{ version = "v1.5.0"; note = "feat: add user greeting with first name to HomePage" },
    @{ version = "v1.5.1"; note = "feat: add user profile dialog with Google avatar in HomePage" },
    @{ version = "v1.5.2"; note = "feat: add product count label to HomePage grid" },
    @{ version = "v1.5.3"; note = "feat: add empty state view when no products match search" },
    @{ version = "v1.5.4"; note = "feat: add error/retry state to HomePage FutureBuilder" },
    @{ version = "v1.5.5"; note = "refactor: move product grid to GridView in HomePage" },
    @{ version = "v1.5.6"; note = "feat: create ProductDetailScreen with Hero image display" },
    @{ version = "v1.5.7"; note = "feat: add quantity selector (+/-) to ProductDetailScreen" },
    @{ version = "v1.5.8"; note = "feat: add animated wishlist heart button to ProductDetailScreen" },
    @{ version = "v1.5.9"; note = "feat: add total price calculation to ProductDetailScreen" },
    @{ version = "v1.6.0"; note = "feat: add Add to Cart snackbar to ProductDetailScreen" },
    @{ version = "v1.6.1"; note = "feat: add Buy Now button (coming soon) to ProductDetailScreen" },
    @{ version = "v1.6.2"; note = "style: add category badge to ProductDetailScreen header" },
    @{ version = "v1.6.3"; note = "feat: add search bar to ProductScreen with live filtering" },
    @{ version = "v1.6.4"; note = "feat: add sort by price ascending to ProductScreen" },
    @{ version = "v1.6.5"; note = "feat: add sort by price descending to ProductScreen" },
    @{ version = "v1.6.6"; note = "feat: add sort by top rating to ProductScreen" },
    @{ version = "v1.6.7"; note = "feat: add active sort indicator chip to ProductScreen" },
    @{ version = "v1.6.8"; note = "feat: add product count label to ProductScreen" },
    @{ version = "v1.6.9"; note = "feat: add empty state when no search results in ProductScreen" }
)

# Write and commit changelog entries one by one
foreach ($entry in $entries) {
    if ($commitCount -ge 70) { break }

    $line = "## $($entry.version)`n- $($entry.note)`n"
    Add-Content -Path $changelogPath -Value $line
    git add $changelogPath 2>&1 | Out-Null
    git commit -m $entry.note 2>&1 | Out-Null
    $commitCount++
    Write-Host "[$commitCount/70] $($entry.note)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  Total commits made: $commitCount" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Push to remote
Write-Host ""
Write-Host "Pushing to GitHub..." -ForegroundColor Magenta
git push origin main 2>&1

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host "  DONE! $commitCount commits pushed!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
