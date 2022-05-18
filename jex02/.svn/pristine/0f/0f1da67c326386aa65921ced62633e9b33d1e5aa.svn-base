package com.dullinsub.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dullinsub.domain.AuthVO;
import com.dullinsub.domain.MemberVO;
import com.dullinsub.security.SecurityTests;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class MemberMapperTests {
	@Setter @Autowired
	private PasswordEncoder encoder;
	@Setter @Autowired
	private MemberMapper mapper;
	
	@Test
	public void testInsertMember() {
		MemberVO vo = new MemberVO();
		vo.setUserid("admin99");
		vo.setUserpw(encoder.encode("1234"));
		vo.setUsername("관리자");
		
		log.info(vo);
		
		mapper.insertMember(vo);
	}
	
	@Test
	public void testInsertAuth() {
		AuthVO vo = new AuthVO();
		vo.setUserid("admin99");
//		vo.setAuth("ROLE_MEMBER");
//		vo.setAuth("ROLE_MANAGER");
		vo.setAuth("ROLE_ADMIN");
		
		mapper.insertAuth(vo);
	}
	
	@Test
	public void testRead() {
		log.info(mapper.read("admin99"));
	}
}
