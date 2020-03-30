Using CLR
=========

The Connector make extensive use of the **Common Language
Runtime** (**CLR**) as part of its architecture. This virtual machine
component of Microsoft's .NET framework, manages the execution of .NET
programs. Without CLR it would be impossible to use T-SQL store
procedures to interact with M-Files and perform advanced functions in
the process.

T-SQL is very strong when it comes to manipulating sets of data. CLR is
very strong in other areas, like string and date manipulation, calling
external services. T-SQL stored procedures and CLR stored procedures are
deployed in the Connectors to complement each other - each solving a
specific set of challenges that the other is not particularly good at.

CLR integration feature is off by default in SQL Server, and must be enabled in order to use objects that are implemented using CLR integration. The Connector use CLR as described in Using CLR section.  To enable CLR integration, the \ **clr
enabled** option of the \ **sp_configure** stored procedure is set in
the installation scripts.  The following is included in the script
script.update_Assembly.sql.

TRUSTWORTHY will be set ON in order to create assembly with
PERMISSION_SET = UNSAFE.

sp_configure'show advanced options', 1; GO RECONFIGURE; GO
sp_configure'clr enabled', 1; GO RECONFIGURE; GO

CLR integration can be disabled by setting the clr enabled option to 0.
When CLR integration is disabled, SQL Server stops executing all CLR
routines and unloads all application domains. The Connector will not
function if CLR is disabled.

Learn more on the use of CLR in the Connector in the following sections

Architecture of CLR Integration
-------------------------------

The user code runs inside the CLR-hosted environment in SQL Server
(called CLR integration). The following design goals were applied in the
Connector:

Reliability (Safety)
~~~~~~~~~~~~~~~~~~~~

User code are not allowed to perform operations that compromise the
integrity of the Database Engine process, such as popping a message box
requesting a user response or exiting the process. User code
doesoverwrite theDatabase Engine memory buffers or internal data
structures.

Scalability
~~~~~~~~~~~

SQL Server and the CLR have different internal models for scheduling and
memory management. SQL Server supports a cooperative, non-pre-emptive
threading model in which the threads voluntarily yield execution
periodically, or when they are waiting on locks or I/O. The CLR supports
a pre-emptive threading model. If user code running inside SQL Server
can directly call the operating system threading primitives, then it
does not integrate well into the SQL Server task scheduler and can
degrade the scalability of the system. The CLR does not distinguish
between virtual and physical memory, but SQL Server directly manages
physical memory and is required to use physical memory within a
configurable limit.

The architecture have taken scalability of the system into account and
is not compromised by user code calling application programming
interfaces (APIs) for threading, memory, and synchronization primitives
directly.

Performance
~~~~~~~~~~~

The managed user code running in the Database Engine have computational
performance comparable to the same code run that outside the server. We
have taken into account that Database access from managed user code is
not as fast as native Transact-SQL and where appropriate use
Transact-SQL.

Type safety verification
~~~~~~~~~~~~~~~~~~~~~~~~

Type-safe code is code that accesses memory structures only in
well-defined ways. For example, given a valid object reference,
type-safe code can access memory at fixed offsets corresponding to
actual field members. However, if the code accesses memory at arbitrary
offsets inside or outside the range of memory that belongs to the
object, then it is not type-safe. When assemblies are loaded in the CLR,
prior to the MSIL being compiled using just-in-time compilation, the
runtime performs a verification phase that examines code to determine
its type-safety. The managed code in the Connector is verifiably
type-safe code.

Application domains
~~~~~~~~~~~~~~~~~~~

The CLR supports the notion of application domains as execution zones
within a host process where managed code assemblies can be loaded and
executed. The application domain boundary provides isolation between
assemblies. The assemblies are isolated in terms of visibility of static
variables and data members and the ability to call code dynamically.
Application domains are also the mechanism for loading and unloading
code. Code are unloaded from memory only by unloading the application
domain.

Code Access Security(CAS)
~~~~~~~~~~~~~~~~~~~~~~~~~

The CLR security system provides a way to control what kinds of
operations managed code can perform by assigning permissions to code.
Code access permissions are assigned based on code identity (for
example, the signature of the assembly or the origin of the code).

