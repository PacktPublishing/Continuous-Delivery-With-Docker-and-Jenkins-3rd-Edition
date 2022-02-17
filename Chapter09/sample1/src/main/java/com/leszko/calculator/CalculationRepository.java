package com.leszko.calculator;

import org.springframework.data.repository.CrudRepository;

/** Calculation repository. */
public interface CalculationRepository extends CrudRepository<Calculation, Integer> {}