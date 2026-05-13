find_rawfilereader_exe_path <- function(exe_name)
{
  system.file(file.path("bin", "RawFileReader", exe_name), package = "GetSampleInfo")
}

rawfilereader_os_type <- function()
{
  .Platform$OS.type
}

find_mono <- function()
{
  Sys.which("mono")
}

run_system2 <- function(command, args)
{
  system2(command, args, stdout = TRUE, stderr = TRUE)
}

rawfilereader_exe <- function(exe_name)
{
  exe_path <- find_rawfilereader_exe_path(exe_name)

  if (!nzchar(exe_path)) {
    stop(
      paste0(
        "RawFileReader executable '", exe_name, "' is not installed. ",
        "Set THERMO_RAWFILEREADER_HOME to the directory containing ",
        "ThermoFisher.CommonCore.Data.dll and ",
        "ThermoFisher.CommonCore.RawFileReader.dll, then reinstall the package ",
        "or run 'bash inst/compile.sh'."
      ),
      call. = FALSE
    )
  }

  exe_path
}

rawfilereader_command <- function(exe_path)
{
  if (rawfilereader_os_type() == "windows") {
    return(list(command = exe_path, args = character()))
  }

  mono <- find_mono()

  if (!nzchar(mono)) {
    stop(
      paste0(
        "'mono' is required to run RawFileReader executables on this platform. ",
        "Install mono and retry."
      ),
      call. = FALSE
    )
  }

  list(command = mono, args = exe_path)
}

run_rawfilereader <- function(exe_name, x)
{
  if (!file.exists(x)) {
    stop("input file does not exist: ", x, call. = FALSE)
  }

  exe_path <- rawfilereader_exe(exe_name)
  command <- rawfilereader_command(exe_path)
  output <- run_system2(command$command, c(command$args, x))
  status <- attr(output, 'status')

  if (!is.null(status) && status != 0) {
    stop(
      paste0(
        "RawFileReader command failed with status ", status,
        if (length(output)) paste0(": ", paste(output, collapse = "\n")) else "."
      ),
      call. = FALSE
    )
  }

  output
}
