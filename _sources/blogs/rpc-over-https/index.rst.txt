
RPC over HTTPS setup
====================



In order to overcome the issue with “Access Denied” message when connecting to M-Files using the M-Files Desktop with HTTPS protocol, please add/update the following registry setting on SQL Server is required.

Registry key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp
Value name: EnableDefaultHttp2
Value type: DWORD (32 bit)
Value data: 00000000


Note: This is based on the following M-Files KB. https://support.m-files.com/index.php?/Knowledgebase/Article/View/101/0/m-files-and-windows-10-1709-fall-creators-update-access-is-denied-error


