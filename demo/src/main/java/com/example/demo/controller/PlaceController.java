package com.example.demo.controller;

import com.example.demo.entity.Place;
import com.example.demo.service.PlaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class PlaceController {
    @Autowired
    private PlaceService placeService;

    @GetMapping("/places")
    public List<Place> getAllPlaces() {
        return placeService.getAllPlaces();
    }
}
