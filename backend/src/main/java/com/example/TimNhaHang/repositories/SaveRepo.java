package com.example.TimNhaHang.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.TimNhaHang.model.Save;

@Repository
public interface SaveRepo extends JpaRepository<Save, Integer> {
    public List<Save> findAllByUid(String uid);
}
