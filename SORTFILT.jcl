//***********************************************
//*STEP TO SORT RECORDS FROM TWO DIFFERENT FILES
//***********************************************
//*
//JKE5  EXEC  PGM=SORT
//SYSOUT    DD  SYSOUT=*
//SORTJNF1 DD DSN=FIRST.FILE,DISP=SHR
//SORTJNF2 DD DSN=SECOND.FILE,DISP=SHR
//F1ONLY DD SYSOUT=*
//F2ONLY DD SYSOUT=*
//BOTH DD SYSOUT=*
//SYSIN    DD    *
* Control statements for JOINKEYS application
  JOINKEYS FILE=F1,FIELDS=(1,10,A),SORTED,NOSEQCK
  JOINKEYS FILE=F2,FIELDS=(7,10,A),SORTED,NOSEQCK
  JOIN UNPAIRED,F1,F2
  REFORMAT FIELDS=(F1:1,14,F2:1,20,?)
* Control statements for main task (joined records)
  OPTION COPY
  OUTFIL FNAMES=F1ONLY,INCLUDE=(35,1,CH,EQ,C'1'),
    BUILD=(1,14)
  OUTFIL FNAMES=F2ONLY,INCLUDE=(35,1,CH,EQ,C'2'),
    BUILD=(15,20)
  OUTFIL FNAMES=BOTH,INCLUDE=(35,1,CH,EQ,C'B'),
    BUILD=(1,14,/,15,20)
/*


https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.1.0/com.ibm.zos.v2r1.icea100/ice2ca_Example_5_-_Paired_and_unpaired_F1_F2_records__indicator_method_.htm
