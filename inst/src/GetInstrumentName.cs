// Tom Wilson <tpw2@aber.ac.uk>
//
// 2018-02-05
//
// Access Sample Information

namespace RawFileReaderGetSampleInfo
{
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.IO;
    using System.Runtime.ExceptionServices;

    using ThermoFisher.CommonCore.Data;
    using ThermoFisher.CommonCore.Data.Business;
//  using ThermoFisher.CommonCore.Data.FilterEnums;
//  using ThermoFisher.CommonCore.Data.Interfaces;
//  using ThermoFisher.CommonCore.MassPrecisionEstimator;
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
            Console.WriteLine("instrument_name -- " + rawFile.GetInstrumentData().Name);
            Console.WriteLine("instrument_model -- " + rawFile.GetInstrumentData().Model);
            Console.WriteLine("instrument_serial -- " + rawFile.GetInstrumentData().SerialNumber);
            }
    }
}
