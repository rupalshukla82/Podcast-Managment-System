/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sqlutilitycrud.dao;

import com.mycompany.sqlutilitycrud.model.Podcast;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.swing.text.html.HTML;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author abhi
 */
@Repository
public class PodcastDao {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    //list all podcast
    public List<Podcast> getAllPodcasts() {
        String q = "select * from podcasts  order by created_at desc";

        Map<String, Object> params = new HashMap<>();

        try {

            return jdbcTemplate.query(q, params, new RowMapper<Podcast>() {
                @Override
                public Podcast mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Podcast p = new Podcast();
                    p.setId(rs.getInt("id"));
                    p.setTitle(rs.getString("title"));
                    p.setAuthor(rs.getString("author"));
                    p.setCategory(rs.getString("category"));
                    p.setDescription(rs.getString("description"));
                    p.setCoverImageUrl(rs.getString("cover_image_url"));
                    p.setFeedUrl(rs.getString("feed_url"));
                    p.setAudioUrl(rs.getString("audio_url"));
                    p.setUserId(rs.getInt("user_id"));
                    p.setCreatedAt(rs.getTimestamp("created_at"));
                    return p;
                }
            });

        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();

        }

    }
    //Search podcast by user id 

    public List<Podcast> getPodcastByUserId(int userId) {
        String q = "select * from podcasts where user_id = :userId order by created_at desc";
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);

        try {

            return jdbcTemplate.query(q, params, (rs, rowNum) -> {
                Podcast p = new Podcast();
                p.setId(rs.getInt("id"));
                p.setTitle(rs.getString("title"));
                p.setAuthor(rs.getString("author"));
                p.setCategory(rs.getString("category"));
                p.setDescription(rs.getString("description"));
                p.setCoverImageUrl(rs.getString("cover_image_url"));
                p.setFeedUrl(rs.getString("feed_url"));
                p.setAudioUrl(rs.getString("audio_url"));
                p.setUserId(rs.getInt("user_id"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                return p;
            });

        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    //get single podcastby id
    public Podcast getPodcastById(int id) {
        String q = "select * from podcasts where id = :id ";
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);

        try {

            return jdbcTemplate.queryForObject(q, params, (rs, rowNum) -> {
                Podcast p = new Podcast();
                p.setId(rs.getInt("id"));
                p.setTitle(rs.getString("title"));
                p.setAuthor(rs.getString("author"));
                p.setCategory(rs.getString("category"));
                p.setDescription(rs.getString("description"));
                p.setCoverImageUrl(rs.getString("cover_image_url"));
                p.setFeedUrl(rs.getString("feed_url"));
                p.setAudioUrl(rs.getString("audio_url"));
                p.setUserId(rs.getInt("user_id"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                return p;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    //Add Podacats 
    public void addPodcast(Podcast p) {

        String q = "insert into podcasts(title,author,category, description, cover_image_url,feed_url,audio_url,user_id)"
                + " values(:title, :author, :category, :description, :coverImageUrl ,:feedUrl,:audioUrl, :userId) ";
        Map<String, Object> params = new HashMap<>();
        params.put("title", p.getTitle());
        params.put("author", p.getAuthor());
        params.put("category", p.getCategory());
        params.put("description", p.getDescription());
        params.put("coverImageUrl", p.getCoverImageUrl());
        params.put("feedUrl", p.getFeedUrl());
         params.put("audioUrl", p.getAudioUrl());
        params.put("userId", p.getUserId());

        try {

            jdbcTemplate.update(q, params);
        } catch (Exception e) {
            e.printStackTrace();

        }
    }

    //Update Podcast
    public void updatePodcast(Podcast p) {

        String q = "update podcasts set title=:title, author=:author, category=:category,"
         + " description=:description, cover_image_url=:coverImageUrl,"
         + " feed_url=:feedUrl, audio_url=:audioUrl"  // 
         + " where id=:id and user_id=:userId";

        Map<String, Object> params = new HashMap<>();

        params.put("title", p.getTitle());
        params.put("author", p.getAuthor());
        params.put("category", p.getCategory());
        params.put("description", p.getDescription());
        params.put("coverImageUrl", p.getCoverImageUrl());
        params.put("feedUrl", p.getFeedUrl());
        params.put("audioUrl", p.getAudioUrl());
        params.put("id", p.getId());
        params.put("userId", p.getUserId());

        try {
            jdbcTemplate.update(q, params);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void deletePodcast(int id, int userId){
        
        String q = "delete from podcasts where id=:id and user_id=:userId ";
       
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("userId", userId);  
        
        try{
            jdbcTemplate.update(q, params);
        }
        catch(Exception e){
            e.printStackTrace();
            
        }
    }
    
    public List<Podcast> searchPodcasts(String keyword){
        
        String q = "select * from podcasts where title like :kw or category like :kw "
                + "or author like :kw order by created_at desc";
        
        Map<String, Object> params = new HashMap<>();
        
        params.put("kw","%" + keyword + "%");
        
         try {
            return jdbcTemplate.query(q, params, (rs, rowNum) -> {
                Podcast p = new Podcast();
                p.setId(rs.getInt("id"));
                p.setTitle(rs.getString("title"));
                p.setAuthor(rs.getString("author"));
                p.setCategory(rs.getString("category"));
                p.setDescription(rs.getString("description"));
                p.setCoverImageUrl(rs.getString("cover_image_url"));
                p.setFeedUrl(rs.getString("feed_url"));
                p.setAudioUrl(rs.getString("audio_url"));
                p.setUserId(rs.getInt("user_id"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                return p;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
        
    }

    // GET BY CATEGORY — exact match
public List<Podcast> getByCategory(String category) {
    String q = "SELECT * FROM podcasts WHERE category = :category ORDER BY created_at DESC";
    Map<String, Object> params = new HashMap<>();
    params.put("category", category);
    try {
        return jdbcTemplate.query(q, params, (rs, rowNum) -> {
            Podcast p = new Podcast();
            p.setId(rs.getInt("id"));
            p.setTitle(rs.getString("title"));
            p.setAuthor(rs.getString("author"));
            p.setCategory(rs.getString("category"));
            p.setDescription(rs.getString("description"));
            p.setCoverImageUrl(rs.getString("cover_image_url"));
            p.setFeedUrl(rs.getString("feed_url"));
            p.setAudioUrl(rs.getString("audio_url"));
            p.setUserId(rs.getInt("user_id"));
            p.setCreatedAt(rs.getTimestamp("created_at"));
            return p;
        });
    } catch (Exception e) {
        e.printStackTrace();
        return new ArrayList<>();
    }
}
}
