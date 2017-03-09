import os
from itoolkit import *
from itoolkit.lib.ilibcall import *

itransport = iLibCall()

itool = iToolKit()
itool.add(iCmd('chglibl', 'CHGLIBL LIBL(XMLSERVICE)'))
#       dcl-pr testval5 int(20);
#         arg1 int(3);
#         arg2 int(5);
#         arg3 int(10);
#         arg4 int(20);
#       end-pr;
s1 = iSrvPgm('testval5','TESTZSRV','TESTVAL5')
p1 = iParm('p1',{'by':'val'})
p1.add(iData('arg1','3i0','4'))
p2 = iParm('p2',{'by':'val'})
p2.add(iData('arg2','5i0','5'))
p3 = iParm('p3',{'by':'val'})
p3.add(iData('arg3','10i0','6'))
p4 = iParm('p4',{'by':'val'})
p4.add(iData('arg4','20i0','7'))
s1.add(p1)
s1.add(p2)
s1.add(p3)
s1.add(p4)
s1.addRet(iData('retval','20i0','0'))
itool.add(s1)
print(itool.xml_in())
exit()
itool.call(itransport)
chglibl = itool.dict_out('chglibl')
testval5 = itool.dict_out('testval5')
print(itool.xml_out())
print(chglibl['success'])
print(testval5['success'])
if 'success' in testval5:
  print(testval5['arg1'])
  print(testval5['arg2'])
  print(testval5['arg3'])
  print(testval5['arg4'])
  print(testval5['retval'])


