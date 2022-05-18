package com.dullinsub.mapper;

import static org.junit.Assert.assertNotNull;

import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dullinsub.domain.CriteriaReply;
import com.dullinsub.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	@Autowired @Setter
	private ReplyMapper mapper;
	
	@Test
	public void testExist() {
		assertNotNull(mapper);
		log.info(mapper);
	}
//	12605
//	12604
//	12603
//	12602
//	12589
	@Test
	public void testInsert() {
		ReplyVO vo = new ReplyVO();
		vo.setBno(12604L);
		vo.setReply("댓글테스트3");
		vo.setReplyer("덜덜");
		
		mapper.insert(vo);
	}
	
	@Test
	public void testCreate() {
		Long[] bnoArr = {12605L, 12604L, 12603L, 12602L, 12589L};
		IntStream.rangeClosed(1, 100).forEach(r ->{
			ReplyVO vo = new ReplyVO();
			vo.setBno(bnoArr[r%5]);
			vo.setReply("댓글 내용" + r);
			vo.setReplyer("작성자" + r);
			
			mapper.insert(vo);
		});
	}
	
	@Test
	public void testRead() {
		ReplyVO replyVO = mapper.read(2L);
		log.info(replyVO);
	}
	
	@Test
	public void testDelete() {
		mapper.delete(1L);
	}
	
	@Test
	public void testUpdate() {
		ReplyVO replyVO = mapper.read(1L);
		replyVO.setReply("수정된 내용");
		mapper.update(replyVO);
	}
	
	@Test
	public void testList() {
		CriteriaReply cri = new CriteriaReply();
		cri.setLastRno(1l);
		mapper.getListWithPaging(12603L, new CriteriaReply());
	}
}
