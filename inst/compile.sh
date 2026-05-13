#!/bin/bash

set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
target_dir="$script_dir/bin/RawFileReader"
source_dir="${THERMO_RAWFILEREADER_HOME:-}"

mkdir -p "$target_dir"

if [ -n "$source_dir" ]; then
  cp "$source_dir/ThermoFisher.CommonCore.Data.dll" "$target_dir/"
  cp "$source_dir/ThermoFisher.CommonCore.RawFileReader.dll" "$target_dir/"
fi

for dll_name in \
  ThermoFisher.CommonCore.Data.dll \
  ThermoFisher.CommonCore.RawFileReader.dll
do
  if [ ! -f "$target_dir/$dll_name" ]; then
    echo "Missing dependency: $target_dir/$dll_name" >&2
    echo "Set THERMO_RAWFILEREADER_HOME to the directory containing the Thermo CommonCore DLLs." >&2
    exit 1
  fi
done

if ! command -v mcs >/dev/null 2>&1; then
  echo "The Mono C# compiler 'mcs' is required to build RawFileReader helpers." >&2
  exit 1
fi

cd "$script_dir"

mcs src/GetSampleInfo.cs -r:"$target_dir/ThermoFisher.CommonCore.Data.dll" -r:"$target_dir/ThermoFisher.CommonCore.RawFileReader.dll" -out:"$target_dir/GetSampleInfo.exe"
mcs src/GetScanFilters.cs -r:"$target_dir/ThermoFisher.CommonCore.Data.dll" -r:"$target_dir/ThermoFisher.CommonCore.RawFileReader.dll" -out:"$target_dir/GetScanFilters.exe"
mcs src/GetInstrumentName.cs -r:"$target_dir/ThermoFisher.CommonCore.Data.dll" -r:"$target_dir/ThermoFisher.CommonCore.RawFileReader.dll" -out:"$target_dir/GetInstrumentName.exe"
