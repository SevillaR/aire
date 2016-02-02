library(aire)

context("Checking target http addresses")

test_that("target url exists", {

  url <- aire:::url_path("2015-01-29", "se")
  expect_false(httr::http_error(url))

})

