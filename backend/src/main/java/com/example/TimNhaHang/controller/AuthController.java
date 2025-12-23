package com.example.TimNhaHang.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.TimNhaHang.dto.user.RegisterRequest;
import com.example.TimNhaHang.service.user.AuthService;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

  @Autowired
  AuthService authService;

  @PostMapping("/register")
  public ResponseEntity<String> register(@RequestBody RegisterRequest request) {
    return ResponseEntity.ok(authService.register(request));
  }
}
