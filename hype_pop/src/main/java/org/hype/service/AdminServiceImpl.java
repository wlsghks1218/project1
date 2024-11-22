package org.hype.service;

import java.util.Date; 
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import org.hype.domain.Criteria;
import org.hype.domain.exhImgVO;
import org.hype.domain.exhVO;
import org.hype.domain.gCatVO;
import org.hype.domain.gImgVO;
import org.hype.domain.goodsVO;
import org.hype.domain.pCatVO;
import org.hype.domain.pImgVO;
import org.hype.domain.payVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.qnaVO;
import org.hype.domain.signInVO;
import org.hype.mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class AdminServiceImpl implements AdminService{
   
   @Autowired
   public AdminMapper mapper;
      
   // 페이징 처리
   // 팝업스토어 영역
   // 팝업스토어 리스트 가져오기
   @Override
   public List<popStoreVO> getPList(Criteria cri, String searchPs) {
      return mapper.getPList(cri, searchPs);
   }
   
   @Override
   public int getPTotal(String searchPs) {
      return mapper.getPTotal(searchPs);
   }   

   // 굿즈(상품) 영역
   // 굿즈(상품) 리스트 가져오기
   @Override
   public List<goodsVO> getGList(Criteria cri, String searchGs) {
      return mapper.getGList(cri, searchGs);
   }

   @Override
   public int getGTotal(String searchGs) {
      return mapper.getGTotal(searchGs);
   }   
   
   // 전시회 영역
   // 전시회 리스트 가져오기   
   @Override
   public List<exhVO> getExhList(Criteria cri, String searchEs) {
      return mapper.getExhList(cri, searchEs);
   }

   @Override
   public int getExhTotal(String searchEs) {
      return mapper.getExhTotal(searchEs);
   }

   // 회원 영역
   // 회원 리스트 가져오기 
   @Override
   public List<signInVO> getMList(Criteria cri, String searchMs) {
      return mapper.getMList(cri, searchMs);
   }
   
   @Override
   public int getMTotal(String searchMs) {
      return mapper.getMTotal(searchMs);
   }
   
   // 특정 팝업스토어 조회
   @Override
   public popStoreVO getPopStoreById(int psNo) {
      return mapper.getPopStoreById(psNo);
   }
   
   // 특정 굿즈(상품) 조회
   @Override
   public goodsVO getGoodsById(int gno) {
      return mapper.getGoodsById(gno);
   }   
//   @Override
//   public goodsVO getGoodsById(int gNo) {
//      return mapper.getGoodsById(gNo);
//   }   
   
   // 특정 전시회 조회
   @Override
   public exhVO getExhById(int exhNo) {
      return mapper.getExhById(exhNo);
   }
   
   // 특정 회원 조회
   @Override
   public signInVO getMembersById(String userId) {
      return mapper.getMembersById(userId);
   }
   
   // 팝업스토어 등록 페이지 영역
   // 팝업스토어 정보 등록
   @Transactional
   @Override
   public int insertPopStore(popStoreVO pvo) {
      
      int result1 = mapper.insertPopStore(pvo);
      pvo.getPsImg().setPsNo(pvo.getPsNo()); // 시퀀스를 xml에서 처리한 거를 갖고온 것
      log.warn(pvo.getPsNo());
      int result2 = mapper.insertPsImage(pvo.getPsImg());    // vo 가져오기
      
      pvo.getPsCat().setPsNo(pvo.getPsNo()); // 시퀀스를 xml에서 처리한 거를 갖고온 것
      
      int result3 = mapper.insertPsCat(pvo.getPsCat());    // vo 가져오기

      log.warn("result1의 값은 " + result1);
      log.warn("result2의 값은 " + result2);

      return result1;      
   }
   
   // 팝업스토어 수정 페이지 영역
   // 팝업스토어 정보 수정
   // 이미지 받아오기
   @Override
   public pImgVO getPsImg(int psNo) {
      return mapper.getPsImg(psNo);
   }
   
   // 카테고리 값 받아오기
   @Override
   public pCatVO getPsCat(int psNo) {
      return mapper.getPsCat(psNo);
   }

   // 팝업스토어 정보 수정
   @Override
   public int updatePopStore(popStoreVO pvo) {
      log.info("팝업스토어 수정..." + pvo);
      
      // 1. 기본 팝업스토어 정보 업데이트
      int result1 = mapper.updatePopStore(pvo);
      log.warn("기본 정보 업데이트 결과: " + result1);
      
      // 2. 이미지 정보 업데이트
       if (pvo.getPsImg() != null) {
           pvo.getPsImg().setPsNo(pvo.getPsNo());
           int result2 = mapper.updatePsImage(pvo.getPsImg());
           log.warn("이미지 정보 업데이트 결과: " + result2);
       } else {
           log.warn("pvo.getPsImg()가 null입니다. 이미지 정보 업데이트를 건너뜁니다.");
       }
             
      // 3. 카테고리 정보 업데이트
       pvo.getPsCat().setPsNo(pvo.getPsNo());
       int result3 = mapper.updatePsCat(pvo.getPsCat());
       log.warn("카테고리 정보 업데이트 결과: " + result3);
       
      return result1;      
   }

   // 팝업스토어 삭제 페이지 영역
   // 팝업스토어 정보 삭제   
   @Override
   @Transactional
   public int deletePopStore(int psNo) {
      List<goodsVO> gvo = mapper.getPsnoList(psNo);
      for(goodsVO vo : gvo) {
         int gno = vo.getGno();
         int result2 = mapper.deleteGCart(gno);
         result2 += mapper.deleteGPay(gno);
         result2 += mapper.deleteGLike(gno);
         result2 += mapper.deleteGReply(gno);
         result2 += mapper.deleteGCat(gno);
         result2 += mapper.deleteGImgBanner(gno);
         result2 += mapper.deleteGImgDetail(gno);
         result2 += mapper.deleteGoodsStore(gno);
      }
      int result = mapper.deletePsCat(psNo);
        result += mapper.deletePsImage(psNo);
        result += mapper.deletePsReply(psNo);
        result += mapper.deletePsLike(psNo);
        result += mapper.deletePopStore(psNo);

        return result;
   }   
   
   // 상품(굿즈) 등록 페이지 영역
   // 상품(굿즈) 정보 등록   
   @Override
   public List<popStoreVO> getAllPopStores() {
      return mapper.getAllPopStores();
   }

   @Transactional
   @Override
   public int insertGoodsStore(goodsVO gvo) {
       // 1. 상품 등록
      log.warn("파일이름 가져오기 " + gvo.getAttachList().get(0).getFileName());
      log.warn(gvo.getAttachList().get(1).getFileName());
       int result1 = mapper.insertGoodsStore(gvo);
       log.warn("상품 등록 결과: " + result1);   

       if (result1 > 0) {

          for (gImgVO img : gvo.getAttachList()) {
             log.warn("gno는 ? : " + gvo.getGno());
               img.setGno(gvo.getGno()); // gno를 각 이미지에 설정
               // 배너 이미지 등록
               if (img.getUploadPath().contains("굿즈 배너 사진")) {
                   int result2 = mapper.insertBannerImage(img);
                   log.warn("배너 이미지 등록 결과: " + result2);
               }
               // 상세 이미지 등록
               else if (img.getUploadPath().contains("굿즈 상세 사진")) {
                   int result3 = mapper.insertDetailImage(img);
                   log.warn("상세 이미지 등록 결과: " + result3);
               }
           }
       } else {
           throw new RuntimeException("상품 등록 실패");
       }
       
       gvo.getGcat().setGno(gvo.getGno()); // 시퀀스를 xml에서 처리한 거를 갖고온 것
       
       int result4 = mapper.insertGcat(gvo.getGcat());       

       return result1;
   }
   
   // 상품(굿즈) 수정 페이지 영역
   // 상품(굿즈) 정보 수정   
   @Override
   public gImgVO getGImgBanner(int gno) {
      return mapper.getGImgBanner(gno);
   }
   
   @Override
   public gImgVO getGImgDetail(int gno) {
      return mapper.getGImgDetail(gno);
   }
   
   @Override
   public gCatVO getGCat(int gno) {
      return mapper.getGCat(gno);
   }
   
   @Transactional
   @Override
   public int updateGoodsStore(goodsVO gvo) {

       // 1. 기본 상품 정보 업데이트
       int result = mapper.updateGoodsStore(gvo);

       // 2. 카테고리 정보 업데이트
       if (gvo.getGcat() != null) {
           gvo.getGcat().setGno(gvo.getGno());  // 상품 번호 설정
           result += mapper.updateGCat(gvo.getGcat());
       }

       // 3. 이미지 리스트가 존재할 경우 배너와 상세 이미지 구분하여 업데이트 수행
       if (gvo.getAttachList() != null && !gvo.getAttachList().isEmpty()) {
           for (gImgVO img : gvo.getAttachList()) {
               img.setGno(gvo.getGno());  // 상품 번호 설정
               if (img.getUploadPath().contains("굿즈 배너 사진")) {
                   result += mapper.updateGImgBanner(img);  // 배너 이미지 업데이트
               } else if (img.getUploadPath().contains("굿즈 상세 사진")) {
                   result += mapper.updateGImgDetail(img);  // 상세 이미지 업데이트
               }
           }
       }

       return result;
   }
   
   // 상품(굿즈) 삭제 페이지 영역
   // 상품(굿즈) 정보 삭제
   @Transactional
   @Override
   public int deleteGoodsStore(int gno) {
             
      int result = mapper.deleteGCart(gno);
      
      result += mapper.deleteGPay(gno);
      
      result += mapper.deleteGLike(gno);
      
      result += mapper.deleteGReply(gno);
      
      result += mapper.deleteGCat(gno);
      
        result += mapper.deleteGImgBanner(gno);

        result += mapper.deleteGImgDetail(gno);

        result += mapper.deleteGoodsStore(gno);        

        return result; 
   }

   // 전시회 등록 페이지 영역
   // 전시회 정보 등록   
   @Transactional
   @Override
   public int insertExhibition(exhVO evo) {
       // 1. 상품 등록
      log.warn("파일이름 가져오기 " + evo.getAttachExhList().get(0).getFileName());
      log.warn(evo.getAttachExhList().get(1).getFileName());
       int result1 = mapper.insertExhibition(evo);
       log.warn("전시회 등록 결과: " + result1);

       if (result1 > 0) {

          for (exhImgVO exhImg : evo.getAttachExhList()) {
             exhImg.setExhNo(evo.getExhNo()); // exhNo를 각 이미지에 설정
             log.warn("전시회 번호 : " + evo.getExhNo());
               // 배너 이미지 등록
               if (exhImg.getUploadPath().contains("전시회 배너 사진")) {
                   int result2 = mapper.insertExhBannerImage(exhImg);
                   log.warn("배너 이미지 등록 결과: " + result2);
               }
               // 상세 이미지 등록
               else if (exhImg.getUploadPath().contains("전시회 상세 사진")) {
                   int result3 = mapper.insertExhDetailImage(exhImg);
                   log.warn("상세 이미지 등록 결과: " + result3);
               }
           }
       } else {
           throw new RuntimeException("전시회 등록 실패");
       }

       return result1;
   }

   // 전시회 수정 페이지 영역
   // 전시회 정보 수정
   @Override
   public exhImgVO getExhImgBanner(int exhNo) {
      return mapper.getExhImgBanner(exhNo);
   }
   
   @Override
   public exhImgVO getExhImgDetail(int exhNo) {
      return mapper.getExhImgDetail(exhNo);
   }
   
   @Override
   public int updateExhibition(exhVO evo) {
      // 1. 기본 상품 정보 업데이트
       int result = mapper.updateExhibition(evo);

       // 2. 이미지 리스트가 존재할 경우 배너와 상세 이미지 구분하여 업데이트 수행
       if (evo.getAttachExhList() != null && !evo.getAttachExhList().isEmpty()) {
           for (exhImgVO img : evo.getAttachExhList()) {
               img.setExhNo(evo.getExhNo());  // 전시회 번호 설정
               if (img.getUploadPath().contains("전시회 배너 사진")) {
                   result += mapper.updateExhBannerImage(img);  // 배너 이미지 업데이트
               } else if (img.getUploadPath().contains("전시회 상세 사진")) {
                   result += mapper.updateExhDetailImage(img);  // 상세 이미지 업데이트
               }
           }
       }

       return result;
   }

   // 전시회 삭제 페이지 영역
   // 전시회 정보 삭제
   @Transactional
   @Override
   public int deleteExhibition(int exhNo) {
      
      int result = mapper.deleteExhImgBanner(exhNo);
      
        result += mapper.deleteExhImgDetail(exhNo);
        
        result += mapper.deleteExhLike(exhNo);
        
        result += mapper.deleteExhReply(exhNo);

        result += mapper.deleteExhibition(exhNo);

        return result;         
   }
      
   // 문의 리스트 확인 페이지 영역
   // 문의 리스트 가져오기
   @Override
    public List<qnaVO> getQnaListByType(String qnaType, String qnaAnswer) {        
        return mapper.getQnaListByType(qnaType, qnaAnswer);
    }

    // 회원 정보 수정 페이지 영역
   // 회원 정보 업데이트   
   @Override
   public int updateMem(signInVO svo) {
      return mapper.updateMem(svo);
   }   
      
      
}