import os
from itoolkit import *
from itoolkit.lib.ilibcall import *

itransport = iLibCall()

itool = iToolKit()
itool.add(iCmd('chglibl', 'CHGLIBL LIBL(XMLSERVICE)'))
itool.add(
 iSrvPgm('zzarray','ZZSRV','ZZARRAY')
 .addParm(iData('myName','10a','ranger'))
 .addParm(iData('myMax','10i0','8'))
 .addParm(iData('myCount','10i0','',{'enddo':'mycnt'}))
 .addRet(
  iDS('dcRec_t',{'dim':'999','dou':'mycnt'})
  .addData(iData('dcMyName','10a',''))
  .addData(iData('dcMyJob','4096a',''))
  .addData(iData('dcMyRank','10i0',''))
  .addData(iData('dcMyPay','12p2',''))
  )
 )
itool.call(itransport)
chglibl = itool.dict_out('chglibl')
zzarray = itool.dict_out('zzarray')
print(chglibl['success'])
print(zzarray['success'])
if 'success' in zzarray:
  print(zzarray['myName'],'ranger')
  print(zzarray['myMax'],'8')
  print(zzarray['myCount'],'8')
  i = 1
  dcRec_t = zzarray['dcRec_t']
  for rec in dcRec_t:
    print(rec['dcMyName'],"ranger"+str(i))
    print(rec['dcMyJob'],"Test 10"+str(i))
    print(int(rec['dcMyRank']), 10 + i)
    print(float(rec['dcMyPay']),13.42 * i)
    i+=1


