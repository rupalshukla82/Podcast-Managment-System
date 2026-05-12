/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sqlutilitycrud.controller;

import com.mycompany.sqlutilitycrud.dao.UserDao;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.mycompany.sqlutilitycrud.model.Users;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author abhi
 */
@Controller
public class UserAuthController {

    @Autowired
    UserDao dao;

    //show landing page 
    @RequestMapping(value = "/landing.fin", method = RequestMethod.GET)
    public String showLanding() {
        return "landing";
    }

    //show singup
    @RequestMapping("/index.fin")
    public String showSignup() {
        return "index";
    }

    //show login
    @RequestMapping("/login.fin")
    public String showLogin() {
        return "login";
    }

    //save signup data
    @RequestMapping(value = "/register.fin", method = RequestMethod.POST)
    public String Regiter(HttpServletRequest request) {
        Users u = new Users();
        u.setName(request.getParameter("name"));
        u.setEmail(request.getParameter("email"));
        u.setPassword(request.getParameter("password"));

        dao.saveUser(u);

        return "redirect:/login.fin";

    }

//    @RequestMapping(value="/home.fin" , method = RequestMethod.GET)
//    public String showHome(){
//        return "home";
//    }
    @RequestMapping(value = "/home.fin", method = RequestMethod.POST)
    public String login(HttpServletRequest request) {

        Users u = dao.loginUser(
                request.getParameter("email"),
                request.getParameter("password")
        );

        if (u != null) {
            request.getSession().setAttribute("loggedUser", u);
            return "redirect:/home.fin";
        } else {
            return "login";
        }

    }

}
