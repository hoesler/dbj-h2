context("H2Driver")

test_that("H2() creates a H2Driver object", {
  # when
  drv <- H2()

  # then
  expect_that(drv, is_a("H2Driver"))
})

test_that("dbConnect() accepts a H2Driver object", {
  # given
  drv <- H2()

  # when
  con <- dbConnect(drv)

  # then
  expect_that(con, is_a("H2Connection"))
})