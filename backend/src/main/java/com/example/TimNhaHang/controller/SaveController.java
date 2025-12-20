package com.example.TimNhaHang.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.TimNhaHang.dto.saves.SaveGetDTO;
import com.example.TimNhaHang.service.SaveService;

@RestController
@CrossOrigin
@RequestMapping("/api")
public class SaveController {

    @Autowired
    SaveService saveService;

    @GetMapping("/saves/{uid}")
    public ResponseEntity<?> getAll(@PathVariable String uid) {
        List<SaveGetDTO> response;
        try {
            response = saveService.getAllByUid(uid);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }
}
