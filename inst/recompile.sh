#!/bin/bash

mcs src/GetSampleInfo.cs -r:bin/RawFileReader/ThermoFisher.CommonCore.Data.dll -r:bin/RawFileReader/ThermoFisher.CommonCore.RawFileReader.dll -out:bin/RawFileReader/GetSampleInfo.exe
