package kz.kcsd.hallo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class HalloApplication {

	public static void main(String[] args) {
		SpringApplication.run(HalloApplication.class, args);
	}

	@RestController
	@RequestMapping("hallo")
	public static class Hallo {
		@GetMapping(produces = MediaType.TEXT_PLAIN_VALUE)
		public String say() {
			return "Hallo, world!";
		}
	}

}
