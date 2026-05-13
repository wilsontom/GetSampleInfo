rawfilereader_exe <- function(exe_name)
{
  exe_path <-
    system.file(file.path('bin', 'RawFileReader', exe_name), package = 'GetSampleInfo')

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
  if (.Platform$OS.type == 'windows') {
    return(list(command = exe_path, args = character()))
  }

  mono <- Sys.which('mono')

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
  output <- system2(command$command, c(command$args, x), stdout = TRUE, stderr = TRUE)
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
