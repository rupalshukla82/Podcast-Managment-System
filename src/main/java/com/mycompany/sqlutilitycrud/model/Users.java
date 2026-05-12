/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sqlutilitycrud.model;

/**
 *
 * @author abhi
 */
public class Users {

    private int ID;
    private String Name;
    private String Email;
    private String Password;

    public Users() {

    }

    public Users(int ID, String Name, String Email, String Password) {
        this.ID = ID;
        this.Name = Name;
        this.Email = Email;
        this.Password = Password;
    }

    public int getID() {
        return ID;
    }

    public String getName() {
        return Name;
    }

    public String getEmail() {
        return Email;
    }

    public String getPassword() {
        return Password;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }
    
    

}
