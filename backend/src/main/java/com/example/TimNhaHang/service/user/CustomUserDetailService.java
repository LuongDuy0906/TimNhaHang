package com.example.TimNhaHang.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.example.TimNhaHang.repositories.UserRepo;

@Service
public class CustomUserDetailService implements UserDetailsService {

  @Autowired
  UserRepo userRepo;

  @Override
  public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
    return userRepo.findByEmail(email)
        .orElseThrow(() -> new UsernameNotFoundException("Không tìm thấy người dùng với email" + email));
  }
}
