library(GetSampleInfo)

make_raw_file <- function()
{
  path <- tempfile(fileext = ".raw")
  file.create(path)
  path
}

test_that("rawfilereader_exe reports a missing executable clearly", {
  testthat::local_mocked_bindings(
    find_rawfilereader_exe_path = function(exe_name) "",
    .package = "GetSampleInfo"
  )

  expect_error(
    GetSampleInfo:::rawfilereader_exe("GetSampleInfo.exe"),
    "RawFileReader executable 'GetSampleInfo.exe' is not installed.",
    fixed = TRUE
  )
})

test_that("rawfilereader_command handles platform-specific launchers", {
  testthat::local_mocked_bindings(
    rawfilereader_os_type = function() "windows",
    .package = "GetSampleInfo"
  )

  expect_equal(
    GetSampleInfo:::rawfilereader_command("C:/tools/GetSampleInfo.exe"),
    list(command = "C:/tools/GetSampleInfo.exe", args = character())
  )

  testthat::local_mocked_bindings(
    rawfilereader_os_type = function() "unix",
    find_mono = function() "/usr/bin/mono",
    .package = "GetSampleInfo"
  )

  expect_equal(
    GetSampleInfo:::rawfilereader_command("/tmp/GetSampleInfo.exe"),
    list(command = "/usr/bin/mono", args = "/tmp/GetSampleInfo.exe")
  )
})

test_that("rawfilereader_command errors when mono is unavailable", {
  testthat::local_mocked_bindings(
    rawfilereader_os_type = function() "unix",
    find_mono = function() "",
    .package = "GetSampleInfo"
  )

  expect_error(
    GetSampleInfo:::rawfilereader_command("/tmp/GetSampleInfo.exe"),
    "'mono' is required to run RawFileReader executables on this platform.",
    fixed = TRUE
  )
})

test_that("run_rawfilereader validates file existence before execution", {
  expect_error(
    GetSampleInfo:::run_rawfilereader("GetSampleInfo.exe", tempfile(fileext = ".raw")),
    "input file does not exist:",
    fixed = TRUE
  )
})

test_that("run_rawfilereader returns command output on success", {
  raw_file <- make_raw_file()
  testthat::local_mocked_bindings(
    rawfilereader_exe = function(exe_name) file.path("/tmp", exe_name),
    rawfilereader_command = function(exe_path) list(command = "mono", args = exe_path),
    run_system2 = function(command, args) c("field -- value"),
    .package = "GetSampleInfo"
  )

  expect_equal(
    GetSampleInfo:::run_rawfilereader("GetSampleInfo.exe", raw_file),
    "field -- value"
  )
})

test_that("run_rawfilereader surfaces process failures", {
  raw_file <- make_raw_file()
  testthat::local_mocked_bindings(
    rawfilereader_exe = function(exe_name) file.path("/tmp", exe_name),
    rawfilereader_command = function(exe_path) list(command = "mono", args = exe_path),
    run_system2 = function(command, args) {
      structure(c("first line", "second line"), status = 12)
    },
    .package = "GetSampleInfo"
  )

  expect_error(
    GetSampleInfo:::run_rawfilereader("GetSampleInfo.exe", raw_file),
    "RawFileReader command failed with status 12: first line\nsecond line",
    fixed = TRUE
  )
})
