package com.example.TimNhaHang.service;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

import org.apache.coyote.BadRequestException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.TimNhaHang.dto.booking.BookingGetDTO;
import com.example.TimNhaHang.dto.booking.BookingPostDTO;
import com.example.TimNhaHang.model.Booking;
import com.example.TimNhaHang.model.Restaurant;
import com.example.TimNhaHang.repositories.BookingRepo;
import com.example.TimNhaHang.repositories.RestaurantRepo;

@Service
public class BookingService {

    @Autowired
    BookingRepo bookingRepo;

    @Autowired
    RestaurantRepo restaurantRepo;

    public List<BookingGetDTO> getAllByUID(String uid) {
        List<Booking> bookings = bookingRepo.findAllByUid(uid);
        List<BookingGetDTO> response = new ArrayList<>();

        for (Booking booking : bookings) {
            response.add(new BookingGetDTO(booking));
        }

        return response;
    }

    public BookingGetDTO addBooking(BookingPostDTO dto) throws BadRequestException {
        Restaurant restaurant = restaurantRepo.findById(dto.getRestaurantId()).get();

        Booking newBooking = new Booking();

        newBooking.setUid(dto.getUid());
        newBooking.setRestaurant(restaurant);

        try {
            Instant instant = Instant.parse(dto.getBookingTime());
            newBooking.setBookingTime(Timestamp.from(instant));
        } catch (DateTimeParseException e) {
            throw new BadRequestException("Sai định dạng ngày tháng");
        }

        newBooking.setCreatedAt(dto.getCreatedAt());

        Booking savedBooking = bookingRepo.save(newBooking);
        return new BookingGetDTO(savedBooking);
    }
}
