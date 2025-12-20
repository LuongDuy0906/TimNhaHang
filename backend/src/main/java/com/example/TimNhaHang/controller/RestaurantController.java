package com.example.TimNhaHang.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.TimNhaHang.dto.restaurants.RestaurantGetDTO;
import com.example.TimNhaHang.service.RestaurantService;

@CrossOrigin
@RestController
@RequestMapping("/api")
public class RestaurantController {

    @Autowired
    RestaurantService service;

    @GetMapping("/restaurants")
    public ResponseEntity<List<RestaurantGetDTO>> getAllByName(
            @RequestParam(name = "name", required = false) String string) {
        List<RestaurantGetDTO> restaurants;
        if (string != null && !string.isEmpty()) {
            restaurants = service.getAllByName(string);
        } else {
            restaurants = service.getAll();
        }
        return new ResponseEntity<>(restaurants, HttpStatus.OK);
    }

    @GetMapping("/restaurants/{id}")
    public ResponseEntity<?> getById(@PathVariable int id) {
        RestaurantGetDTO response;
        try {
            response = service.getById(id);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }
}
