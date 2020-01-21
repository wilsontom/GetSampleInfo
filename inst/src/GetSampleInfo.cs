namespace RawFileReaderGetSampleInfo
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
            Console.WriteLine("sample_type -- " + rawFile.SampleInformation.SampleType);
            Console.WriteLine("file_name -- " + rawFile.SampleInformation.RawFileName);
            Console.WriteLine("sample_id -- " + rawFile.SampleInformation.SampleId);
            Console.WriteLine("path -- " + rawFile.SampleInformation.Path);
            Console.WriteLine("instrument_method -- " + rawFile.SampleInformation.InstrumentMethodFile);
            Console.WriteLine("process_method -- " + rawFile.SampleInformation.ProcessingMethodFile);
            Console.WriteLine("position -- " + rawFile.SampleInformation.Vial);
            Console.WriteLine("inj_vol -- " + rawFile.SampleInformation.InjectionVolume);
            Console.WriteLine("level -- " + rawFile.SampleInformation.CalibrationLevel);
            Console.WriteLine("sample_wt -- " + rawFile.SampleInformation.SampleWeight);
            Console.WriteLine("sample_vol -- " + rawFile.SampleInformation.SampleVolume);
            Console.WriteLine("istd_amount -- " + rawFile.SampleInformation.IstdAmount);
            Console.WriteLine("dilution -- " + rawFile.SampleInformation.DilutionFactor);
            Console.WriteLine("comment -- " + rawFile.SampleInformation.Comment);
            Console.WriteLine("sample_name -- " + rawFile.SampleInformation.SampleName);
            Console.WriteLine("batch -- " + rawFile.SampleInformation.UserText[0]);
            Console.WriteLine("block -- " + rawFile.SampleInformation.UserText[1]);
            Console.WriteLine("class -- " + rawFile.SampleInformation.UserText[2]);
            Console.WriteLine("inj_order -- " + rawFile.SampleInformation.UserText[3]);
            Console.WriteLine("sample_order -- " + rawFile.SampleInformation.UserText[4]);
            Console.WriteLine("creation_date -- " + rawFile.FileHeader.CreationDate);
            Console.WriteLine("instrument_name -- " + rawFile.GetInstrumentData().Name);
            Console.WriteLine("instrument_model -- " + rawFile.GetInstrumentData().Model);
            Console.WriteLine("instrument_serial -- " + rawFile.GetInstrumentData().SerialNumber);
            Console.WriteLine("software_version -- " + rawFile.GetInstrumentData().SoftwareVersion);
        }
    }
}
