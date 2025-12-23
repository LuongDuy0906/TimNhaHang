package com.example.TimNhaHang.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.TimNhaHang.model.Comment;

@Repository
public interface CommentRepo extends JpaRepository<Comment, Integer> {

    @EntityGraph(attributePaths = "restaurant")
    Page<Comment> findAllByRestaurantId(int restaurantId, Pageable pageable);
}
