/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sqlutilitycrud.controller;

import com.mycompany.sqlutilitycrud.dao.PodcastDao;
import com.mycompany.sqlutilitycrud.model.Podcast;
import com.mycompany.sqlutilitycrud.model.Users;
import java.io.InputStream;
import java.net.URL;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

/**
 *
 * @author abhi
 */

@Controller
public class PodcastController {
    
    @Autowired
    PodcastDao dao;
    
   @RequestMapping(value="/home.fin", method = RequestMethod.GET)
    public String showHome(HttpSession session , Model model){
        //session check 
        
        Users u = (Users) session.getAttribute("loggedUser");
        if(u == null){
            return "redirect:/login.fin";
        }
        
        //Fatch all podcast at home page
        List<Podcast> allPodcasts = dao.getAllPodcasts();
        model.addAttribute("allPodcasts", allPodcasts);
        
        return "home";
    }
    
    //Profile page 
   
    @RequestMapping(value = "/profile.fin", method = RequestMethod.GET)
    public String showProfile(HttpSession session, Model model){
        Users u = (Users) session.getAttribute("loggedUser");
        
        if(u == null){
            return "redirect:/login.fin";
        }
        
        List<Podcast> myPodcasts = dao.getPodcastByUserId(u.getID());
         model.addAttribute("myPodcasts", myPodcasts);
     
        return "profile";
    }
    
    @RequestMapping(value = "/podcast/add.fin" , method = RequestMethod.POST)
    public String addPodcast(HttpServletRequest request, HttpSession session){
        
        Users u = (Users) session.getAttribute("loggedUser");
        if(u == null){
            return "redirect:/login.fin";
        }
        
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        String feedUrl = request.getParameter("feedUrl");
        String description = request.getParameter("description");
        String audioUrl = fetchAudioFromRSS(feedUrl);
        String coverImageUrl = fetchCoverFromRSS(feedUrl);
        
        Podcast p = new Podcast();
        p.setTitle(title);
        p.setAuthor(author);
        p.setCategory(category);
        p.setFeedUrl(feedUrl);
        p.setDescription(description);
        p.setCoverImageUrl(coverImageUrl);
        p.setAudioUrl(audioUrl);
        p.setUserId(u.getID());
        dao.addPodcast(p);
        
        return "redirect:/home.fin";
        
    }
    
//    Update Podcast
    @RequestMapping(value = "/podcast/update.fin", method = RequestMethod.POST)
    public String updatePodcast(HttpServletRequest request, HttpSession session){
        
        Users u = (Users) session.getAttribute("loggedUser");
        
          if (u == null) return "redirect:/login.fin";
         
          int id = Integer.parseInt(request.getParameter("id"));
         
         //security check this podcast owned by logged user?
         
           Podcast existing = dao.getPodcastById(id);
        if (existing == null || existing.getUserId() != u.getID()) {
            return "redirect:/profile.fin"; // not your podcast!
        }
        
        String feedUrl = request.getParameter("feedUrl");
        String audioUrl = fetchAudioFromRSS(feedUrl);
        
        String coverImage = existing.getCoverImageUrl();
        if(!feedUrl.equals(existing.getFeedUrl())){
            coverImage = fetchCoverFromRSS(feedUrl);
            
        }
        
        Podcast p = new Podcast();
        p.setId(id);
        p.setTitle(request.getParameter("title"));
        p.setAuthor(request.getParameter("author"));
        p.setCategory(request.getParameter("category"));
        p.setFeedUrl(feedUrl);
        p.setDescription(request.getParameter("description"));
        p.setCoverImageUrl(coverImage);
        p.setAudioUrl(audioUrl);
        p.setUserId(u.getID());
        
        dao.updatePodcast(p);
        
        return "redirect:/profile.fin";
        
    }
    
    //delete podcast
    
    @RequestMapping(value="/podcast/delete.fin" , method = RequestMethod.POST)
    public String deletePocast(HttpServletRequest request, HttpSession session){
        
        Users u = (Users) session.getAttribute("loggedUser");
        
        if(u == null) return "redirect:/login.fin";
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        Podcast existing = dao.getPodcastById(id);
        if(existing == null || existing.getUserId() != u.getID()){
        return "redirect:/profile.fin"; //not your podcast
        }
        
        dao.deletePodcast(id, u.getID());
        
        return "redirect:/profile.fin";
    }
    
    //search Podacst
    
