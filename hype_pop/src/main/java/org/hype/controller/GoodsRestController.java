package org.hype.controller;

import java.io.File;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.hype.domain.gCatVO;
import org.hype.domain.gImgVO;
import org.hype.domain.goodsVO;
import org.hype.domain.popStoreVO;
import org.hype.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/goodsStore")
public class GoodsRestController {
	
    @Autowired
    private GoodsService gService;
    
    @GetMapping(value = "/chkLike/{gno}/{userNo}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Integer> chkLike(@PathVariable("gno") int gno, @PathVariable("userNo") int userNo){
    	int result = gService.getLikeChk(userNo, gno);
    	return new ResponseEntity<>(result, HttpStatus.OK);
    }
    
    @GetMapping(value = "/changeLike/{gno}/{userNo}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Integer> changeLike(@PathVariable("gno") int gno, @PathVariable("userNo") int userNo){
    	int result = gService.updateLike(userNo, gno);
    	return new ResponseEntity<>(result, HttpStatus.OK);
    }
    
    @GetMapping(value = "/getLikeCount/{gno}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Integer> getLikeCount(@PathVariable("gno") int gno){
    	int result = gService.getLikeCount(gno);
    	return new ResponseEntity<>(result, HttpStatus.OK);
    }
    
    @PostMapping(value = "/getAllGoodsList", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<goodsVO>> getAllGoodsList(){
    	List<goodsVO> result = gService.getAllGoodsList();
        for (goodsVO vo : result) {
            gCatVO voCat = gService.getCategory(vo.getGno());
            vo.setGcat(voCat);
            List<gImgVO> imgVo = new ArrayList<gImgVO>();
            gImgVO imgVo1 = gService.getImgByGno(vo.getGno());
            imgVo.add(imgVo1);  
        	vo.setAttachList(imgVo);
        }
    	return new ResponseEntity<>(result, HttpStatus.OK);
    }
    
    @GetMapping("/goodsBannerImages/{fileName:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveBannerImage(@PathVariable String fileName) throws MalformedURLException {
        String uploadFolder = "\\\\192.168.0.129\\storeGoodsImg\\굿즈 배너 사진";
        String imagePath = uploadFolder + File.separator + fileName;
        Path path = Paths.get(imagePath);
        
        if (!Files.exists(path)) {
            throw new RuntimeException("파일이 없어여: " + fileName);
        }
        
        if (!Files.isReadable(path)) {
            throw new RuntimeException("파일을 읽을 수 없어요: " + fileName);
        }
        
        Resource file = new FileSystemResource(path.toFile());
        return ResponseEntity.ok()
            .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + fileName + "\"")
            .body(file);
    }
    
    @GetMapping("/goodsDetailImages/{fileName:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveDetailImage(@PathVariable String fileName) throws MalformedURLException {
        String uploadFolder = "\\\\192.168.0.129\\storeGoodsImg\\굿즈 상세 사진";
        String imagePath = uploadFolder + File.separator + fileName;
        Path path = Paths.get(imagePath);
        
        if (!Files.exists(path)) {
            throw new RuntimeException("파일이 없어여: " + fileName);
        }
        
        if (!Files.isReadable(path)) {
            throw new RuntimeException("파일을 읽을 수 없어요: " + fileName);
        }
        
        Resource file = new FileSystemResource(path.toFile());
        return ResponseEntity.ok()
            .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + fileName + "\"")
            .body(file);
    }
}