context("fetch-token")

# These are used in several tests below.
creds_always <- function(scopes, ...) { 1 }
creds_never <- function(scopes, ...) { NULL }
creds_failure <- function(scopes, ...) { stop("no creds") }
creds_maybe <- function(scopes, arg1 = "", ...) {
  if (arg1 != "") {
    2
  }
}

test_that("Basic token fetching works", {
  on.exit(set_credential_functions(list()))

  add_credential_function(creds_always)
  expect_equal(1, fetch_token(c()))

  add_credential_function(creds_never)
  expect_equal(1, fetch_token(c()))
})

test_that("We fetch tokens in order", {
  on.exit(set_credential_functions(list()))

  add_credential_function(creds_always)
  add_credential_function(creds_maybe)

  expect_equal(1, fetch_token(c()))
  expect_equal(2, fetch_token(c(), arg1 = "abc"))

  set_credential_functions(list(creds_always, creds_maybe))

  expect_equal(1, fetch_token(c()))
  expect_equal(1, fetch_token(c(), arg1 = "abc"))
})

test_that("We sometimes return no token", {
  on.exit(set_credential_functions(list()))

  add_credential_function(creds_never)
  expect_null(fetch_token(c()))
})

test_that("We don't need any registered functions", {
  expect_null(fetch_token(c()))
})

test_that("We keep looking for credentials on error", {
  on.exit(set_credential_functions(list()))

  add_credential_function(creds_always)
  add_credential_function(creds_failure)

  options(show.error.messages = FALSE)
  expect_equal(1, fetch_token(c()))
  options(show.error.messages = TRUE)
})
