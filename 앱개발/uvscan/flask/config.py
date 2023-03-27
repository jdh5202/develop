import xml.etree.ElementTree as ET

class GPath:
    jadx_path = 'Tools/jadx/bin'
    win_jadx_path = 'Tools\\jadx\\bin\\'
    apk_file_path = None
    apkfile= None

class XmlPath:
    Strings = "C://Users//jkb//Desktop//flask//Tools//jadx//bin//out//resources//res//values//strings.xml"
    AOSManifest = "C://Users//jkb//Desktop//flask//Tools//jadx//bin//out//resources//AndroidManifest.xml"
    
    
class XmlPc:
    def __init__(self):
        self.xml_tree = None
        
    def parse_xml(self, xml_path):
        self.xml_tree = ET.parse(xml_path)
        return self.xml_tree
        
G_path = vars(GPath)
xml_path = vars(XmlPath)
xmlPc = XmlPc()