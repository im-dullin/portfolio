package com.dullinsub.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString(callSuper=true) // super클래스(조상)에 대한 조상필드도 모두 보려면 이걸 반드시 써야함.
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class BoardAttachVO extends AttachFileDTO{
	private Long bno;

	public BoardAttachVO(String origin, String uuid, String path, boolean image, Long bno) {
		super(origin, uuid, path, image);
		this.bno = bno;
	}
	
	public BoardAttachVO(AttachFileDTO dto, Long bno) {
		this(dto.getOrigin(), dto.getUuid(), dto.getPath(), dto.isImage(), bno);
	}
}
