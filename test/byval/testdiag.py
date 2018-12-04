import os
from itoolkit import *
from itoolkit.lib.ilibcall import *
itransport = iLibCall()
itool = iToolKit()
myxml  = "<diag/>"
itool.add(iXml(myxml))
# print(itool.xml_in())
itool.call(itransport)
# print(itool.xml_out())
diag = itool.dict_out()
if 'version' in diag: 
  print ("version   : "+diag['version'])

