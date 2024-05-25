package com.example.springbootdeploy;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@RestController
public class SpringbootDeployApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringbootDeployApplication.class, args);
	}
	@GetMapping("/")
	public String home(){
	return "welcome imannaaaaa!!";
	}

}