    @RequestMapping(value = "/podcast/search.fin", method = RequestMethod.GET)
    public String searchPodcasts(@RequestParam(value = "q", defaultValue = "") String keyword,
            HttpSession  session , Model model){
        
        Users u = (Users) session.getAttribute("loggedUser");
         if(u == null) return "redirect:/login.fin";
         
        List<Podcast> results = dao.searchPodcasts(keyword);
        model.addAttribute("results", results);
        model.addAttribute("keyword", keyword);
        
        return "search";
        
    }
    
@RequestMapping(value = "/podcast/category.fin", method = RequestMethod.GET)
public String filterByCategory(@RequestParam("cat") String category,
                                HttpSession session, Model model) {
    Users u = (Users) session.getAttribute("loggedUser");
    if (u == null) return "redirect:/login.fin";

    // Use getByCategory instead of searchPodcasts!
    List<Podcast> results = dao.getByCategory(category);
    model.addAttribute("results", results);
    model.addAttribute("keyword", category);

    return "search";
}
    
        @RequestMapping(value = "/logout.fin")
    public String logout(HttpSession session){
        session.invalidate();
         return "redirect:/login.fin";
    }
    
//    private String fetchCoverFromRSS(String feedUrl) {
//    try {
//        URL url = new URL(feedUrl);
//        InputStream is = url.openStream();
//        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
////        factory.setNamespaceAware(true);
//        factory.setNamespaceAware(false);
//        DocumentBuilder builder = factory.newDocumentBuilder();
//        Document doc = builder.parse(is);
//
//        // Try itunes:image href
//        NodeList list = doc.getElementsByTagNameNS("*", "image");
//        for (int i = 0; i < list.getLength(); i++) {
//            org.w3c.dom.NamedNodeMap attrs = list.item(i).getAttributes();
//            if (attrs != null && attrs.getNamedItem("href") != null) {
//                String href = attrs.getNamedItem("href").getNodeValue();
//                if (href != null && !href.isEmpty()) return href;
//            }
//        }
//
//        // fallback standard <image><url>
//        NodeList urls = doc.getElementsByTagName("url");
//        if (urls.getLength() > 0) {
//            String imgUrl = urls.item(0).getTextContent();
//            if (imgUrl != null && !imgUrl.isEmpty()) return imgUrl;
//        }
//
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
//    return null;
//}
    
    private String fetchCoverFromRSS(String feedUrl) {

    try {

        URL url = new URL(feedUrl);
        InputStream is = url.openStream();

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

        factory.setNamespaceAware(false);

        DocumentBuilder builder = factory.newDocumentBuilder();

        Document doc = builder.parse(is);

        NodeList images = doc.getElementsByTagName("itunes:image");

        if (images.getLength() > 0) {

            org.w3c.dom.Element el =
                    (org.w3c.dom.Element) images.item(0);

            String href = el.getAttribute("href");

            if (href != null && !href.isEmpty()) {
                return href;
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return "";
}

// NEW fetchAudioFromRSS — only MP3 link!
//private String fetchAudioFromRSS(String feedUrl) {
//    try {
//        URL url = new URL(feedUrl);
//        InputStream is = url.openStream();
//        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
//        factory.setNamespaceAware(true);
//        DocumentBuilder builder = factory.newDocumentBuilder();
//        Document doc = builder.parse(is);
//
//        // <enclosure> tag contains MP3 link
//        NodeList enclosures = doc.getElementsByTagName("enclosure");
//        for (int i = 0; i < enclosures.getLength(); i++) {
//            org.w3c.dom.NamedNodeMap attrs = enclosures.item(i).getAttributes();
//            if (attrs != null && attrs.getNamedItem("url") != null) {
//                String mp3 = attrs.getNamedItem("url").getNodeValue();
//                if (mp3 != null && !mp3.isEmpty()) return mp3;
//            }
//        }
//
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
//    return null;
//}
    
    private String fetchAudioFromRSS(String feedUrl) {

    try {

        URL url = new URL(feedUrl);

        InputStream is = url.openStream();

        DocumentBuilderFactory factory =
                DocumentBuilderFactory.newInstance();

        factory.setNamespaceAware(false);

        DocumentBuilder builder =
                factory.newDocumentBuilder();

        Document doc = builder.parse(is);

        NodeList enclosures =
                doc.getElementsByTagName("enclosure");

        for (int i = 0; i < enclosures.getLength(); i++) {

            org.w3c.dom.Element el =
                    (org.w3c.dom.Element) enclosures.item(i);

            String audio = el.getAttribute("url");

            if (audio != null && !audio.isEmpty()) {
                return audio;
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return "";
}
}
