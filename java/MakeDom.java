import java.io.File;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class MakeDom {
	public static Document xmldoc;
	public static XPath xPath;
	public static final String fileName="masterf.xml";

	public static void main(String[] args) throws Exception {
		
		//preparation	
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		factory.setValidating(true);
		DocumentBuilder builder = factory.newDocumentBuilder();
		xmldoc = builder.parse(new File(fileName));
		
		xPath =  XPathFactory.newInstance().newXPath();
		
		Document res_xml=builder.newDocument();
		Element root=res_xml.createElement("list-ues");
		
		// Extraction des données avec xPath
		NodeList nodes=(NodeList) xPath.compile("//ue/nom").evaluate(xmldoc,XPathConstants.NODESET);
		for (int i = 0; (i < nodes.getLength()); i++) {
	        Node ue=root.appendChild(res_xml.createElement("ue"));
	        ue.appendChild(res_xml.createTextNode(nodes.item(i).getTextContent()));
	    }
		
		res_xml.appendChild(root);
		
		//Serialisation
		TransformerFactory myFactory = TransformerFactory.newInstance();
		Transformer transformer = myFactory.newTransformer();
		transformer.setOutputProperty(OutputKeys.ENCODING, "ISO-8859-1");
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");
		transformer.setOutputProperty(OutputKeys.METHOD, "xml");

	    transformer.transform(new DOMSource(res_xml),
	         new StreamResult(System.out));
	}
}
