package com.example.TimNhaHang.dto.restaurants;

import com.example.TimNhaHang.model.Restaurant;

public class RestaurantGetDTO {
    private int id;
    private String name;
    private String address;
    private String category;
    private String priceRange;
    private String closing;
    private String opening;
    private String imageUrl;
    private double rating;

    public RestaurantGetDTO(Restaurant restaurant) {
        this.id = restaurant.getId();
        this.name = restaurant.getName();
        this.address = restaurant.getAddress();
        this.category = restaurant.getCategory();
        this.category = restaurant.getCategory();
        this.closing = restaurant.getClosing();
        this.opening = restaurant.getOpening();
        this.imageUrl = restaurant.getImageUrl();
        this.rating = restaurant.getRating();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getPriceRange() {
        return priceRange;
    }

    public void setPriceRange(String priceRange) {
        this.priceRange = priceRange;
    }

    public String getClosing() {
        return closing;
    }

    public void setClosing(String closing) {
        this.closing = closing;
    }

    public String getOpening() {
        return opening;
    }

    public void setOpening(String opening) {
        this.opening = opening;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

}
