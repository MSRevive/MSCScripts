Update the items.txt list if applicable
-Adding items requires updating this list

Remove the developer folder so it is not compiled
-Dev scripts should not be compiled at all

Use the -vr flag to with the scriptpack.exe to compiled scripts for release.
- The 'e' flag will print errors to via file 'errors.txt'
- The 'r' flag will remove all debug messages and whitespaces.
- The 'v' means verbose printing.

It is recommend to use the batch files to pack the scripts as it does everything for you.
- 'pack_dev.bat' will pack the scripts for dev builds.
- '!pack_release.bat' will pack the scripts for release builds.

----
-h output:

USAGE:

   scriptpack  [-efhprv] [--version] [-o <The output directory for packed
               scripts>]


Where:

   -o <The output directory for packed scripts>,  --output <The output
      directory for packed scripts>
     Output Directory

   -r,  --release
     Release build, this will clean the scipts then pack them.

   -v,  --verbose
     Verbose printing.

   -e,  --errfile
     Print errors to text file.

   -f,  --fail
     Exit on script error.

   -p,  --pack
     Turn off script packing.

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.

   Packs via scripts for use with MSR