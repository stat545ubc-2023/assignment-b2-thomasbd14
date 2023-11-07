#' Get Quartiles
#'
#' @description This function returns a table of the quartiles for a given
#' numerical variable in a tibble, optionally divided into categories based on
#' an additional column.
#'
#' @details this function utilizes `group_by()` and `summarize()` from the dplyr
#' package.
#'
#' @param data the input data table to be analyzed. Named because data is the
#' typical thing to analyze in this fashion (and for consistency with dplyr)
#' @param summarized_variable the name of a numerical column in `data` for which
#' to calculate the quartiles. Named because this variable will be summarized.
#' @param grouping_variable (optional) the name of a column in `data` with a
#' categorical variable. If specified, the results will be summarized within
#' each unique entry of `grouping_variable`. Named since this is the variable
#' used for grouping the output.
#'
#' @return a tibble of showing the lower quartile, mean, and upper
#' quartile of `summarized_variable`, ignoring NA values. If `grouping_variable`
#' is not specified, the table will have one row representing the entire data. If
#' `grouping_variable` is specified, each row shows the quartile within one
#' unique category, which will be represented with an additional column.
#'
#' @examples
#' get_quartiles(mtcars,wt) # Get the quartiles of weight over the whole dataset
#' get_quartiles(mtcars,wt,cyl) # Get weight quartiles divided by number of cylinders
#'
#' @export

get_quartiles <- function(data, summarized_variable, grouping_variable = NULL){

  #get our column names as strings for error checking
  sum_var_str <- deparse(substitute(summarized_variable))
  grp_var_str <- deparse(substitute(grouping_variable))

  #Check if all necessary variables have been specified
  if(is.null(data)){
    stop("Please specify data")
  }
  if(is.null(data[[sum_var_str]])){
    stop("Please speficy a valid column name to summarize")
  }

  # check for non-numeric summarized_variable
  if(!is.numeric(data[[sum_var_str]])){
    stop("Summarized_variable must be a numeric column\n",
         sum_var_str, " is of type ", class(data[[sum_var_str]][1]))
  }

  # check if we are going to remove any NA values, warn if so
  if(anyNA(data[[sum_var_str]])){
    warning("removing NA values")
  }
  # check for NAs in the category variable. These will be treated as their own category
  # but it's nice to warn of this behavior
  if((!is.null(grp_var_str) && anyNA(data[[grp_var_str]]))){
    warning("NAs found in category variable. Treating these as a separate group")
  }



  #execute the function
  data %>% group_by({{grouping_variable}}) %>%
    summarize(lower_quartile = quantile({{summarized_variable}},0.25, na.rm = TRUE, names = FALSE),
              median = median({{summarized_variable}}, na.rm = TRUE),
              upper_quartile = quantile({{summarized_variable}},0.75, , na.rm = TRUE, names = FALSE)
    )
}
