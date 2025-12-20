package com.example.TimNhaHang.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.TimNhaHang.dto.booking.BookingGetDTO;
import com.example.TimNhaHang.dto.booking.BookingPostDTO;
import com.example.TimNhaHang.service.BookingService;

@RestController
@CrossOrigin
@RequestMapping("/api")
public class BookingController {

    @Autowired
    BookingService bookingService;

    @GetMapping("/booking/{uid}")
    public ResponseEntity<?> getAllByUID(@PathVariable String uid) {
        List<BookingGetDTO> response;

        try {
            response = bookingService.getAllByUID(uid);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/booking")
    public ResponseEntity<?> add(@RequestBody BookingPostDTO dto) {
        BookingGetDTO response;
        try {
            response = bookingService.addBooking(dto);
            return new ResponseEntity<>(response, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }
}
