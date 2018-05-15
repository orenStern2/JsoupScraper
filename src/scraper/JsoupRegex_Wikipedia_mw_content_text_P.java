package scraper;

import org.jsoup.Jsoup;
import java.net.*;
import java.io.*;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;


public class JsoupRegex_Wikipedia_mw_content_text_P {
	public static void main(String[] args) {
		scrapeTopic("/wiki/Python");
	}
	
	public static void scrapeTopic(String url){
		String html = getUrl("https://www.wikipedia.org/"+url);
		Document doc = Jsoup.parse(html);
                String contentText = doc.select("#mw-content-text p").first().text();

		System.out.println(contentText);
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