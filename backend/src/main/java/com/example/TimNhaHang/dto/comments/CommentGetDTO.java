package com.example.TimNhaHang.dto.comments;

import java.sql.Timestamp;

import com.example.TimNhaHang.dto.restaurants.RestaurantGetDTO;
import com.example.TimNhaHang.model.Comment;

public class CommentGetDTO {
    private int id;
    private RestaurantGetDTO restaurants;
    private String uid;
    private String userName;
    private String userImage;
    private String content;
    private double rating;
    private String imageUrl;
    private Timestamp createdAt;

    public CommentGetDTO(Comment comment) {
        this.id = comment.getId();
        if (comment.getRestaurant() != null) {
            this.restaurants = new RestaurantGetDTO(comment.getRestaurant());
        }
        this.uid = comment.getUid();
        this.userName = comment.getUserName();
        this.userImage = comment.getUserImage();
        this.content = comment.getContent();
        this.rating = comment.getRating();
        this.imageUrl = comment.getImageUrl();
        this.createdAt = comment.getCreatedAt();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public RestaurantGetDTO getRestaurants() {
        return restaurants;
    }

    public void setRestaurants(RestaurantGetDTO restaurants) {
        this.restaurants = restaurants;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserImage() {
        return userImage;
    }

    public void setUserImage(String userImage) {
        this.userImage = userImage;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

}
