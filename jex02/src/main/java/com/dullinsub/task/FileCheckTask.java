package com.dullinsub.task;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.dullinsub.domain.BoardAttachVO;
import com.dullinsub.mapper.BoardAttachMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
@AllArgsConstructor
public class FileCheckTask { // 스케줄러! 완전 초간단
	private BoardAttachMapper mapper;
	
	@Scheduled(cron="0 0 2 * * *") // 매일 새벽 2시마다
	public void checkFiles() {
		log.warn("File Check Task");
		log.warn("==========================================");
		log.warn(getFolderYesterday());
		
		File file = new File("C:/upload/temp", getFolderYesterday());
		if(!file.exists()){
			return;
		}
		
		log.warn("==========================================");
		
		List<BoardAttachVO> dbFiles = mapper.getOldFiles(); // DB 내의 파일들
		
		// db > file type list
		List<File> dbFiles2 = 
				dbFiles.stream()
				.map(attach -> new File(file, attach.getUuid()))
				.collect(Collectors.toList());
		
		// thumbnail add
		dbFiles.stream()
		.filter(BoardAttachVO::isImage)
		.map(attach->new File(file, "s_" + attach.getUuid()))
		.forEach(dbFiles2::add);
		
		// db에 존재하지 않는 파일 삭제
		Arrays.asList(file.listFiles(f -> !dbFiles2.contains(f))).forEach(File::delete); // 업로드 폴더내의 파일들
		
	}
	
	private String getFolderYesterday() {
		return new SimpleDateFormat("yyyy/MM/dd").format(new Date().getTime() - 1000 * 60 * 60 * 24);
	}
}
