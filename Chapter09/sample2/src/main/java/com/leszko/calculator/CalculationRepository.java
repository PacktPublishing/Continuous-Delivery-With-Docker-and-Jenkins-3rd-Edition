package com.leszko.calculator; 
import org.springframework.data.repository.CrudRepository; 
 
public interface CalculationRepository extends CrudRepository<Calculation, Integer> {} 