package com.example.TimNhaHang.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.TimNhaHang.model.Booking;

@Repository
public interface BookingRepo extends JpaRepository<Booking, Integer> {
    List<Booking> findAllByUid(String uid);
}
