context("H2Connection")

test_that("dbSendQuery", {
  # given
  h2_drv <- H2()
  con <- dbConnect(h2_drv)
  on.exit(dbDisconnect(con))
  data(iris)
  dbWriteTable(con, "iris", iris)

  # when
  res <- dbSendQuery(con, "SELECT * FROM \"iris\"")
  
  # then
  expect_that(res, is_a("H2Result"))
})