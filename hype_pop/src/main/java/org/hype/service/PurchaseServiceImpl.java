package org.hype.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.cartVO;
import org.hype.domain.gImgVO;
import org.hype.domain.payVO;
import org.hype.domain.signInVO;
import org.hype.mapper.GoodsMapper;
import org.hype.mapper.PurchaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	private PurchaseMapper pmapper;

	@Override
	public int addToCart(cartVO cvo) {
		log.info("cartVO cvo:" + cvo);
		return pmapper.addToCart(cvo);
	}

	// �옣諛붽뎄�땲 �럹�씠吏��뿉 �젙蹂� 媛��졇�삤湲�
	@Transactional
	@Override
	public List<cartVO> getCartInfo(int userNo) {
		log.info("userNo: " + userNo);

		// 援우쫰 �젙蹂� 媛��졇�삤湲�
		List<cartVO> cartInfoList = pmapper.getCartInfo(userNo);

		// �옣諛붽뎄�땲 �젙蹂� 異쒕젰 諛� �씠誘몄� �꽕�젙
		for (cartVO cartInfo : cartInfoList) {
			System.out.println(cartInfo);

			// 媛� cartInfo�뿉 ���빐 �씠誘몄�瑜� 媛��졇�삤湲�
			List<gImgVO> imgList = pmapper.getMyCartImg(cartInfo.getGno());

			// 媛��졇�삩 �씠誘몄� 由ъ뒪�듃瑜� cartVO�뿉 �꽕�젙
			cartInfo.setGimg(imgList);
		}

		return cartInfoList; // �옣諛붽뎄�땲 �젙蹂� 由ъ뒪�듃 諛섑솚
	}

	// �옣諛붽뎄�땲�뿉 �씠誘� �엳�뒗 �긽�뭹�씤吏� �솗�씤
	@Override
	public int alreadyInCart(int userNo, int gno) {

		log.info("Adding to cart for userNo: " + userNo + ", gno: " + gno);

		return pmapper.alreadyInCart(userNo, gno);
	}

	@Override
	public int deleteItem(int userNo, int gno) {
		log.info("Adding to cart for userNo: " + userNo + ", gno: " + gno);

		return pmapper.deleteItem(userNo, gno);
	}

	// �궗�슜�옄 寃곗젣 �젙蹂� 媛��졇�삤湲�(�긽�뭹 媛�寃� 媛��졇�삤湲�)
	@Override
	public signInVO getPayInfo(int userNo) {
		System.out.println("userNo: " + userNo);

		// 寃곗젣�옄 �젙蹂� 遺덈윭�삤湲�
		return pmapper.getPayInfo(userNo);

	}

	@Override
	public int getPrice(int userNo) {

		System.out.println("userNo: " + userNo);

		return pmapper.getPrice(userNo);
	}

	@Override
	public int addToPayList(List<payVO> pvoList) {
		System.out.println("payVO: " + pvoList);

		int result = 0;
		for (int i = 0; i < pvoList.size(); i++) {
			result += pmapper.addToPayList(pvoList.get(i));
		}

		return result;
	}

	@Override
	@Scheduled(cron = "0 0 * * * ?")
	public int oneDayGbuyDate() {

		System.out.println("oneDayGsituation..service");

		pmapper.oneDayGsituation();

		return pmapper.threeDayGsituation();

	}

	@Override
	@Scheduled(cron = "0 0 * * * ?")
	public int threeDayGbuyDate() {

		System.out.println("threeDayGsituation..service");

		return pmapper.threeDayGsituation();

	}

	@Override
	public List<payVO> getPayList(int userNo, int offset, int pageSize) {
		return pmapper.getPayList(userNo, offset, pageSize);
	}

	@Override
	public List<gImgVO> getPayListImg(int gno) {

		System.out.println("getPayList..gno : " + gno);

		return pmapper.getPayListImg(gno);
	}

	@Override
	public int updateCartAmount(cartVO cvo) {

		System.out.println("updateCartAmount : " + cvo);

		return pmapper.updateCartAmount(cvo);
	}
	
	// 총 페이지 수 계산
	@Override
    public int getTotalPages(int userNo, int pageSize) {
        int totalItems = pmapper.getTotalItems(userNo);
        return (int) Math.ceil((double) totalItems / pageSize);
    }
    


	@Override
	   public int deleteCartItems(int gno, int userNo) {
     return pmapper.deleteCartItems(gno, userNo);
 }
    
    

}
