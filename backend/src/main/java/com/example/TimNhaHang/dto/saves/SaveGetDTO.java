package com.example.TimNhaHang.dto.saves;

import com.example.TimNhaHang.dto.restaurants.RestaurantGetDTO;
import com.example.TimNhaHang.model.Save;

public class SaveGetDTO {
    private RestaurantGetDTO restaurant;
    private String uid;
    private String createdAt;

    public SaveGetDTO(Save save) {
        if (save.getRestaurant() != null) {
            this.restaurant = new RestaurantGetDTO(save.getRestaurant());
        }
        this.uid = save.getUid();
        this.createdAt = save.getCreatedAt().toInstant().toString();
    }

    public RestaurantGetDTO getRestaurant() {
        return restaurant;
    }

    public void setRestaurant(RestaurantGetDTO restaurant) {
        this.restaurant = restaurant;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

}
