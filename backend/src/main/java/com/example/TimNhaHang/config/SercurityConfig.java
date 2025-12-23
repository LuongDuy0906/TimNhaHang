package com.example.TimNhaHang.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SercurityConfig {

  @Bean
  SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    http
        .csrf(csrf -> csrf.disable())
        .authorizeHttpRequests(auth -> auth
            .requestMatchers("/api/auth/register").permitAll()
            .anyRequest().authenticated())
        .formLogin(form -> form
            .loginProcessingUrl("/api/auth/login")
            .usernameParameter("email")
            .passwordParameter("password")

            .successHandler((request, response, authentication) -> {
              response.setStatus(200);
              response.setContentType("application/json");
              response.getWriter().write("{\"message\": \"Login Success\"}");
            })

            .failureHandler((request, response, exception) -> {
              response.setStatus(401);
              response.setContentType("application/json");
              response.getWriter().write("{\"message\": \"Login Failed\"}");
            })
            .permitAll());
    // Dòng này bảo Spring: "Đừng tìm 'username' nữa, hãy tìm key 'email' trên
    // request"

    return http.build();
  }
}
