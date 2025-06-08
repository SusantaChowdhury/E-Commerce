package com.example.ecom.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.example.ecom.model.Customer;
import com.example.ecom.model.Orderhist;
import com.example.ecom.model.Orderprod;
import com.example.ecom.model.Product;
import com.example.ecom.service.CustomerRepo;
import com.example.ecom.service.OrderhistRepo;
import com.example.ecom.service.OrderprodRepo;
import com.example.ecom.service.ProductRepo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

/**
 * Controller class for managing customer-facing operations such as
 * registration,
 * login, product browsing, cart management, and order processing in the
 * e-commerce application.
 *
 * <p>
 * This controller handles various HTTP endpoints for customer functionalities,
 * such as viewing products, adding to cart, managing cart items, placing
 * orders,
 * viewing order history, and account actions like login and registration.
 *
 * @author Susanta Chowdhury, Rishabh Gon
 * @version 2.0
 * @since 2025-06-07
 */

@Controller
public class CustomerController {

	/** Injected repository for Customer-related database operations */
	@Autowired
	private CustomerRepo crepo;

	/** Injected repository for Product-related database operations */
	@Autowired
	private ProductRepo prepo;

	/**
	 * Injected repository for Orderprod(i.e., Ordered Product)-related database
	 * operations
	 */
	@Autowired
	private OrderprodRepo orepo;

	/**
	 * Injected repository for Orderhist(i.e., Order History)-related database
	 * operations
	 */
	@Autowired
	private OrderhistRepo ordhist;

	/**
	 * Displays the customer login page.
	 * 
	 * @return The login page view.
	 */
	@GetMapping("/customer_login")
	public String customer_login() {
		return "customer_login";
	}

	/**
	 * Displays the customer registration page.
	 * 
	 * @return The registration page view.
	 */
	@GetMapping("/register_customer")
	public String register_customer() {
		return "register_customer";
	}

	/**
	 * Displays the customer home page with available products.
	 * 
	 * @param request The HTTP servlet request.
	 * @param session The HTTP session.
	 * @return The customer home page view.
	 */
	@GetMapping("/customerhome")
	public String customerhome(HttpServletRequest request, HttpSession session) {
		List<Product> prod_y_perm = prepo.findByPerm("YES");
		request.setAttribute("prod_y_perm", prod_y_perm);
		return "customerhome";
	}

	/**
	 * Validates the email format and checks if it belongs to an allowed domain such
	 * as, "gmail.com", "yahoomail.com" or "rediffmail.com".
	 * 
	 * @param mail Email string.
	 * @return True if valid, false otherwise.
	 */
	public boolean validEmail(String mail) {
		if (mail == null || mail.isEmpty()) {
			return false;
		}

		// Allowed email domains
		String[] allowedDomains = { "gmail.com", "rediffmail.com", "yahoomail.com" };

		// Split the email into two parts: local part and domain part
		int atIndex = mail.lastIndexOf('@');
		if (atIndex <= 0 || atIndex == mail.length() - 1) {
			return false; // Invalid if @ is missing, at the start, or end
		}

		String localPart = mail.substring(0, atIndex);
		String domainPart = mail.substring(atIndex + 1);

		// Check if domain is in the allowed list
		boolean isDomainValid = false;
		for (String domain : allowedDomains) {
			if (domain.equalsIgnoreCase(domainPart)) {
				isDomainValid = true;
				break;
			}
		}

		if (!isDomainValid) {
			return false;
		}

		return localPart.matches("^[A-Za-z0-9._%+-]+$");
	}

	/**
	 * Retrieves a map of product IDs to their available quantities
	 * for all products that are marked as permitted for sale. *
	 * 
	 * @return A map of product quantities.
	 */
	@GetMapping("/product-qty")
	@ResponseBody
	public Map<Integer, Integer> getProductQuantities() {
		List<Product> products = prepo.findByPerm("YES");
		Map<Integer, Integer> qtyMap = new HashMap<>();
		for (Product p : products) {
			qtyMap.put(p.getId(), p.getQuantity());
		}
		return qtyMap;
	}

	/**
	 * Displays the customer's cart with selected products.
	 * 
	 * @param session The HTTP session.
	 * @param request The HTTP servlet request.
	 * @return The cart view.
	 */
	@GetMapping("/custcart")
	public String custcart(HttpSession session, HttpServletRequest request) {
		int cid = ((Customer) session.getAttribute("customer")).getId();
		List<Orderprod> cartprods = orepo.findByCustomerIdAndProductPermYes(cid);
		request.setAttribute("cartprods", cartprods);
		return "custcart";
	}

