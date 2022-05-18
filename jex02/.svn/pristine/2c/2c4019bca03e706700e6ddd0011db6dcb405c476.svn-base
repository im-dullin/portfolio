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
public class ReplyAttachVO extends AttachFileDTO{
	private Long rno;

	public ReplyAttachVO(String origin, String uuid, String path, boolean image, Long rno) {
		super(origin, uuid, path, image);
		this.rno = rno;
	}
	
	public ReplyAttachVO(AttachFileDTO dto, Long rno) {
		this(dto.getOrigin(), dto.getUuid(), dto.getPath(), dto.isImage(), rno);
	}
}
