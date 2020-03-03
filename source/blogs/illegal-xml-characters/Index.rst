Illegal XML Characters
======================

The following error results from using characters in M-Files which cannot be processed by XML

**XML parsing: line 1, character 22949464, illegal xml character**

We have come accross a few instances where objects in M-Files either got corrupted, or illegal characters inadvertantly crept into the object.

The Connector provide escapes for the use of the following characters that cannot normally be used in XML  These characters can be used in in M-Files
 -  Greater than and smaller than \<  \>
 -  Ampersand \&
 -  Single quotes \'
 -  Double quotes \"
 -  End of line
 -  Line feed
 
 
The following characters must be avoided
 -  control or hidden characters examples include the following that we have come accross to cause errors HEX 0x01 , 0x19 , 0x14 , 0x19.  It is unknown how these hidden control characters got into M-Files

Detecting the exact object that is causing the above error requires some investigation as the it would not be possible to update SQL with an M-files object with these characters.

Use the MFAuditHistory table, combined with the MFvwAuditSummary to identify any objects that is not yet updated in SQL. When the objid is detected from this table then MFUpdateTable filtered with the specific objid can be used to test the update from M-Files and detect if it is one of the objects that fails on an illegal character.
