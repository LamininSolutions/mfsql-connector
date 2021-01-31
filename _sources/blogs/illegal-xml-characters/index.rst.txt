
Illegal XML Characters
======================

The following error results from using characters in M-Files which cannot be processed by XML

''XML parsing: line 1, character 22949464, illegal xml character''

We have come across a few instances where objects in M-Files either got corrupted, or illegal characters inadvertently crept into the object.

The Connector provide escapes for the use of the following characters that cannot normally be used in XML  These characters can be used in in M-Files
 -  Greater than and smaller than \<  \>
 -  Ampersand \&
 -  Single quotes \'
 -  Double quotes \"
 -  End of line
 -  Line feed


We discovered some control or hidden characters to cause errors. Examples include: HEX 0x01 , 0x19 , 0x14 , 0x19.  It is unknown how these hidden control characters got into M-Files, most likely as a result of copy and past where hidden characters are not displayed.

Detecting the object causing the above error requires some investigation. The update from M-Files to SQL will fail as the XML parser are unable to deal with these characters.

Use the MFAuditHistory table, combined with the MFvwAuditSummary to identify any objects not yet updated in SQL.  When the objid of a suspected records is detected then MFUpdateTable, filtered on the object objid can be used to validate the suspect.
