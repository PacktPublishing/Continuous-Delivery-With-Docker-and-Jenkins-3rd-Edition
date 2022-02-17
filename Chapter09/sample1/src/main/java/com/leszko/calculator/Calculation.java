package com.leszko.calculator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/** Calculation entity class. */
@Entity
public class Calculation {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	private String a;

	private String b;

	private String result;

	protected Calculation() {
	}

	public Calculation(String a, String b, String result) {
		this.a = a;
		this.b = b;
		this.result = result;
	}
}