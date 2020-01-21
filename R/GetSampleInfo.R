#' Get Sample Information
#'
#' Extract all fields contained in the `SampleInformation` block of Thermo `.raw` files. `.raw` files
#' are accessed using the cross-platform C# RawFileReader.
#'
#' @param x a `.raw` file
#' @return a `tibble` of sample information
#' @importFrom tibble as_tibble
#' @export

GetSampleInfo <- function(x)
{
  if (tolower(tools::file_ext(x)) != 'raw') {
    stop('input must be a .raw file')
  }

  raw_file_read <-
    system.file('bin/RawFileReader/GetSampleInfo.exe', package = 'GetSampleInfo')

  input_cmd <- paste(raw_file_read, x, sep = ' ')

  cmd_res <- as.list(system(input_cmd, intern = TRUE))

  res_split <- lapply(cmd_res, function(x)
    (strsplit(x, ' -- ')))

  field <- lapply(res_split, function(x)
    (x[[1]][1]))
  value <- lapply(res_split, function(x)
    (x[[1]][2]))

  names(value) <- field
  value <- as_tibble(value)

  return(value)
}
