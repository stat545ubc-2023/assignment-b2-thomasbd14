
# getquaRtiles: Quickly Computing the Quartiles of Tidy Data

<!-- badges: start -->
<!-- badges: end -->

getquaRtiles allows you to easily view the quartiles of numerical data.

## Installation

You can install the development version of getquaRtiles from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("stat545ubc-2023/getquaRtiles", ref = "0.1.1")
```

## Example

The basic usage of getquaRtiles is as follows:

``` r
library(getquaRtiles)

# Inspect the dataset
head(mtcars)
#>                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#> Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

# Let's get the quartiles of weight over the whole dataset
get_quartiles(mtcars,wt)
#> # A tibble: 1 × 3
#>   lower_quartile median upper_quartile
#>            <dbl>  <dbl>          <dbl>
#> 1           2.58   3.32           3.61

# Let's do the same thing, now splitting up the dataset by the number of cylinders 
get_quartiles(mtcars,wt,cyl) 
#> # A tibble: 3 × 4
#>     cyl lower_quartile median upper_quartile
#>   <dbl>          <dbl>  <dbl>          <dbl>
#> 1     4           1.88   2.2            2.62
#> 2     6           2.82   3.22           3.44
#> 3     8           3.53   3.76           4.01
```
