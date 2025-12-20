package com.example.TimNhaHang.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.TimNhaHang.dto.comments.CommentGetDTO;
import com.example.TimNhaHang.dto.comments.CommentPostDTO;
import com.example.TimNhaHang.model.Comment;
import com.example.TimNhaHang.model.Restaurant;
import com.example.TimNhaHang.repositories.CommentRepo;
import com.example.TimNhaHang.repositories.RestaurantRepo;

@Service
public class CommentService {

    @Autowired
    CommentRepo commentRepo;

    @Autowired
    RestaurantRepo restaurantRepo;

    public List<CommentGetDTO> getAllByRestaurantId(int id) {
        List<Comment> comments = commentRepo.findAllByRestaurantIdWithRestaurant(id);
        List<CommentGetDTO> response = new ArrayList<>();

        for (Comment comment : comments) {
            response.add(new CommentGetDTO(comment));
        }

        return response;
    }

    public CommentGetDTO addComment(CommentPostDTO dto) {
        Restaurant restaurant = restaurantRepo.findById(dto.getRestaurantId()).get();

        Comment newComment = new Comment();

        newComment.setRestaurant(restaurant);
        newComment.setUid(dto.getUid());
        newComment.setUserName(dto.getUserName());
        newComment.setUserImage(dto.getUserImage());
        newComment.setContent(dto.getContent());
        newComment.setImageUrl(dto.getImageUrl());
        newComment.setRating(dto.getRating());
        newComment.setCreatedAt(dto.getCreatedAt());

        Comment savedComment = commentRepo.save(newComment);

        return new CommentGetDTO(savedComment);
    }
}
