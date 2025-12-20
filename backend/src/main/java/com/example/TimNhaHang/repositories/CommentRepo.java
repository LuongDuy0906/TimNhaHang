package com.example.TimNhaHang.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.TimNhaHang.model.Comment;

@Repository
public interface CommentRepo extends JpaRepository<Comment, Integer> {

    @Query("SELECT c FROM Comment c JOIN FETCH c.restaurant WHERE c.restaurant.id = :restaurantId")
    List<Comment> findAllByRestaurantIdWithRestaurant(@Param("restaurantId") int restaurantId);
}
