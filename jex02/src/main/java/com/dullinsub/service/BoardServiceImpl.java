package com.dullinsub.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dullinsub.domain.BoardAttachVO;
import com.dullinsub.domain.BoardVO;
import com.dullinsub.domain.Criteria;
import com.dullinsub.mapper.BoardAttachMapper;
import com.dullinsub.mapper.BoardMapper;
import com.dullinsub.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service @AllArgsConstructor @Log4j
public class BoardServiceImpl implements BoardService {
	private BoardMapper boardMapper;
	private BoardAttachMapper boardAttachMapper;
	private ReplyMapper  replyMapper;
	
	@Transactional
	public int register(BoardVO boardVO) {
		log.info("register(" + boardVO + ")"); // 공통관심사로 분류 > 하나하나 일일이 하면 귀찮 >책에 없음
		// boardVO.bno == null
		int result = boardMapper.insertSelectKey(boardVO);
		
		boardVO.getAttachs().forEach(attach -> { // boardVO에서 attachs가 널이 아니게 설정을 해줬기때문에 널값을 체크할 필요 없다.
			attach.setBno(boardVO.getBno());
			boardAttachMapper.insert(attach);
		});
		// boardBO.bno == not null
		return result;
	}

	@Override
	public BoardVO get(Long bno) {
		// TODO Auto-generated method stub
		return boardMapper.read(bno);
	}

	@Override
	@Transactional
	public boolean modify(BoardVO boardVO) {
		// TODO Auto-generated method stub
		// 게시글의 첨부파일 일괄 삭제
		boardAttachMapper.deleteAll(boardVO.getBno());
		
		// 첨부파일 재등록
		boardVO.getAttachs().forEach(attach -> {
			attach.setBno(boardVO.getBno());
			boardAttachMapper.insert(attach);
		});
		
		return boardMapper.update(boardVO) > 0;
	}

	@Override
	@Transactional
	public boolean remove(Long bno) {
		replyMapper.deleteAll(bno);
		boardAttachMapper.deleteAll(bno);
		return boardMapper.delete(bno) > 0;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return boardMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		// TODO Auto-generated method stub
		return boardMapper.getTotalCount(cri);
	}
	
	@Override
	public List<BoardAttachVO> getAttachs(Long bno) {
		// TODO Auto-generated method stub
		return boardAttachMapper.findBy(bno);
	}
}