The CLR provides for a computer-wide policy that can be set by the
computer administrator. This policy defines the permission grants for
any managed code running on the machine. In addition, there is a
host-level security policy that can be used by hosts such as SQL Server
to specify additional restrictions on managed code.

If a managed API in the .NET Framework exposes operations on resources
that are protected by a code access permission, the API will demand that
permission before accessing the resource. This demand causes the CLR
security system to trigger a comprehensive check of every unit of code
(assembly) in the call stack. Only if the entire call chain has
permission will access to the resource be granted.

Application of CLR in store procedures
--------------------------------------

The stored procedures are implemented as public static methods on a
class in the Microsoft .NET Framework assemblies are included in the
Connector. The static method can either be declared as void, or return
an integer value. If it returns an integer value, the integer returned
is treated as the return code from the procedure. For example: EXECUTE
@return_status = procedure_name. The @return_status variable will
contain the value returned by the method. If the method is declared
void, the return code is 0. If the method takes parameters, the number
of parameters in the .NET Framework implementation should be the same as
the number of parameters used in the Transact-SQL declaration of the
stored procedure.

The CLR supplies managed code with services such as cross-language
integration, code access security, object lifetime management, and
debugging and profiling support. Using CLR integration allowed the
Connector to be integrated with stored procedures and can use triggers,
user-defined types, user-defined functions (scalar and table-valued),
and user-defined aggregate functions to perform its functions.

Benefits of using CLR
---------------------

Among the major benefits of this integration are:

-  **A better programming model**. The .NET Framework languages are in
   many respects richer than Transact-SQL, offering constructs and
   capabilities previously not available to SQL Server developers. We
   can leverage the power of the .NET Framework Library, which provides
   an extensive set of classes that can be used to quickly and
   efficiently solve programming problems.
-  **Improved safety and security.** Managed code runs in a common
   language run-time environment, hosted by the Database Engine. SQL
   Server leverages this to provide a safer and more secure alternative
   to the extended stored procedures available in earlier versions of
   SQL Server.
-  **Ability to define data types and aggregate functions.** User
   defined types and user defined aggregates are new managed database
   objects which expand the storage and querying capabilities of SQL
   Server.
-  **Streamlined development through a standardized
   environment.** Database development is integrated into future
   releases of the Microsoft Visual Studio .NET development environment.
   We use the same tools for developing and debugging database objects
   and scripts as the tools that we use to write middle-tier or
   client-tier .NET Framework components and services.
-  **Potential for improved performance and scalability.** In many
   situations, the .NET Framework language compilation and execution
   models deliver improved performance over Transact-SQL.

Securing the use of CLR
-----------------------

There are risks associated with the deployment of CLR. We have adopted
safeguarding principles and recommend the following deployment
principles to manage and secure the use of the CLR.

Deploying code into the database is the responsibility of the DBA.
Sometimes CLR code is deployed directly from the external application
into the database. However, the CLR assemblies that is used by the
Connectors is not deployed automatically from the Visual Studio
Environment, but is deployed by the DBA as described later in this
document.

The deployment process allow both the installation and the
upgrade/uninstall of the CLR as a DBA responsibility using standard SQL
procedures.

CLR Integration Security
~~~~~~~~~~~~~~~~~~~~~~~~

The security model of the SQL Server integration with CLR manages and
secures access between different types of CLR and non-CLR objects
running within SQL Server. Object external to SQL are called by the
procedures in the Connector. CLR provides for different types of
permissions sets to control the permissions for the assemblies. These
permission sets include SAFE, EXTERNAL_ACCESS and UNSAFE.

Currently the UNSAFE mode is the only method that allows for interacting
with Interop Assemblies with unmanaged code. The Connector use the
M-Files Interop assembly to access M-Files which leaves no alternative
but to deploy the UNSAFE mode for the Connector. However, t he Connector
managed code does not gain access to user data or other user code
exernal to the database except for data in M-Files. The User-defined
code runs under the security context of the user-session that invoked
it, and with the correct privileges for that security context.
