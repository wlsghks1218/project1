package org.hype.mapper;

import org.hype.domain.signInVO;

public interface SecurityMapper {
	public signInVO read(String username);
}