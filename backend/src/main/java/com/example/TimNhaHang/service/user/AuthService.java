package com.example.TimNhaHang.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.TimNhaHang.dto.user.RegisterRequest;
import com.example.TimNhaHang.model.User;
import com.example.TimNhaHang.repositories.UserRepo;

@Service
public class AuthService {

  @Autowired
  UserRepo userRepo;

  @Autowired
  PasswordEncoder passwordEncoder;

  public String register(RegisterRequest request) {
    if (userRepo.findByEmail(request.getEmail()).isPresent()) {
      return "Email đã tồn tại";
    }

    User user = new User();
    user.setEmail(request.getEmail());
    user.setPassword(passwordEncoder.encode(request.getPassword()));
    user.setRole("ROLE_USER");

    userRepo.save(user);
    return "Đăng ký tài khoản thành công";
  }
}
