package com.leszko.calculator; 
import com.hazelcast.client.config.ClientConfig; 
import org.springframework.boot.SpringApplication; 
import org.springframework.boot.autoconfigure.SpringBootApplication; 
import org.springframework.cache.annotation.EnableCaching; 
import org.springframework.context.annotation.Bean; 


@SpringBootApplication
public class CalculatorApplication {

	public static void main(String[] args) {
		SpringApplication.run(CalculatorApplication.class, args);
	}
}
