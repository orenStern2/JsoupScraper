package scraper;

import org.jsoup.Jsoup;
import java.net.*;
import java.io.*;
import org.jsoup.select.Elements;


public class JsoupRegex_getSpecificLine_4th {
	public static void main(String[] args) {
		scrapeTopic("wiki/Python");
	}
	
	public static void scrapeTopic(String url){
		String html = getUrl("https://www.wikipedia.org/"+url);
		Elements doc = Jsoup.parse(html).getElementsMatchingOwnText("(?i)[0-9]th");
                String desc = doc.text();       
                
                
                
		System.out.println(desc);
	}
	
	public static String getUrl(String url){
URL urlObj = null;
try{
urlObj = new URL(url);
}
catch(MalformedURLException e){
System.out.println("The url was malformed!");
return "";
}
URLConnection urlCon = null;
BufferedReader in = null;
String outputText = "";
try{
urlCon = urlObj.openConnection();
in = new BufferedReader(new
InputStreamReader(urlCon.getInputStream()));
String line = "";
while((line = in.readLine()) != null){
outputText += line;
}
in.close();
}catch(IOException e){
System.out.println("There was an error connecting to the URL");
return "";
}
return outputText;
}
}