	/**
	 * Adds a product to the customer's cart or increments its quantity if already
	 * present.
	 * 
	 * @param pid     Product ID.
	 * @param session HTTP session.
	 * @return Redirect to customer home.
	 */
	@PostMapping("/Addcart")
	public String Addcart(@RequestParam("product_id") int pid, HttpSession session) {
		Customer c = (Customer) session.getAttribute("customer");
		Orderprod check_o = orepo.findByProductIdAndCustomerId(pid, c.getId());
		if (check_o == null) {
			Product p = prepo.findById(pid);
			Orderprod o = new Orderprod(c, p);
			orepo.save(o);
		} else {
			check_o.incQtybyOne();
			orepo.save(check_o);
		}
		return "redirect:/customerhome";
	}

	/**
	 * Processes a single product purchase directly.
	 * 
	 * @param pid     Product ID.
	 * @param session HTTP session.
	 * @return Redirect to order history.
	 */
	@Transactional
	@PostMapping("/Buynowsingle")
	public String Buynowsingle(@RequestParam("product_id") int pid, HttpSession session) {
		Customer c = (Customer) session.getAttribute("customer");
		Product p = (Product) prepo.findById(pid);
		int updated = prepo.atomicBuyCheck(pid, 1, p.getPrice());
		Orderhist ordhstobj;
		if (updated == 1) {
			ordhstobj = ordhist.save(new Orderhist(p.getName(), p.getPrice(), p.getPd(), p.getSeller().getName(),
					c.getName(), p.getSeller().getId(), c.getId(), 1, p.getPrice(), 0.0, p.getId()));
		} else {
			ordhstobj = ordhist.save(new Orderhist(p.getName(), p.getPrice(), p.getPd(), p.getSeller().getName(),
					c.getName(), p.getSeller().getId(), c.getId(), 1, 0.0, p.getPrice(), p.getId()));
		}
		// image path from database
		String dbImagePath = "src\\main\\webapp"
				+ p.getImgp();

		// Desired destination folder
		String destDir = "src\\main\\webapp\\ordimages";

		// New file name
		String newFileName = "oimg" + ordhstobj.getId() + "." + p.getImgp().substring(p.getImgp().lastIndexOf(".") + 1);

		// Define source and target paths
		Path sourcePath = Paths.get(dbImagePath);
		Path targetPath = Paths.get(destDir, newFileName);

		// Copy the file (replace if exists)
		try {
			Files.copy(sourcePath, targetPath, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException e) {
			return "redirect:/custordrhist";
		}
		ordhstobj.setOimg("/ordimages/" + newFileName);
		ordhist.save(ordhstobj);
		return "redirect:/custordrhist";
	}

	/**
	 * Processes all items in cart and places the order.
	 * 
	 * @param cid     Customer ID.
	 * @param session HTTP session.
	 * @return Redirect to order history.
	 */
	@Transactional
	@PostMapping("/Buynowset")
	public String Buynowset(@RequestParam("cust_id") int cid, HttpSession session) {
		List<Orderprod> cl = orepo.findByCustomerId(cid);
		Customer c = (Customer) session.getAttribute("customer");
		Orderhist ordhstobj;
		for (Orderprod x : cl) {
			Product p = x.getProduct();
			int updated = prepo.atomicBuyCheck(p.getId(), x.getQty(), (x.getQty() * p.getPrice()));
			if (updated == 1) {
				ordhstobj = ordhist.save(new Orderhist(p.getName(), p.getPrice(), p.getPd(), p.getSeller().getName(),
						c.getName(), p.getSeller().getId(), c.getId(), x.getQty(), (p.getPrice() * x.getQty()), 0.0,
						p.getId()));
				orepo.delete(x);
			} else {
				ordhstobj = new Orderhist(p.getName(), p.getPrice(), p.getPd(), p.getSeller().getName(), c.getName(),
						p.getSeller().getId(), c.getId(), x.getQty(), 0.0, (p.getPrice() * x.getQty()), p.getId());
				ordhstobj = ordhist.save(ordhstobj);
			}
			// image path from database
			String dbImagePath = "src\\main\\webapp"
					+ p.getImgp();

			// Desired destination folder
			String destDir = "src\\main\\webapp\\ordimages";

			// New file name
			String newFileName = "oimg" + ordhstobj.getId() + "."
					+ p.getImgp().substring(p.getImgp().lastIndexOf(".") + 1);

			// Define source and target paths
			Path sourcePath = Paths.get(dbImagePath);
			Path targetPath = Paths.get(destDir, newFileName);

			// Copy the file (replace if exists)
			try {
				Files.copy(sourcePath, targetPath, StandardCopyOption.REPLACE_EXISTING);
			} catch (IOException e) {
				return "redirect:/custordrhist";
			}
			ordhstobj.setOimg("/ordimages/" + newFileName);
			ordhist.save(ordhstobj);
		}
		return "redirect:/custordrhist";
	}

	/**
	 * Displays the customer's order history.
	 * 
	 * @param request HTTP request.
	 * @param session HTTP session.
	 * @return Order history view.
	 */
	@GetMapping("/custordrhist")
	public String custordrhist(HttpServletRequest request, HttpSession session) {
		Customer c = (Customer) session.getAttribute("customer");
		List<Orderhist> p = (List<Orderhist>) ordhist.findByCustid(c.getId());
		Collections.reverse(p);
		request.setAttribute("ordhist", p);
		return "custordrhist";
	}

	/**
	 * Marks an order as "appeal" to request cancellation.
	 * 
	 * @param ohid Order history ID.
	 * @return Redirect to order history.
	 */
	@PostMapping("/cancelord")
	public String cancelord(@RequestParam("orderhist_id") int ohid) {
		Orderhist ordhstobj = ordhist.findById(ohid);
		ordhstobj.setOrderstatus("appeal");
		ordhist.save(ordhstobj);
		return "redirect:/custordrhist";
	}

	/**
	 * Increments quantity of a product in the cart.
	 * 
	 * @param oid Order ID.
	 * @return Redirect to cart.
	 */
	@PostMapping("/Addprodcartval")
	public String Addprodcartval(@RequestParam("order_id") int oid) {
		Orderprod check_o = (Orderprod) orepo.findById(oid);
		check_o.incQtybyOne();
		orepo.save(check_o);
		return "redirect:/custcart";
	}

	/**
	 * Decrements quantity of a product in the cart.
	 * 
	 * @param oid Order ID.
	 * @return Redirect to cart.
	 */
	@PostMapping("/Subprodcartval")
	public String Subprodcartval(@RequestParam("order_id") int oid) {
		Orderprod check_o = (Orderprod) orepo.findById(oid);
		check_o.decQtybyOne();
		orepo.save(check_o);
		return "redirect:/custcart";
	}

	/**
	 * Deletes a product from the cart.
	 * 
	 * @param oid Order ID.
	 * @return Redirect to cart.
	 */
	@PostMapping("/Delcart")
	public String Delcart(@RequestParam("order_id") int oid) {
		orepo.deleteById(oid);
		return "redirect:/custcart";
	}

	/**
	 * Handles customer registration and validates input credentials.
	 * Password is encoded and saved if validation succeeds.
	 * 
	 * @param cname    Customer name.
	 * @param cmail    Customer email.
	 * @param cpass    Customer password.
	 * @param confpass Confirm password.
	 * @param model    Model for passing attributes.
	 * @return Registration page view.
	 */
	@PostMapping("/RegisterCustomer")
	public String RegisterCustomer(@RequestParam("cust_name") String cname,
			@RequestParam("cust_mail") String cmail, @RequestParam("cust_password") String cpass,
			@RequestParam("cust_re_password") String confpass, ModelMap model) {
		if (cpass.equals(confpass) == false) { // passwords don't match
			model.addAttribute("msg", "pfail");
		} else if (crepo.existsByEmail(cmail)) { // email already exists
			model.addAttribute("msg", "mxstfail");
		} else if (validEmail(cmail) == false) {
			model.addAttribute("msg", "emfail");
		} else {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(5);
			cpass = encoder.encode(cpass);
			Customer c = new Customer(cname, cmail, cpass);
			crepo.save(c);
			model.addAttribute("msg", "success");
		}
		return "register_customer";
	}

	/**
	 * Handles customer login by verifying credentials and establishing a session.
	 * 
	 * @param cmail   Email.
	 * @param cpass   Password.
	 * @param model   Model.
	 * @param session HTTP session.
	 * @param request HTTP request.
	 * @return Home page if success, login page with error otherwise.
	 */
	@PostMapping("/LoginCustomer")
	public String LoginCustomer(@RequestParam("cust_mail") String cmail,
			@RequestParam("cust_password") String cpass, ModelMap model,
			HttpSession session, HttpServletRequest request) {
		Customer cust = crepo.findByEmail(cmail);
		if (cust != null) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(5);
			if (encoder.matches(cpass, cust.getPassword())) {
				session.setAttribute("customer", cust);
				return "redirect:/customerhome";
			}
		}
		model.addAttribute("msg", "clfail");
		return "customer_login";
	}

}