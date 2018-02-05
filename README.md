# GetSampleInfo

>__R Wrapper to the Thermo C# RawFileReader__



#### Compiling C# Source

The compiled `.exe` for `GetSampleInfo` is located in `/inst/bin/RawFileReader` but if needed can be re-compiled using the following;

> To compile on Linux, mono-develop must be installed

```sh
> mcs --version
Mono C# compiler version 4.2.1.0
```
> From the R package root directory;
```sh
mcs src/GetSampleInfo.cs -r:inst/bin/RawFileReader/ThermoFisher.CommonCore.Data.dll -r:inst/bin/RawFileReader/ThermoFisher.CommonCore.RawFileReader.dll -out:inst/bin/RawFileReader/GetSampleInfo.exe
```

```sh
> inst/bin/RawFileReader/GetSampleInfo.exe 
No RAW file specified!
```





```R
library(GetSampleInfo)

GetSampleInfo('QC01.raw')
```
