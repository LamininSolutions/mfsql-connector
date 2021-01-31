Install package with logging
============================

The installer package can be executed using msiexec with parameters to
enable logging of the installation process.  This may be required for
audit or debugging purposes.

The example below must be adjusted to your specific environment and for
the specific package to be installed.  When executed in a command line
or powershell, it will execute the installer package and produce a
detail log of the entire installation procedure.  

msiexec /i "fullpathto.msi" /L*V "fullpathto.log"

-  Replace fullpathto.msi with the full path and filename of the package
-  Replace fullpathto.log with a valid path and target filename for the
   log

| 
