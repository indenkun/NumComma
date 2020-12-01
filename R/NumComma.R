#' Numbers and commas
#' @description
#' `NumComma_rm`, which takes a comma-separated number every three digits as a
#' string and converts it into a number without a comma. `NumComma_rm_str` is a
#' function to convert comma-separated numbers in a string into comma-separated
#' numbers without commas for every three digits while keeping the rest of the
#' string. While `NumComma_rm` accepts only positive numbers, `NumComma_rm_str`
#' accepts comma-separated numbers with three digits.
#' `NumComma_add` is a function that converts a number not containing a comma to
#'  a comma-separated number every three digits. `NumComma_add_str` is the
#'  function to convert a number in a string to a comma-separated number every
#'   three digits.
#' @param num Numbers (strings) separated by a comma every three digits.
#' @param convert If `TRUE`, will return as numeric. The default value is `FALSE`,
#'  and numeric values are treated as strings.
#' @param warnig.message If TRUE, a warning message is displayed when a
#' non-convertible value is submitted and the input value is returned without
#' conversion; if FALSE, the warning message is hidden and the value of the
#' unconvertible value is returned.
#'
#' @rdname NumComma
#' @importFrom purrr map
#' @importFrom stringr str_detect
#' @importFrom stringr str_count
#' @importFrom stringr str_extract
#' @importFrom stringr str_replace
#' @importFrom dplyr %>%
#' @return characters or numbers.
#' @examples
#' NumComma_add(2020)
#' NumComma_add(c(2019, 2020, 2021))
#' NumComma_add(c(123456, 1234), digit = 4)
#' NumComma_add(c(123456, 1234), small.num = 2000)
#' NumComma_add_str("This year is 2020 and next year is 2021.")
#' NumComma_add_str("This is 123456, but that's 2020.", digit = 4)
#' NumComma_rm(c("1,234", "1,234.56", "1,23", "japan"), warnig.message = FALSE)
#' NumComma_rm(c("1,234", "1,234.56", "1,23", "japan"), convert = TRUE, warnig.message = FALSE)
#' NumComma_rm_str("This year is 2,020 and next year is 2,021.")
#' NumComma_rm_str("This year is 2,0,2,0 and next year is 2,021.")
#' @export
#'

NumComma_rm <- function(num, convert = FALSE, warnig.message = TRUE){
  purrr::map2(num, convert, function(num, convert){
    if(warnig.message){
      if(!stringr::str_detect(num, pattern = "[:digit:]&,") &&
         !stringr::str_detect(num, pattern = "^[:digit:]"))
        warning("Strings containing characters other than numbers and commas cannot be converted.")
    }

    row_num <- num
    comma_n <- stringr::str_count(num, pattern = "[:digit:],[:digit:]")

    if(comma_n > 0 &&
       !(stringr::str_detect(num, pattern = "[:digit:],[:digit:][:digit:][:digit:][:digit:]")) &&
       !(stringr::str_detect(num, pattern = "[:digit:],[:digit:],")) &&
       !(stringr::str_detect(num, pattern = "[:digit:],[:digit:][:digit:],"))){
      for(i in 1:comma_n){
        comma_num <- stringr::str_extract(num, pattern = "[:digit:],[:digit:][:digit:][:digit:]")
        if(is.na(comma_num)){
          num <- row_num
          break
        }
        convert_num <- stringr::str_replace(comma_num, pattern = ",", replacement = "")
        num <- stringr::str_replace(num, pattern = comma_num, replacement = convert_num)
      }

    }

    if(stringr::str_detect(num, pattern = ",")){
      num <- row_num
      if(warnig.message) warning("this format cannot be converted.")
    }

    if(convert) num <- suppressWarnings(as.numeric(num))

    return(num)
  }) %>% unlist()
}

#' @param str str is a string.
#' @importFrom purrr map_chr
#' @importFrom stringr str_sub
#' @importFrom stringr str_split
#' @importFrom stats na.omit
#' @rdname NumComma
#' @export
#'

NumComma_rm_str <- function(str){
  purrr::map_chr(str, function(str){
    str_comma <- stringr::str_split(str, pattern = "[^[:digit:]|,]")[[1]]
    stringr::str_sub(str_comma[stringr::str_sub(str_comma, start = -1) ==  ","], start = -1) <- ""
    str_comma[str_comma == ""] <- NA
    str_comma <- stats::na.omit(str_comma)

    if(!(length(str_comma) == 0)){
      str_num <- NumComma_rm(str_comma, convert = FALSE, warnig.message = FALSE)

      for(i in 1:length(str_num)){
        str <- stringr::str_replace(str, pattern = str_comma[i], replacement = str_num[i])
      }
    }

    return(str)
  })
}

#' @param x x is a number or a string of numbers intended.
#' @param digit Converts the number of digits greater than the number specified
#' by `digit` (including the decimal point) to comma-separated numbers only.
#' @param small.num Convert only numbers greater than the number specified in
#' `small.num` (including decimal points) to comma-separated numbers.
#' @importFrom stringr str_length
#' @rdname NumComma
#' @export

NumComma_add <- function(x, digit = 3, small.num = 999, warnig.message = TRUE){
  purrr::map_chr(x, function(x, digit, small.num){
    if(suppressWarnings(is.na(as.numeric(x)))){
      if(warnig.message) warning("Strings containing characters other than numbers cannot be converted.")
      as.character(x)
    }
    else if(stringr::str_length(x) > digit &&
            x > small.num &&
            is.numeric(x)) prettyNum(x, big.mark = ",",  scientific = FALSE)
    else if(stringr::str_length(x) > digit &&
            !is.numeric(x) &&
            as.numeric(x) > small.num &&
            stringr::str_length(x) == stringr::str_length(as.numeric(x))) prettyNum(x, big.mark = ",",  scientific = FALSE)
    else as.character(x)
  }, digit, small.num)
}

#' @rdname NumComma
#' @export

NumComma_add_str <- function(str, digit = 3, small.num = 999){
  purrr::map_chr(str, function(str, digit, small.num){
    str_num <- stringr::str_split(str, pattern = "[^[:digit:]|.]")[[1]]
    stringr::str_sub(str_num[stringr::str_sub(str_num, start = -1) ==  "."], start = -1) <- ""
    str_num[str_num == ""] <- NA
    str_num <- stats::na.omit(str_num)

    if(!length(str_num) == 0){
      str_comma <- NumComma_add(as.numeric(str_num), digit = digit, small.num = small.num, warnig.message = FALSE)

      for(i in 1:length(str_comma)){
        str <- stringr::str_replace(str, pattern = str_num[i], replacement = str_comma[i])
      }

    }
    return(str)
  }, digit, small.num)
}
