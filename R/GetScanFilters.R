#' Get Scan Filters
#'
#' Extract all unique scan filters available in the `.raw` file
#'
#' @param x a `.raw` file
#' @return a `tibble` of scan filters
#' @export

GetScanFilters <- function(x)
{
  if (tolower(tools::file_ext(x)) != 'raw') {
    stop('input must be a .raw file')
  }

  cmd_res <- run_rawfilereader('GetScanFilters.exe', x)
  cmd_res <- tibble::tibble(ScanFilter = cmd_res)

  return(cmd_res)
}
