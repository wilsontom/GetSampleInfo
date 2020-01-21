#' Get Precursor Masses
#'
#' @param x a `.raw` file
#' @return a numeric vector of MS Level 2 precursor mass values
#' @export

GetPrecursorMasses <- function(x)
{
  scan_filter <- GetScanFilters(x)

  ms2_filters <- stringr::str_detect(scan_filter$ScanFilter, 'ms2')
  ms2_filters_id <- which(ms2_filters == TRUE)

  ms2_scans <- scan_filter$ScanFilter[ms2_filters_id]

  ms2_scan_split_a <-
    purrr::map(ms2_scans, ~ {
      stringr::str_split(., 'ms2 ')
    })


  ms2_right <- purrr::map_chr(ms2_scan_split_a, ~ {
    .[[1]][[2]]
  })

  ms2_scan_split_b <-
    purrr::map(ms2_right, ~ {
      stringr::str_split(., '@')
    })

  precursor_mzs <- purrr::map_chr(ms2_scan_split_b, ~ {
    .[[1]][[1]]
  })

  precursor_mzs <- as.numeric(precursor_mzs)

  return(precursor_mzs)

}
