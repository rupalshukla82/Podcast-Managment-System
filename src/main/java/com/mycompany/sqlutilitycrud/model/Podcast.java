/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sqlutilitycrud.model;

import java.sql.Timestamp;

/**
 *
 * @author abhi
 */
public class Podcast {
    
    private int id;
    private String title;
    private String author;
    private String category;
    private String description;
    private String coverImageUrl;
    private String feedUrl;
    private int UserId;
    private Timestamp createdAt;
    private String audioUrl;
    
    public Podcast(){
        
    }

    public Podcast(int id, String title, String author, String category, String description, 
            String coverImageUrl, String feedUrl, int UserId, Timestamp createdAt) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.category = category;
        this.description = description;
        this.coverImageUrl = coverImageUrl;
        this.feedUrl = feedUrl;
        this.UserId = UserId;
        this.createdAt = createdAt;
    }
    
 
    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public String getCategory() {
        return category;
    }

    public String getDescription() {
        return description;
    }

    public String getCoverImageUrl() {
        return coverImageUrl;
    }

    public String getFeedUrl() {
        return feedUrl;
    }

    public int getUserId() {
        return UserId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public String getAudioUrl() {
        return audioUrl;
    }


    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setCoverImageUrl(String coverImageUrl) {
        this.coverImageUrl = coverImageUrl;
    }

    public void setFeedUrl(String feedUrl) {
        this.feedUrl = feedUrl;
    }

    public void setUserId(int UserId) {
        this.UserId = UserId;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public void setAudioUrl(String audioUrl) { 
        this.audioUrl = audioUrl; 
    }
    
    
}
