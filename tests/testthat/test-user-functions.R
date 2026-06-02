library(GetSampleInfo)

make_raw_file <- function()
{
  path <- tempfile(fileext = ".raw")
  file.create(path)
  path
}

test_that("GetSampleInfo rejects non-raw inputs", {
  expect_error(
    GetSampleInfo(tempfile(fileext = ".txt")),
    "input must be a .raw file",
    fixed = TRUE
  )
})

test_that("GetInstrumentName rejects non-raw inputs", {
  expect_error(
    GetInstrumentName(tempfile(fileext = ".txt")),
    "input must be a .raw file",
    fixed = TRUE
  )
})

test_that("GetScanFilters rejects non-raw inputs", {
  expect_error(
    GetScanFilters(tempfile(fileext = ".txt")),
    "input must be a .raw file",
    fixed = TRUE
  )
})

test_that("GetSampleInfo parses key-value output into a tibble", {
  raw_file <- make_raw_file()
  testthat::local_mocked_bindings(
    run_rawfilereader = function(exe_name, x) {
      c(
        "FileName -- QC01.raw",
        "SampleType -- QC"
      )
    },
    .package = "GetSampleInfo"
  )

  result <- GetSampleInfo(raw_file)

  expect_s3_class(result, "tbl_df")
  expect_equal(names(result), c("FileName", "SampleType"))
  expect_equal(result$FileName, "QC01.raw")
  expect_equal(result$SampleType, "QC")
})

test_that("GetInstrumentName returns a named list", {
  raw_file <- make_raw_file()
  testthat::local_mocked_bindings(
    run_rawfilereader = function(exe_name, x) {
      c(
        "instrument_name -- Thermo Exactive Orbitrap",
        "instrument_model -- Exactive Orbitrap",
        "instrument_serial -- Exactive slot #1"
      )
    },
    .package = "GetSampleInfo"
  )

  result <- GetInstrumentName(raw_file)

  expect_equal(
    names(result),
    c("instrument_name", "instrument_model", "instrument_serial")
  )
  expect_equal(result$instrument_name, "Thermo Exactive Orbitrap")
})

test_that("GetScanFilters wraps command output in a tibble", {
  raw_file <- make_raw_file()
  testthat::local_mocked_bindings(
    run_rawfilereader = function(exe_name, x) {
      c(
        "FTMS + p ESI Full ms [55.00-1000.00]",
        "FTMS + p ESI d Full ms2 487.23@hcd35.00 [100.00-1000.00]"
      )
    },
    .package = "GetSampleInfo"
  )

  result <- GetScanFilters(raw_file)

  expect_s3_class(result, "tbl_df")
  expect_equal(names(result), "ScanFilter")
  expect_equal(nrow(result), 2)
})

test_that("GetPrecursorMasses extracts precursor masses from ms2 scans", {
  testthat::local_mocked_bindings(
    GetScanFilters = function(x) {
      tibble::tibble(ScanFilter = c(
        "FTMS + p ESI Full ms [55.00-1000.00]",
        "FTMS + p ESI d Full ms2 487.23@hcd35.00 [100.00-1000.00]",
        "FTMS + p ESI d Full ms2 512.90@cid20.00 [100.00-1000.00]"
      ))
    },
    .package = "GetSampleInfo"
  )

  expect_equal(GetPrecursorMasses("QC01.raw"), c(487.23, 512.90))
})
