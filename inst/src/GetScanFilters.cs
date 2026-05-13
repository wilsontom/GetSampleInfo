namespace RawFileReaderGetScanFilters
{
  using System;
  using System.Collections.Generic;
  using System.Diagnostics;
  using System.IO;
  using System.Runtime.ExceptionServices;

  using ThermoFisher.CommonCore.Data;
  using ThermoFisher.CommonCore.Data.Business;
  using ThermoFisher.CommonCore.RawFileReader;

  internal static class Program
  {
    private static void Main(string[] args)
    {
      string filename = string.Empty;

      if (args.Length > 0)
      {
        filename = args[0];
      }

      if (string.IsNullOrEmpty(filename))
      {
        Console.WriteLine("No RAW file specified!");

        return;
      }

      // Create the IRawDataPlus object for accessing the RAW file
      var rawFile = RawFileReaderAdapter.FileFactory(filename);

      if (!rawFile.IsOpen || rawFile.IsError)
      {
        Console.WriteLine("Unable to access the RAW file using the RawFileReader class!");

        return;
      }

      rawFile.SelectInstrument(Device.MS, 1);

      // Get information related to the sample that was processed
       var scanFilters = rawFile.GetAutoFilters();
        foreach (var filter in scanFilters)
                {
                Console.WriteLine(filter);
                    }

    }
  }
}
