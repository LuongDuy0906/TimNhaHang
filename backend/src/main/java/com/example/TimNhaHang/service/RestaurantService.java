package com.example.TimNhaHang.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.TimNhaHang.dto.restaurants.RestaurantGetDTO;
import com.example.TimNhaHang.model.Restaurant;
import com.example.TimNhaHang.repositories.RestaurantRepo;

@Service
public class RestaurantService {

    @Autowired
    RestaurantRepo repo;

    public List<RestaurantGetDTO> getAll() {
        List<Restaurant> restaurants = repo.findAll();
        List<RestaurantGetDTO> response = new ArrayList<>();
        for (Restaurant restaurant : restaurants) {
            response.add(new RestaurantGetDTO(restaurant));
        }
        return response;
    }

    public List<RestaurantGetDTO> getAllByName(String string) {
        List<Restaurant> restaurants = repo.getRestaurantByName(string);
        List<RestaurantGetDTO> search = new ArrayList<>();
        for (Restaurant restaurant : restaurants) {
            search.add(new RestaurantGetDTO(restaurant));
        }
        return search;
    }

    public RestaurantGetDTO getById(int id) {
        Restaurant restaurant = repo.findById(id).get();

        return new RestaurantGetDTO(restaurant);
    }

}
