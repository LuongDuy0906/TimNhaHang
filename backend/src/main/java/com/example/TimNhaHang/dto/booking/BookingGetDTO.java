package com.example.TimNhaHang.dto.booking;

import com.example.TimNhaHang.dto.restaurants.RestaurantGetDTO;
import com.example.TimNhaHang.model.Booking;

public class BookingGetDTO {
    private RestaurantGetDTO restaurantGetDTO;
    private String uid;
    private String bookingTime;
    private String createdAt;

    public BookingGetDTO(Booking booking) {
        if (booking.getRestaurant() != null) {
            this.restaurantGetDTO = new RestaurantGetDTO(booking.getRestaurant());
        }
        this.uid = booking.getUid();
        this.bookingTime = booking.getBookingTime().toInstant().toString();
        this.createdAt = booking.getCreatedAt().toInstant().toString();
    }

    public RestaurantGetDTO getRestaurantGetDTO() {
        return restaurantGetDTO;
    }

    public void setRestaurantGetDTO(RestaurantGetDTO restaurantGetDTO) {
        this.restaurantGetDTO = restaurantGetDTO;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getBookingTime() {
        return bookingTime;
    }

    public void setBookingTime(String bookingTime) {
        this.bookingTime = bookingTime;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

}
