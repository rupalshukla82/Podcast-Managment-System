/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sqlutilitycrud.dao;

import com.mycompany.sqlutilitycrud.model.Users;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

/**
 *
 * @author abhi
 */
@Repository
public class UserDao {
    
    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;
    
    public void saveUser(Users u){
        //save user in db
        try{
            
            String q = "insert into users(Name,Email,Password) values(:name,:email,:password)";
            
            Map<String,Object> params = new HashMap<>();
            System.out.println("Insert Statment");
     
            params.put("name",u.getName());
            params.put("email",u.getEmail());
            params.put("password", u.getPassword());
           
            jdbcTemplate.update(q, params);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    
    //check at the time of login user data is availble in db or not 
    
    public Users loginUser(String email,String password){
        
              String q = "select * from users where Email=:email and Password=:password";
               
               Map<String,Object> params = new HashMap<>();
               
               System.out.println("Select Statment");
              
               params.put("email", email);
               params.put("password" ,password);
               
           try{
               
             return jdbcTemplate.queryForObject(q, params, (rs, rowNum)->{
                 Users u = new Users();
                 u.setID(rs.getInt("ID"));
                 u.setName(rs.getString("Name"));
                 u.setEmail(rs.getString("Email"));
                 u.setPassword(rs.getString("Password"));
                 
                 return u;
             });
               
               
           }
           catch(Exception e){
               e.printStackTrace();
               return null;
           }
           
          
    }
    
}
