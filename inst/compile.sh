#!/bin/bash

mcs src/GetSampleInfo.cs -r:bin/RawFileReader/ThermoFisher.CommonCore.Data.dll -r:bin/RawFileReader/ThermoFisher.CommonCore.RawFileReader.dll -out:bin/RawFileReader/GetSampleInfo.exe
mcs src/GetScanFilters.cs -r:bin/RawFileReader/ThermoFisher.CommonCore.Data.dll -r:bin/RawFileReader/ThermoFisher.CommonCore.RawFileReader.dll -out:bin/RawFileReader/GetScanFilters.exe
mcs src/GetInstrumentName.cs -r:bin/RawFileReader/ThermoFisher.CommonCore.Data.dll -r:bin/RawFileReader/ThermoFisher.CommonCore.RawFileReader.dll -out:bin/RawFileReader/GetInstrumentName.exe

