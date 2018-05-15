package scraper;

import java.util.Random;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import java.net.*;
import java.io.*;


public class WikiScraper {
    
    private static Random generator;
    
	public static void main(String[] args) {
            
                generator = new Random(319995);
		scrapeTopic("wiki/Python");
	}
	
               
	public static void scrapeTopic(String url){
		String html = getUrl("https://www.wikipedia.org/"+url);
		Document doc = Jsoup.parse(html);
		String contentText = doc.select("#mw-content-text [href~=^/wiki/((?!:).)*$]").first().text();
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