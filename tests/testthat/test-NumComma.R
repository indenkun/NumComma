test_that("Convert to comma-separated numbers", {
  expect_equal(NumComma_add(2020), "2,020")
  expect_equal(NumComma_add(c(2019, 2020, 2021)),
               c("2,019","2,020", "2,021"))
  expect_equal(NumComma_add(c(123456, 1234), digit = 4),
               c("123,456", "1234"))
  expect_equal(NumComma_add(c(123456, 1234), small.num = 2000),
               c("123,456", "1234"))
  expect_equal(NumComma_add(1234.56),
               "1,234.56")
  expect_equal(NumComma_add(1234.56, digit = 4),
               "1,234.56")
  expect_equal(NumComma_add(1234.56, small.num = 2000),
               "1234.56")
  expect_warning(NumComma_add("japan"))
  expect_warning(NumComma_add("1,23,456"))
  expect_equal(NumComma_add("japan", warnig.message = FALSE), "japan")
  expect_equal(NumComma_add("0007"), "0007")
})

test_that("Convert to comma-separeted numbers in strings", {
  expect_equal(NumComma_add_str("This year is 2020 and next year is 2021."),
               "This year is 2,020 and next year is 2,021.")
  expect_equal(NumComma_add_str("This is 123456, but that's 2020.", digit = 4),
               "This is 123,456, but that's 2020.")
  expect_equal(NumComma_add_str("This is 123456, but that's 2020.", small.num = 3000),
               "This is 123,456, but that's 2020.")
})

test_that("Convert to non comma-separeted numbers", {
  expect_equal(NumComma_rm("2,020"), "2020")
  expect_equal(NumComma_rm("2020"), "2020")
  expect_equal(NumComma_rm("2,020", convert = TRUE), 2020)
  expect_equal(NumComma_rm("2020", convert = TRUE), 2020)
  expect_equal(NumComma_rm(2020, convert = TRUE), 2020)
  expect_equal(NumComma_rm(c("2,020", "2,021")), c("2020", "2021"))
  expect_warning(NumComma_rm("japan"))
  expect_warning(NumComma_rm("1,23,456"))
  expect_equal(NumComma_rm("japan", warnig.message = FALSE), "japan")
  expect_equal(NumComma_rm("1,23,456", warnig.message = FALSE), "1,23,456")
  expect_equal(NumComma_rm("1,234.56"), "1234.56")
  expect_equal(NumComma_rm(c("1,234", "1,234.56", "1,23", "japan"), warnig.message = FALSE),
               c("1234", "1234.56", "1,23", "japan"))
  expect_equal(NumComma_rm(c("1,234", "1,234.56", "1,23", "japan"), convert = TRUE, warnig.message = FALSE),
               c(1234, 1234.56, NA, NA))
  expect_equal(NumComma_rm("0007"), "0007")
})

test_that("Convert to non comma-separeted numbers in strings", {
  expect_equal(NumComma_rm_str("This year is 2,020 and next year is 2,021."),
               "This year is 2020 and next year is 2021.")
  expect_equal(NumComma_rm_str("This year is 2,0,2,0 and next year is 2,021."),
               "This year is 2,0,2,0 and next year is 2021.")
})
