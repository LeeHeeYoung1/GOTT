package com.kedu.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kedu.dao.BannerDAO;
import com.kedu.dto.BannerDTO;

@Service
public class BannerService {
	
	@Autowired
    private BannerDAO bannerDAO;

    // 배너 목록 조회
    public List<BannerDTO> getBannerList() {
        return bannerDAO.getBannerList();
    }

}
