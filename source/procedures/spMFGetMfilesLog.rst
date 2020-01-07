
================
spMFGetMfilesLog
================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @IsClearMfilesLog bit (optional)
    - Default = 0
    - 1 = Clear Mfiles log
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

The purpose of this procedure is to insert Mfiles Log details into MFEventLog_OpenXML table.

Additional Info
===============

This procedure can be used on demand. Alternatively it can be included in an Agent to schedule the export on a regular basis.  This may be particularly relevant as M-Files automatically drops events and only maintain the last 10 000 event records.


Example XML for a new object
----------------------------

.. code:: xml

    <event>
      <id>35543</id>
      <type id="NewObject">New document or other object</type>
      <category id="3">NewObject</category>
      <timestamp>2016-11-25 16:27:57.226000000</timestamp>
      <causedbyuser loginaccount="LS-CilliersL" />
      <data>
        <objectversion>
          <objver>
            <objtype id="162">Test</objtype>
            <objid>1163</objid>
            <version>1</version>
          </objver>
          <extid extidstatus="Internal">1163</extid>
          <objectguid>{84E076F0-92A1-49CD-961E-D4A293512FC3}</objectguid>
          <versionguid>{6B2E37C4-2D8F-4B33-A5BE-A117BB9EF7D3}</versionguid>
          <objectflags value="64">
            <objectflag id="64">normal</objectflag>
          </objectflags>
          <originalobjid>
            <vault>{3F4B2DFA-6D56-4D2D-AC4C-8AB3EF7DFE54}</vault>
            <objtype>162</objtype>
            <id>1163</id>
          </originalobjid>
          <title>Lakeisha222</title>
          <displayid>1163</displayid>
        </objectversion>
      </data>
    </event>

Examples
========

.. code:: sql

    EXEC [dbo].[spMFGetMfilesLog]
         @IsClearMfilesLog = 0 -- bit

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2018-04-04  DEV2       Added Licensing module validation code.
2017-09-24  LC         Fix bug 'unknown column'
2017-01-23  DEV2       The purpose of this procedure is to insert Mfiles Log details into MFEventLog_OpenXML table.
==========  =========  ========================================================

