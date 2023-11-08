library(tibble)

### Ordinary usage ###

# Simple case with only one variable
no_category_test <- tibble(values = c(0,1,2,3,4))
no_category_expect <- tibble(lower_quartile = c(1),
                             median = c(2),
                             upper_quartile = c(3)
)


# Now let's add some categories
with_category_test <- tibble(categories = c("a","a","a","a","a","b","b","b","b","b"),
                             values = c(1,1,1,1,1,2,3,4,5,6),
                             decoy = c(1,2,3,"ab", "a",c(5),"a",8,10,9))
with_categories_expect <- tibble(categories = c("a","b"),
                                 lower_quartile = c(1,3),
                                 median = c(1,4),
                                 upper_quartile = c(1,5)
)

# Try numerical categories
numerical_category_test <- tibble(categories = c(1,1,1,1,1,2,2,2,2,2),
                                  values = c(1,1,1,1,1,2,3,4,5,6))
numerical_category_expect <- tibble(categories = c(1,2),
                                    lower_quartile = c(1,3),
                                    median = c(1,4),
                                    upper_quartile = c(1,5)
)

#Test each of these cases when used correctly
test_that("Base cases",{
  expect_identical(get_quartiles(no_category_test, values), no_category_expect)
  expect_identical(get_quartiles(with_category_test, values, categories), with_categories_expect)
  expect_identical(get_quartiles(numerical_category_test, values, categories), numerical_category_expect)
})

### Error cases ###

#Test that we get errors when we expect
test_that("Error cases",{
  #null data
  expect_error(get_quartiles(NULL, values), "Please specify data")
  #non numerical summarized_variable
  expect_error(get_quartiles(with_category_test,decoy),"Summarized_variable must be a numeric column
decoy is of type character")
  #non existent column
  expect_error(get_quartiles(with_category_test, non_existent_column), "Please speficy a valid column name to summarize")
})

### Warning cases ###

#Insert NAs in summarized_variable
na_in_summarized <- tibble(categories = c("a","a","a","b","b","b"),
                           values = c(NA,2,NA,1,2,3),
)

#Insert NAs in  categories
na_in_categories <- tibble(categories = c("a","a","a",NA,"b","b","b"),
                           values = c(1,2,3,1000,1,2,3),
)

test_that("Warning cases",{
  expect_warning(get_quartiles(na_in_summarized,values,categories),"removing NA values")
  expect_warning(get_quartiles(na_in_categories,values, categories), "NAs found in category variable. Treating these as a separate group")
})
