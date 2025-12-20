package com.example.TimNhaHang.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.TimNhaHang.model.Restaurant;

@Repository
public interface RestaurantRepo extends JpaRepository<Restaurant, Integer> {
    @Query("SELECT r FROM Restaurant r WHERE " +
            "LOWER(r.name) LIKE LOWER(CONCAT('%', :string, '%'))")
    List<Restaurant> getRestaurantByName(String string);
}
