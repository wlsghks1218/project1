package org.hype.mapper;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import org.hype.domain.popStoreVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class PopUpMapperTest {
    
    @Autowired
    PopUpMapper mapper;
    
//    @Test
//    public void testGetUserInterests() {
//        int userno = 5; // 테스트할 사용자 번호
//        List<String> interests = mapper.getUserInterests(userno);
//        assertNotNull(interests); // 관심사 리스트가 null이 아닌지 확인
//        assertFalse(interests.isEmpty()); // 관심사 리스트가 비어있지 않은지 확인
//
//        // 추가로 관심사 개수 검증 (예: 기대되는 최소 관심사 수)
//        assertTrue(interests.size() > 0);
//        
//        // 관심사 출력
//        for (String interest : interests) {
//            log.warn("Interest: " + interest); // 관심사 출력
//        }
//    }
//
//    @Test
//    public void testGetTopStoresByInterests() {
//        List<String> interests = mapper.getUserInterests(5); // 사용자 관심사 조회
//        List<popStoreVO> results = new ArrayList<>(); // 결과를 저장할 리스트
//
//        if (interests != null && !interests.isEmpty()) {
//            for (String interest : interests) {
//                // 각 관심사에 대해 쿼리를 호출하여 상위 8개 스토어를 가져옵니다.
//                List<popStoreVO> topStores = mapper.getTopStoresByInterest(interest);
//                
//                assertNotNull(topStores); // 결과 리스트가 null이 아닌지 확인
//                assertFalse(topStores.isEmpty()); // 결과 리스트가 비어있지 않은지 확인
//
//                log.warn("Top stores for interest: " + interest); // 현재 관심사 출력
//                for (popStoreVO store : topStores) {
//                    log.warn(store.toString()); // 결과 출력
//                }
//
//                // 관심사와 상위 스토어 목록을 포함한 popStoreVO 객체를 생성
//                for (popStoreVO store : topStores) {
//                    store.setInterest(interest); // 관심사 설정
//                    store.setTopStores(topStores); // 상위 스토어 리스트 설정
//                    results.add(store); // 결과 리스트에 추가
//                }
//            }
//        }
//
//        // 이제 results 리스트에는 각 관심사별로 결과가 저장되어 있습니다.
//        for (popStoreVO store : results) {
//            log.info(store.toString()); // 각 관심사별 결과 출력
//        }
//    }
    @Test
    public void getStoreInfoByName() {
    	popStoreVO vo = mapper.getStoreInfoByName("나루토 더 갤러리 in 서울");
    	
    	log.info(vo);
    }
}
