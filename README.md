
<!-- README.md is generated from README.Rmd. Please edit that file -->

[English](README.md) | [日本語](README_JP.md)

# NumComma

<!-- badges: start -->

<!-- badges: end -->

`{NumComma}` can convert between comma-separated and non-comma-separated
numbers every three digits on R. It also has the `*_str` function for
handling comma-separated and non-comma-separated numbers in a string.

It also has the `*_str` function to handle comma-separated and
non-comma-separated numbers in a string.

## Installation

You can install it in

``` r
remotes::install_github("indenkun/NumComma")
```

## Example

``` r
library(NumComma)
```

`{NumComma}` has two functions: `NumComma_rm` for converting
comma-separated numbers into uncomma-separated numbers every three
digits, and `NumComma_add` for converting numbers into comma-separated
numbers (strings) every three digits. And there are extensions to these
functions, `NumComma_rm_str` and `NumComma_add_str`, which perform the
conversion for each digit in a string.

### `NumComma_rm` and `NumComma_rm_str`

`NumComma_rm` can convert comma-separated numbers (strings) into numbers
without commas every three digits.

``` r
NumComma_rm("2,020")
#> [1] "2020"
```

If the number does not contain a comma, it returns the same number.

``` r
NumComma_rm("2020")
#> [1] "2020"
```

Numbers containing numbers after the decimal point can also be
converted.

``` r
NumComma_rm("1,234.56")
#> [1] "1234.56"
```

Numbers containing numbers after the decimal point can also be
converted.

``` r
x <- c("2,020", "2020", "1,234.56")
NumComma_rm(x)
#> [1] "2020"    "2020"    "1234.56"
```

It is also possible to return the value as a number instead of a string
by using `convert` with `TRUE`.

``` r
x <- c("2,020", "2020", "1,234.56")
NumComma_rm(x, convert = TRUE)
#> [1] 2020.00 2020.00 1234.56
```

If you enter a number with a comma or a non-comma value for every three
digits, it returns the value as it was entered with a warning message.

``` r
NumComma_rm("1,23,456")
#> Warning in .f(.x[[1L]], .y[[1L]], ...): this format cannot be converted.
#> [1] "1,23,456"
NumComma_rm("NumComma_rm")
#> Warning in .f(.x[[1L]], .y[[1L]], ...): Strings containing characters other than
#> numbers and commas cannot be converted.
#> [1] "NumComma_rm"
```

The warning text can be disabled by specifying `FALSE` in
`Warnig.message`.

``` r
NumComma_rm(c("1,23,456", "NumComma_rm"), warnig.message = FALSE)
#> [1] "1,23,456"    "NumComma_rm"
```

`NumComma_rm_str` is a function for converting a comma-separated number
to an uncomma-separated number for every three digits in a string.

``` r
NumComma_rm_str("The total population of Japan is 124,271,318 as of January 1, 2020.")
#> [1] "The total population of Japan is 124271318 as of January 1, 2020."
```

### `NumComma_add` and `NumComma_add_str`

NumComma\_add\` is a function for converting numbers into
comma-separated numbers (strings) of three digits.

It can accept a number or a string that represents a number.

``` r
NumComma_add(123456)
#> [1] "123,456"
NumComma_add("123456")
#> [1] "123,456"
```

If you enter consecutive numbers starting from 0 as a string it will
return the value as is.

``` r
NumComma_add("0001")
#> [1] "0001"
```

If you enter a string that is not a number string (including numbers
containing commas), it returns the value you entered with a warning
message.

``` r
NumComma_add(c("NumComma_add", "1,234"))
#> Warning in .f(.x[[i]], ...): Strings containing characters other than numbers
#> cannot be converted.

#> Warning in .f(.x[[i]], ...): Strings containing characters other than numbers
#> cannot be converted.
#> [1] "NumComma_add" "1,234"
```

The warning text can be disabled by specifying `FALSE` in
`Warnig.message`.

``` r
NumComma_add(c("NumComma_add", "1,234"), warnig.message = FALSE)
#> [1] "NumComma_add" "1,234"
```

You can also use `digit` to convert only numbers with more than the
number of digits (including decimal places) specified by `digit` into
comma-separated numbers with every three digits, or `small.num` to
convert only numbers with more than the number of digits specified by
`small.num` into comma-separated numbers with every three digits.

``` r
NumComma_add(c(123456, 2020), digit = 4)
#> [1] "123,456" "2020"
NumComma_add(c(123456, 2020), small.num = 3000)
#> [1] "123,456" "2020"
```

`NumComma_add_str` is a function for converting numbers in a string to
comma-separated numbers.

``` r
NumComma_add_str("The total population of Japan is 124271318 people as of January 1, 2020.")
#> [1] "The total population of Japan is 124,271,318 people as of January 1, 2,020."
```

The `NumComma_add_str`, like the `NumComma_add`, can control the number
to be converted by arguments.

``` r
NumComma_add_str("The total population of Japan is 124271318 people as of January 1, 2020.", digit = 4)
#> [1] "The total population of Japan is 124,271,318 people as of January 1, 2020."
NumComma_add_str("The total population of Japan is 124271318 people as of January 1, 2020.", small.num = 3000)
#> [1] "The total population of Japan is 124,271,318 people as of January 1, 2020."
```

### License

MIT.

### Imports

  - purrr
  - stringr
  - stats
