context("H2Driver")

test_that("H2() creates a H2Driver object", {
  # when
  drv <- H2()

  # then
  expect_that(drv, is_a("H2Driver"))
})

test_that("dbGetInfo returns expected values", {
  # given
  drv <- H2()

  # when
  info <- dbGetInfo(drv)

  # then
  expect_that(info$driver.version, equals("0.9.99"))
  expect_that(info$client.version, equals("1.4"))
})

test_that("dbConnect() accepts a H2Driver object", {
  # given
  drv <- H2()

  # when
  con <- dbConnect(drv)

  # then
  expect_that(con, is_a("H2Connection"))
})