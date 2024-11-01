package org.hype.controller;

import java.util.List;

import org.hype.domain.popStoreVO;
import org.hype.service.PopUpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/map")
public class popUpMapController {
    
    @Autowired
    private PopUpService service; // 스토어 서비스 주입

    @GetMapping(value = "/nearby" , produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<popStoreVO>> getNearbyStores(
            @RequestParam double latitude,
            @RequestParam double longitude) { // radius는 더 이상 필요하지 않음

        // 임의로 5km(5000m) 설정
        double radius = 5000; 
        
        log.info("Nearby stores request received: lat=" + latitude + ", lng=" + longitude + ", radius=" + radius);
        
        // 서비스 메서드 호출
        List<popStoreVO> nearbyStores = service.findNearbyStores(latitude, longitude, radius);
        log.info("Nearby stores found: " + nearbyStores.size());
        
        // 결과 확인 및 응답
        if (nearbyStores.isEmpty()) {
            log.info("No nearby stores found within radius: " + radius);
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null); // 204 No Content
        }
        
        return ResponseEntity.ok(nearbyStores); // 200 OK 응답
    }
}
