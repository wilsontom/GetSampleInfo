#' Get Scan Filters
#'
#' Extract all unique scan filters available in the \code{.raw} file
#'
#' @param x a \code{.raw} file
#' @return a \code{tibble} of scan filters
#' @export

GetScanFilters <- function(x)
{
  if (tolower(tools::file_ext(x)) != 'raw') {
    stop('input must be a .raw file')
  }

  raw_file_read <-
    system.file('bin/RawFileReader/GetScanFilters.exe', package = 'GetSampleInfo')

  input_cmd <- paste(raw_file_read, x, sep = ' ')

  cmd_res <- tibble::as.tibble(system(input_cmd, intern = TRUE))

  names(cmd_res) <- 'ScanFilter'

  return(cmd_res)
}
