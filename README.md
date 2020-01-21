# GetSampleInfo

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) ![License](https://img.shields.io/badge/license-GNU%20GPL%20v3.0-blue.svg "GNU GPL v3.0")

>__R Wrapper to the Thermo C# RawFileReader__

#### Installation

To use, you first need to obtain a copy of Thermo's RawFileReader, see details [here](https://planetorbitrap.com/rawfilereader). 

**GetSampleInfo** requires two of the C# assemblies to be included in the `inst` directory prior to package installation.

```sh
# Create the following directory

mkdir /inst/bin
mkdir inst/RawFileReader

# From your RawFileReader download; copy ThermoFisher.CommonCore.Data.dll and ThermoFisher.CommonCore.RawFileReader.dll into the directory you just created

cp ThermoFisher.CommonCore.RawFileReader.dll /inst/bin/RawFileReader/
cp ThermoFisher.CommonCore.RawFileReader.dll /inst/bin/RawFileReader/

```

You then need to compile the C# source files to executables that can be used in R. To do this you need the Mono C# Compiler.

To install, follow the correct instructions [here](https://www.mono-project.com/download/stable/#download-lin).


```sh
> mcs --version
Mono C# compiler version 6.8.0.96
```

Once the DLLs are in the correct directory and the Mono C# Compiler is installed; then the C# source can be compiled using the `inst/compile.sh` script.

```sh
chmod u+x inst/compile.sh
cd inst/
./compile.sh
```

If everything has worked there should now be four `.exe` files in the `inst/bin/RawFileReader` directory.

The package can be installed from source using the following

```sh
R CMD build GetSampleInfo

R CMD INSTALL GetSampleInfo_0.4.0.tar.gz
```


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
