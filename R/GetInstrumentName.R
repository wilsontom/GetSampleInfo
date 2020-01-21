#' Get Instrument Name
#'
#' Extract instrumment identification fields
#'
#' @param x a `.raw` file
#' @return a `list` of four elements
#' @export

GetInstrumentName <- function(x)
{
  if (tolower(tools::file_ext(x)) != 'raw') {
    stop('input must be a .raw file')
  }

  raw_file_read <-
    system.file('bin/RawFileReader/GetInstrumentName.exe', package = 'GetSampleInfo')

  input_cmd <- paste(raw_file_read, x, sep = ' ')

  cmd_res <- as.list(system(input_cmd, intern = TRUE))

  res_split <- lapply(cmd_res, function(x)
    (strsplit(x, ' -- ')))

  list_names <- sapply(res_split, function(x){x[[1]][1]})
  list_values <- lapply(res_split, function(x){x[[1]][2]})

  names(list_values) <- list_names

  return(list_values)
}
