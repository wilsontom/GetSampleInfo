# GetSampleInfo

[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable) ![License](https://img.shields.io/badge/license-GNU%20GPL%20v3.0-blue.svg "GNU GPL v3.0")

>__R Wrapper to the Thermo C# RawFileReader__

#### Installation

To use, you first need to obtain a copy of Thermo's RawFileReader, see details [here](https://planetorbitrap.com/rawfilereader).

**GetSampleInfo** requires two Thermo C# assemblies at install time:

- `ThermoFisher.CommonCore.Data.dll`
- `ThermoFisher.CommonCore.RawFileReader.dll`

Keep those DLLs outside the repo and point `THERMO_RAWFILEREADER_HOME` at the directory containing them.

```sh
export THERMO_RAWFILEREADER_HOME=/full/path/to/RawFileReader
```

On macOS and Linux you also need Mono so the C# sources can be compiled and the generated `.exe` files can be run.

To install, follow the correct instructions [here](https://www.mono-project.com/download/stable/#download-lin).

```sh
mcs --version
Mono C# compiler version 6.8.0.96
```

With `THERMO_RAWFILEREADER_HOME` set, package installation will copy the DLLs into `inst/bin/RawFileReader/` and compile the C# readers automatically.

```sh
R CMD build .
R CMD INSTALL GetSampleInfo_0.4.0.tar.gz
```

For local development you can also populate the DLLs and compile explicitly:

```sh
THERMO_RAWFILEREADER_HOME=/full/path/to/RawFileReader bash inst/compile.sh
```

If everything has worked there should now be three `.exe` files in `inst/bin/RawFileReader/`.

If `THERMO_RAWFILEREADER_HOME` is not set, or the DLLs cannot be found, the package will still install but the exported functions will fail with a clear runtime error until the readers are compiled.

#### Usage


```R
> library(GetSampleInfo)

> TestFile <- system.file('extdata/QC01.raw', package = 'GetSampleInfo')

> SampleInfo <- GetSampleInfo(TestFile)

> InstrumentName <- GetInstrumentName(TestFile)
> InstrumentName
$instrument_name
[1] "Thermo Exactive Orbitrap"

$instrument_model
[1] "Exactive Orbitrap"

$instrument_serial
[1] "Exactive slot #1"

> ScanFilters <- GetScanFilters(TestFile)
> ScanFilters 
# A tibble: 2 x 1
  ScanFilter                                
  <chr>                                     
1 FTMS {1,1} - p ESI Full ms [63.00-1000.00]
2 FTMS {1,2} + p ESI Full ms [55.00-1000.00]
```
