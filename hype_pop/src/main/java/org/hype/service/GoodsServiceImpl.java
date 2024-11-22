package org.hype.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hype.domain.gCatVO;
import org.hype.domain.gImgVO;
import org.hype.domain.goodsVO;
import org.hype.domain.mCatVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.rankVO;
import org.hype.mapper.GoodsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class GoodsServiceImpl implements GoodsService{
	
	@Autowired
	public GoodsMapper mapper;

	@Override
	public List<goodsVO> getGList() {
		return mapper.getGList();
	}

	@Override
	public List<goodsVO> getListBySearchGs(String searchGs) {
		return mapper.getListBySearchGs(searchGs);
	}

	@Override
	public goodsVO getGoodsById(int gNo) {
		return mapper.getGoodsById(gNo);
	}	
	@Override
	public List<goodsVO> getListByLikeCount() {
		return mapper.getListByLikeCount();
	}

	@Override
	public Map<String, Object> getListByInterestOneNotLogin() {
	    List<rankVO> rVo = mapper.getCategoryRankNotLogin();
	    String category = rVo.get(0).getCategory();
	    Map<String, String> params = new HashMap<>();
	    params.put("key", category);
	    
	    List<goodsVO> vo = mapper.getListByInterest(params);

	    Map<String, Object> result = new HashMap<>();
	    result.put("category", category);
	    result.put("goodsList", vo);
	    
	    return result;
	}
	
	@Override
	public Map<String, Object> getListByInterestTwoNotLogin() {
		List<rankVO> rVo = mapper.getCategoryRankNotLogin();
		
	    String category = rVo.get(1).getCategory();
	    Map<String, String> params = new HashMap<>();
	    params.put("key", category);
	    
        List<goodsVO> vo = mapper.getListByInterest(params);
        
	    Map<String, Object> result = new HashMap<>();
	    result.put("category", category);
	    result.put("goodsList", vo);
        
		return result;
	}

	@Override
	public Map<String, Object> getListByInterestThreeNotLogin() {
		List<rankVO> rVo = mapper.getCategoryRankNotLogin();
		
	    String category = rVo.get(2).getCategory();
	    Map<String, String> params = new HashMap<>();
	    params.put("key", category);
	    
        List<goodsVO> vo = mapper.getListByInterest(params);
        
	    Map<String, Object> result = new HashMap<>();
	    result.put("category", category);
	    result.put("goodsList", vo);
	    
		return result;
	}

	@Override
	public List<goodsVO> getListByInterestOneLogined(String category) {
	    Map<String, String> params = new HashMap<>();
	    params.put("key", category);
	    List<goodsVO> vo = mapper.getListByInterest(params);
		return vo;
	}

	@Override
	public List<goodsVO> getListByInterestTwoLogined(String category) {
	    Map<String, String> params = new HashMap<>();
	    params.put("key", category);
	    List<goodsVO> vo = mapper.getListByInterest(params);
		return vo;
	}

	@Override
	public List<goodsVO> getListByInterestThreeLogined(String category) {
	    Map<String, String> params = new HashMap<>();
	    params.put("key", category);
	    List<goodsVO> vo = mapper.getListByInterest(params);
		return vo;
	}

	@Override
	public goodsVO getOneByGno(int gno) {
		return mapper.getOneByGno(gno);
	}
	
	@Override
	public List<goodsVO> getAllSearchList(String searchText){
		return mapper.getAllSearchList(searchText);
	};
	@Override
	public List<goodsVO> getAllGoodsList(){
		return mapper.getAllGoodsList();
	};
	
    @Override
    public gCatVO getCategory(int gno) {
        return mapper.getCategory(gno);
    }
    @Override
	public int getUpdatehit(goodsVO vo) {
		return mapper.getUpdatehit(vo);
	}
    
    @Override
    public int updateLike(int userNo, int gno) {
    	int countLike = mapper.getLike(userNo, gno);
    	if (countLike == 0) {
    		mapper.insertLike(userNo, gno);
    		mapper.updateLikeCountPlus(gno);
    		return 0; 
    	}else {
    		mapper.deleteLike(userNo, gno);
    		mapper.updatetLikeCountMinus(gno);
    		return 1;
    	}
    }
    
    @Override
    public int getLikeCount(int gno) {
    	return mapper.getLikeCount(gno);
    }
    
    @Override
    public int getLikeChk(int userNo, int gno) {
    	return mapper.getLike(userNo, gno);
    }
    
    @Override
    public List<String> getUserInfo(int userNo) {
        mCatVO vo = mapper.getUserInfo(userNo);
        List<String> selectedCategories = new ArrayList<>();

        // 각 필드가 1인 경우, 리스트에 해당 카테고리를 추가
        if (vo.getHealthBeauty() == 1) {
            selectedCategories.add("healthBeauty");
        }
        if (vo.getGame() == 1) {
            selectedCategories.add("game");
        }
        if (vo.getCulture() == 1) {
            selectedCategories.add("culture");
        }
        if (vo.getShopping() == 1) {
            selectedCategories.add("shopping");
        }
        if (vo.getSupply() == 1) {
            selectedCategories.add("supply");
        }
        if (vo.getKids() == 1) {
            selectedCategories.add("kids");
        }
        if (vo.getDesign() == 1) {
            selectedCategories.add("design");
        }
        if (vo.getFoods() == 1) {
            selectedCategories.add("foods");
        }
        if (vo.getInterior() == 1) {
            selectedCategories.add("interior");
        }
        if (vo.getPolicy() == 1) {
            selectedCategories.add("policy");
        }
        if (vo.getCharacter() == 1) {
            selectedCategories.add("character");
        }
        if (vo.getExperience() == 1) {
            selectedCategories.add("experience");
        }
        if (vo.getCollaboration() == 1) {
            selectedCategories.add("collaboration");
        }
        if (vo.getEntertainment() == 1) {
            selectedCategories.add("entertainment");
        }

        return selectedCategories;
    }
	@Override
	public gImgVO getImgByGno(int gno) {
		return mapper.getImgByGno(gno);
	}
	
	@Override
	public gImgVO getGoodsDetailImg(int gno) {
		return mapper.getGoodsDetailImg(gno);
	}
	
	@Override
	public List<popStoreVO> getAllStore() {
		return mapper.getAllStore();
	}
	
	@Override
	public String goodsToPopup(int gno) {
		goodsVO gvo = mapper.getPsnoByGno(gno);
		int psno = gvo.getPsno();
		log.warn("gvo.getPsno = " + gvo.getPsno());
		popStoreVO pvo = mapper.getStoreName(psno);
		log.warn("popStore name = " + pvo.getPsName());
		String psName = pvo.getPsName();
		log.warn(psName);
		return psName;
	}
}