Limitations of real datatype
============================

Updating properties with the real datatype property in M-Files have some special considerations

An M-Files property of type Number (real) accepts values between -1,79E308 and 1,79E308. When any number within this limit is entered in M-Files it will populate through to the class table.

However, only numbers between -1,79E27 and 1,79E27  can be updated from SQL to M-Files. This limitation is related to M-Files automatically rounding numbers with decimal places in accordance to the number of decimal places for the vault.

Rounding a float number in SQL is known to produce inconsistent results.  This could make the comparison of values between M-Files and SQL inconsistent, and this may impact on integration with external systems.  MFSQL Therefore converts the number in the Class table to a decimal(32,4) to eliminate the issues with the rounding in M-Files.
