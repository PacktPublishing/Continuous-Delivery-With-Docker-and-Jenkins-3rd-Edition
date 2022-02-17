 package smoke;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

 /** Smoke Test */
 @RunWith(Cucumber.class)
 @CucumberOptions(features = "classpath:smoke")
 public class SmokeTest { }