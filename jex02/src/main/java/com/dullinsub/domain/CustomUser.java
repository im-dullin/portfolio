package com.dullinsub.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@SuppressWarnings("serial")
@Getter
public class CustomUser extends User{
	private MemberVO member;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(MemberVO vo) {
		this(vo.getUserid(), vo.getUserpw(), 
				vo.getAuths().stream().map(auth-> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList())
		); // 생성자의 첫 줄은 언제나 this나 super만 올 수 있음.
		// vo.getAuths() : List<AuthVO> 타입 >> List<GrantedAuthority> 으로 변환작업 >> 제너릭변경
		member = vo;
	}
}
