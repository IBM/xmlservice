  Exec Sql SET PATH *LIBL;
  Exec Sql Call TAPECHEK(:param) ; 
   Exec SQL   Set Option Commit=*NONE, Naming=*SQL
                         DatFmt=*ISO,  CloSQLCsr=*ENDACTGRP;

