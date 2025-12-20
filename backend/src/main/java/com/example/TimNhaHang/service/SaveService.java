package com.example.TimNhaHang.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.TimNhaHang.dto.saves.SaveGetDTO;
import com.example.TimNhaHang.model.Save;
import com.example.TimNhaHang.repositories.SaveRepo;

@Service
public class SaveService {

    @Autowired
    SaveRepo saveRepo;

    public List<SaveGetDTO> getAllByUid(String uid) {
        List<Save> saves = saveRepo.findAllByUid(uid);

        List<SaveGetDTO> response = new ArrayList<>();
        for (Save save : saves) {
            response.add(new SaveGetDTO(save));
        }

        return response;
    }
}
