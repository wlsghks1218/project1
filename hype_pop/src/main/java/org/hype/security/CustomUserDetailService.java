package org.hype.security;

import org.hype.domain.signInVO;
import org.hype.mapper.SecurityMapper;
import org.hype.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailService implements UserDetailsService{
	
	@Autowired
	private SecurityMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
	    log.warn("load user by userName : " + username);
	    
	    signInVO vo = mapper.read(username);
	    if (vo == null) {
	        log.warn("User not found: " + username);
	        throw new UsernameNotFoundException("User not found");
	    }
	    
	    log.warn("member mapper : " + vo);
	    return new CustomUser(vo);
	}
}