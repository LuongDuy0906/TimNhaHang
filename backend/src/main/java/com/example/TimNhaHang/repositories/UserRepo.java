package com.example.TimNhaHang.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.TimNhaHang.model.User;

public interface UserRepo extends JpaRepository<User, Integer> {
  Optional<User> findByEmail(String email);
}
