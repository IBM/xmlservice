     H AlwNull(*UsrCtl)

     D  INCHARA        S             64a
     D  INCHARB        S          32000a
     D  INCHARC        S          32000a       
     D  INCHARD        S              4a
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     C     *Entry        PLIST                   
     C                   PARM                    INCHARA
     C                   PARM                    INCHARB
     C                   PARM                    INCHARC
     C                   PARM                    INCHARD
      /free
        return;
      /end-free

