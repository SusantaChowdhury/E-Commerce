package com.example.ecom.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import jakarta.servlet.http.HttpServletRequest;

/**
 * Controller class responsible for handling public-facing page routes
 * such as index, about us, contact us, and logout functionality.
 * <p>
 * This controller manages navigation-related endpoints that are accessible
 * without authentication.
 * </p>
 * 
 * @author YourName
 * @version 2.0
 * @since 2025-06-07
 */
@Controller
public class IndexController {

	/**
	 * Handles requests to the root URL ("/") and returns the homepage view.
	 *
	 * @return The name of the index view template.
	 */
	@GetMapping("/")
	public String index() {
		return "index";
	}

	/**
	 * Handles requests to "/aboutus" and returns the about us page view.
	 *
	 * @return The name of the about us view template.
	 */
	@GetMapping("/aboutus")
	public String aboutus() {
		return "aboutus";
	}

	/**
	 * Handles requests to "/contactus" and returns the contact us page view.
	 *
	 * @return The name of the contact us view template.
	 */
	@GetMapping("/contactus")
	public String contactus() {
		return "contactus";
	}

	/**
	 * Handles POST requests for logging out the user.
	 * <p>
	 * Invalidates the current user session and redirects to the home page.
	 * </p>
	 *
	 * @param request The HTTP request used to access and invalidate the session.
	 * @return A redirection string to the homepage.
	 */
	@PostMapping("/Logout")
	public String Logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/";
	}

}
