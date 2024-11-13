package org.joonzis.security.domain;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.hype.domain.signInVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User {
	private static final long serialVersionUID = 1L;

	private signInVO member;

	// 기본 생성자
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	// signInVO 기반 생성자
	public CustomUser(signInVO vo) {
		super(vo.getUserId(), vo.getUserPw(), vo.getAuth() == 2 ? List.of(new SimpleGrantedAuthority("ROLE_ADMIN"))
				: List.of(new SimpleGrantedAuthority("ROLE_USER")));
		this.member = vo; // 전체 signInVO 객체를 저장
	}
}