package model;

public class User {
    private static final String USERNAME ="admin";
    private static final String PASSWORD ="123456";

    public boolean checkLogin(String username, String password){
        return USERNAME.equals(username) && PASSWORD.equals(password);
    }
}
