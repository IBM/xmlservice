import os
from itoolkit import *
from itoolkit.lib.ilibcall import *

itransport = iLibCall()

itool = iToolKit()
itool.add(iCmd('chglibl', 'CHGLIBL LIBL(XMLSERVICE)'))
#       dcl-proc GetSmart export;
#       dcl-pi  *N;
#         p0Format char(10) Value;
#         p0Type char(1) Value;
#         p0Value char(15) Value;
#         p0Channel char(5);
#         p0ChannelDesc char(50);
#         p0MPG char(5);
#         p0MPGDesc char(50);
#         p0Class char(5);
#         p0ClassDesc char(50);
#         p0Line char(5);
#         p0LineDesc char(50);
#         p0Part char(15);
#         p0PartDesc char(30);
#       end-pi;
s1 = iSrvPgm('getsmart','TESTZSRV','GETSMART')
p1 = iParm('p1',{'by':'val'})
p1.add(iData('p0Format','10a',''))
p2 = iParm('p2',{'by':'val'})
p2.add(iData('p0Type','1a',''))
p3 = iParm('p3',{'by':'val'})
p3.add(iData('p0Value','15a',''))
s1.add(p1)
s1.add(p2)
s1.add(p3)
s1.addParm(iData('p0Channel','5a',''))
s1.addParm(iData('p0ChannelDesc','50a',''))
s1.addParm(iData('p0MPG','5a',''))
s1.addParm(iData('p0MPGDesc','50a',''))
s1.addParm(iData('p0Class','5a',''))
s1.addParm(iData('p0ClassDesc','50a',''))
s1.addParm(iData('p0Line','5a',''))
s1.addParm(iData('p0LineDesc','50a',''))
s1.addParm(iData('p0Part','15a',''))
s1.addParm(iData('p0PartDesc','30a',''))

itool.add(s1)

itool.call(itransport)
chglibl = itool.dict_out('chglibl')
getsmart = itool.dict_out('getsmart')
print(chglibl['success'])
# print(getsmart)
# print(itool.xml_in())
# print(itool.xml_out())
if 'success' in getsmart:
  print(getsmart['p0Format'])
  print(getsmart['p0Type'])
  print(getsmart['p0Value'])
  print(getsmart['p0Channel'])
  print(getsmart['p0ChannelDesc'])
  print(getsmart['p0MPG'])
  print(getsmart['p0MPGDesc'])
  print(getsmart['p0Class'])
  print(getsmart['p0ClassDesc'])
  print(getsmart['p0Line'])
  print(getsmart['p0LineDesc'])
  print(getsmart['p0Part'])
  print(getsmart['p0PartDesc'])



