#' Get Sample Information
#'
#' Extract all fields contained in the \code{SampleInformation} block of Thermo \code{.raw} files. \code{.raw} files
#' are accessed using the cross-platform C# RawFileReader.
#'
#' @param x a \code{.raw} file
#' @return a \code{data.frame} of sample information
#'
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
    (strsplit(x, '--')))

  field <- lapply(res_split, function(x)
    (x[[1]][1]))
  value <- lapply(res_split, function(x)
    (x[[1]][2]))

  SampleInfo <-
    data.frame(field = unlist(field), value = unlist(value))

  return(SampleInfo)
}
