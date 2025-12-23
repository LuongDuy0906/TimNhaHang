package com.example.TimNhaHang.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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

    public Page<CommentGetDTO> getAllByRestaurantId(int id, int size, int page) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());

        Page<Comment> comments = commentRepo.findAllByRestaurantId(id, pageable);

        return comments.map(comment -> new CommentGetDTO(comment));
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
