package org.hype.security.domain;

import java.util.Collection;
import java.util.List;
import org.hype.domain.signInVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User {
    private static final long serialVersionUID = 1L;

    private signInVO member;

    // 인자 없는 기본 생성자 추가
    public CustomUser() {
        super("default", "default", List.of(new SimpleGrantedAuthority("ROLE_USER")));
        this.member = null; // 기본 생성자에서 member는 null로 초기화
    }

    // username, password, authorities 기반 생성자
    public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);
        this.member = null; // 이 생성자도 member는 null로 초기화
    }

    // signInVO 기반 생성자
    public CustomUser(signInVO vo) {
        super(vo.getUserId(), vo.getUserPw(), vo.getAuth() == 2
                ? List.of(new SimpleGrantedAuthority("ROLE_ADMIN"))
                : List.of(new SimpleGrantedAuthority("ROLE_USER")));
        this.member = vo; // 전체 signInVO 객체를 저장
    }

    // userNo를 직접 가져오는 메소드 추가
    public int getUserNo() {
        return this.member != null ? this.member.getUserNo() : -1;
    }
}
