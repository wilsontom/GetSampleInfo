// --------------------------------------------------------------------------------------------------------------------
// <copyright file="Program.cs" company="Thermo Fisher Scientific">
//   Copyright © Thermo Fisher Scientific. All rights reserved.
// </copyright>
// This source file contains the code for the console application that demonstrates who to
// read our RAW files using the RAWFileReader .Net library.  This example uses only a fraction
// of the functions available in the RawFileReader library.  Please consult the RawFileReader
// documentation for a complete list of methods available.
// 
// This code has been compiled and tested using Visual Studio 2013 Update 5, Visual Studio 
// 2015 Update 3, Visual Studio 2017 Update 2, Visual Studio MAC, and MonoDevelop.  Additional 
// tools used include Resharper 2017.1.  This application has been tested with .Net Framework 4.5.1, 
// 4.5.2, 4.6, 4.6.1, 4.6.2, and 4.7.
//
// Questions about the program can be directed to jim.shofstahl@thermofisher.com
// --------------------------------------------------------------------------------------------------------------------
namespace RawFileReaderGetSampleInfo
{
    // These are the libraries necessary to read the Thermo RAW files.  The Interfaces
    // library contains the extension for accessing the scan averaging and background
    // subtraction methods.
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.IO;
    using System.Runtime.ExceptionServices;

    using ThermoFisher.CommonCore.Data;
    using ThermoFisher.CommonCore.Data.Business;
    using ThermoFisher.CommonCore.Data.FilterEnums;
    using ThermoFisher.CommonCore.Data.Interfaces;
    using ThermoFisher.CommonCore.MassPrecisionEstimator;
    using ThermoFisher.CommonCore.RawFileReader;

    /// <summary>
    /// A C# example program showing how to use RAWFileReader.  More information on the RAWFileReader methods used
    /// in this example and the other methods available in RAWFileReader can be found in the RAWFileReader user
    /// documentation, that is installed with the RAWFileReader software.
    /// This program has been tested with RAWFileReader 4.0.22  Changes maybe necessary with other versions
    /// of RAWFileReader.
    /// </summary>
    internal static class Program
    {
        /// <summary>
        /// The main routine for this example program.  This example program only shows how to use the RawFileReader library
        /// in a single-threaded application but our documentation for RawFileReader describes how to use it in a multi-threaded
        /// application.
        /// </summary>
        /// <param name="args">The command line arguments for this program.  The RAW file name should be passed as the first argument</param>
        private static void Main(string[] args)
        {
            // Get the memory used at the beginning of processing

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

            // Check to see if the specified RAW file exists
            if (!File.Exists(filename))
            {
                Console.WriteLine(@"The file doesn't exist in the specified location - " + filename);

                return;
            }

            // Create the IRawDataPlus object for accessing the RAW file
            var rawFile = RawFileReaderAdapter.FileFactory(filename);

            if (!rawFile.IsOpen || rawFile.IsError)
            {
                Console.WriteLine("Unable to access the RAW file using the RawFileReader class!");

                return;
            }


     // Get the number of instruments (controllers) present in the RAW file and set the 
            // selected instrument to the MS instrument, first instance of it

            rawFile.SelectInstrument(Device.MS, 1);


            // Get some information from the header portions of the RAW file and display that information.
            // The information is general information pertaining to the RAW file.


            // Get information related to the sample that was processed
            Console.WriteLine("sample_type -- " + rawFile.SampleInformation.SampleType);
            Console.WriteLine("file_name -- " + rawFile.SampleInformation.RawFileName);
            Console.WriteLine("sample_id -- " + rawFile.SampleInformation.Path);
            Console.WriteLine("instrument_method -- " + rawFile.SampleInformation.InstrumentMethodFile);
            Console.WriteLine("process_method -- " + rawFile.SampleInformation.ProcessingMethodFile);
            Console.WriteLine("positiion -- " + rawFile.SampleInformation.Vial);
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

        }
    }

}