package co.micol.prj.member.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class ProductVO {
	String productCode;
	String productName;
	String productDesc;
	int productPrice;
	int salePrice;
	String likeIt;
	String productImage;
}
