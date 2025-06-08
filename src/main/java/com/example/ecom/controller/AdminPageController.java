package com.example.ecom.controller;

import java.util.Collections;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.example.ecom.model.Admin;
import com.example.ecom.model.Customer;
import com.example.ecom.model.Orderhist;
import com.example.ecom.model.Orderprod;
import com.example.ecom.model.Product;
import com.example.ecom.model.Seller;
import com.example.ecom.service.AdminRepo;
import com.example.ecom.service.CustomerRepo;
import com.example.ecom.service.OrderhistRepo;
import com.example.ecom.service.OrderprodRepo;
import com.example.ecom.service.ProductRepo;
import com.example.ecom.service.SellerRepo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

/**
 * Handles all administrative operations of the e-commerce platform,
 * including product management, seller and customer views, order handling,
 * and admin authentication.
 *
 * <p>
 * This controller facilitates workflows such as viewing seller/product lists,
 * approving/revoking permissions, managing cancellation requests,
 * and processing admin login sessions.
 *
 * @author Susanta Chowdhury, Rishabh Gon
 * @version 2.0
 * @since 2025-06-07
 */
@Controller
public class AdminPageController {

	/** Injected repository for handling admin-related database operations */
	@Autowired
	private AdminRepo arepo;

	/** Injected repository for product-related database operations */
	@Autowired
	private ProductRepo prepo;

	/** Injected repository for seller-related database operations */
	@Autowired
	private SellerRepo srepo;

	/** Injected repository for customer-related database operations */
	@Autowired
	private CustomerRepo crepo;

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
	private OrderhistRepo ohrepo;

	/**
	 * Displays the list of all permitted (approved) products.
	 *
	 * @param request the HTTP request to set attributes
	 * @param session the current HTTP session
	 * @return the name of the product list view template
	 */
	@GetMapping("/productlist")
	public String productlist(HttpServletRequest request, HttpSession session) {
		List<Product> prod_y_perm = prepo.findByPerm("YES");
		request.setAttribute("prod_y_perm", prod_y_perm);
		return "productlist";
	}

	/**
	 * Displays the admin login page.
	 *
	 * @return the name of the admin login view template
	 */
	@GetMapping("/Adminpage")
	public String Adminpage() {
		return "Adminpage";
	}

	/**
	 * Displays the admin homepage with the list of permitted sellers.
	 *
	 * @param session the current HTTP session
	 * @param request the HTTP request to set attributes
	 * @return the name of the admin home view
	 */
	@GetMapping("/adminhome")
	public String adminhome(HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("page") != null) {
			session.setAttribute("page", null);
		}
		if (session.getAttribute("sellerinfo") != null) {
			session.setAttribute("sellerinfo", null);
		}
		List<Seller> perm_seller = srepo.findByPerm("YES");
		request.setAttribute("perm_seller", perm_seller);
		return "adminhome";
	}

	/**
	 * Displays the list of non-permitted (inactive) sellers.
	 *
	 * @param session the current HTTP session
	 * @param request the HTTP request to set attributes
	 * @return the name of the passive sellers view
	 */
	@GetMapping("/passivesellers")
	public String passivesellers(HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("page") != null) {
			session.setAttribute("page", null);
		}
		if (session.getAttribute("sellerinfo") != null) {
			session.setAttribute("sellerinfo", null);
		}
		List<Seller> nonperm_seller = srepo.findByPerm("NO");
		request.setAttribute("nonperm_seller", nonperm_seller);
		return "passivesellers";
	}

	/**
	 * Displays the full list of customers.
	 *
	 * @param session the current HTTP session
	 * @param request the HTTP request to set attributes
	 * @return the name of the customer list view
	 */
	@GetMapping("/customerlist")
	public String customerlist(HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("custinfo") != null) {
			session.setAttribute("custinfo", null);
		}
		List<Customer> allcust = crepo.findAll();
		request.setAttribute("allcust", allcust);
		return "customerlist";
	}

	/**
	 * Displays the list of all orders in reverse chronological order.
	 *
	 * @param request the HTTP request to set attributes
	 * @return the name of the orders list view
	 */
	@GetMapping("/orderslist")
	public String orderslist(HttpServletRequest request) {
		List<Orderhist> allordhist = ohrepo.findAll();
		Collections.reverse(allordhist);
		request.setAttribute("allordhist", allordhist);
		return "orderslist";
	}

	/**
	 * Redirects to seller detail page with seller info set in session.
	 *
	 * @param sid     seller ID
	 * @param retp    return page identifier
	 * @param session current HTTP session
	 * @param request HTTP servlet request
	 * @return redirect to seller detail page
	 */
	@PostMapping("/seller_det")
	public String seller_det(@RequestParam("sellr_id") int sid, @RequestParam("page") String retp,
			HttpSession session, HttpServletRequest request) {
		Seller s = (Seller) srepo.findById(sid);
		session.setAttribute("sellerinfo", s);
		session.setAttribute("page", retp);
		return "redirect:/seller_det_sp";
	}

	/**
	 * Displays the permitted products of the seller.
	 *
	 * @param session the current session
	 * @param request the HTTP request
	 * @return view for permitted seller products
	 */
	@GetMapping("/seller_det_sp")
	public String seller_det_sp(HttpSession session, HttpServletRequest request) {
		Seller s = (Seller) session.getAttribute("sellerinfo");
		List<Product> permprodfsid = (List<Product>) prepo.findBySellerAndPerm(s, "YES");
		request.setAttribute("permprodfsid", permprodfsid);
		return "seller_det_sp";
	}

	/**
	 * Displays non-permitted products for the selected seller.
	 *
	 * @param session current session
	 * @param request HTTP request
	 * @return view for non-permitted seller products
	 */
	@GetMapping("/seller_det_pp")
	public String seller_det_pp(HttpSession session, HttpServletRequest request) {
		Seller s = (Seller) session.getAttribute("sellerinfo");
		List<Product> nonpermprodfsid = (List<Product>) prepo.findBySellerAndPerm(s, "NO");
		request.setAttribute("nonpermprodfsid", nonpermprodfsid);
		return "seller_det_pp";
	}

	/**
	 * Accepts cancellation of an order and initiates refund if product is
	 * available.
	 *
	 * @param ohid order history ID
	 * @return redirect to order list view
	 */
	@Transactional
	@PostMapping("/acceptcancel")
	public String acceptcancel(@RequestParam("orderhist_id") int ohid) {
		Orderhist ordhstobj = ohrepo.findById(ohid);
		Product p = prepo.findByIdAndNameAndPriceAndPd(ordhstobj.getProdid(), ordhstobj.getProductname(),
				ordhstobj.getProductprice(), ordhstobj.getProductdesc());
		if (p == null) {
			ordhstobj.setOrderstatus("cnc");
			ohrepo.save(ordhstobj);
			return "redirect:/orderslist";
		} else {
			ordhstobj.setOrderstatus("cancelled");
			ordhstobj.setRefunded(ordhstobj.getTaken());
			ordhstobj.setTaken(0.0);
			prepo.safeUpdateQuantity(p.getId(), ordhstobj.getBqty());
			ohrepo.save(ordhstobj);
			return "redirect:/orderslist";
		}
	}

	/**
	 * Rejects cancellation of an order and marks it as completed.
	 *
	 * @param ohid order history ID
	 * @return redirect to order list view
	 */
	@PostMapping("/rejectcancel")
	public String rejectcancel(@RequestParam("orderhist_id") int ohid) {
		Orderhist ordhstobj = ohrepo.findById(ohid);
		ordhstobj.setOrderstatus("completed");
		ohrepo.save(ordhstobj);
		return "redirect:/orderslist";
	}

	/**
	 * Stores customer details in session and redirects to order history page.
	 *
	 * @param cid     customer ID
	 * @param session HTTP session
	 * @param request HTTP request
	 * @return redirection to customer order history page
	 */
	@PostMapping("/customer_det")
	public String customer_det(@RequestParam("cust_id") int cid,
			HttpSession session, HttpServletRequest request) {
		Customer c = (Customer) crepo.findById(cid);
		session.setAttribute("custinfo", c);
		return "redirect:/customer_det_oh";
	}

	/**
	 * Displays the order history of a customer.
	 *
	 * @param session current session
	 * @param request HTTP request
	 * @return view for customer order history
	 */
	@GetMapping("/customer_det_oh")
	public String customer_det_oh(HttpSession session, HttpServletRequest request) {
		Customer c = (Customer) session.getAttribute("custinfo");
		List<Orderhist> ordhistofcust = (List<Orderhist>) ohrepo.findByCustid(c.getId());
		Collections.reverse(ordhistofcust);
		request.setAttribute("ordhistofcust", ordhistofcust);
		return "customer_det_oh";
	}

	/**
	 * Displays the cart details of a specific customer.
	 *
	 * @param session current session
	 * @param request HTTP request
	 * @return view for customer cart
	 */
	@GetMapping("/customer_det_ct")
	public String customer_det_ct(HttpSession session, HttpServletRequest request) {
		Customer c = (Customer) session.getAttribute("custinfo");
		List<Orderprod> cartofcust = (List<Orderprod>) orepo.findByCustomerId(c.getId());
		request.setAttribute("cartofcust", cartofcust);
		return "customer_det_ct";
	}

	/**
	 * Revokes permission of a seller and all their products.
	 *
	 * @param sid seller ID
	 * @return redirect to admin home
	 */
	@Transactional
	@PostMapping("/Remsellerperm")
	public String Remsellerperm(@RequestParam("sellr_id") int sid) {
		List<Product> plist = (List<Product>) prepo.findBySeller_IdAndPerm(sid, "YES");
		Seller s = (Seller) srepo.findById(sid);
		for (Product x : plist) {
			x.setPerm("NO");
			prepo.save(x);
		}
		s.setPerm("NO");
		srepo.save(s);
		return "redirect:/adminhome";
	}

	/**
	 * Grants permission to a seller.
	 *
	 * @param sid seller ID
	 * @return redirect to passive sellers view
	 */
	@Transactional
	@PostMapping("/Givsellerperm")
	public String Givsellerperm(@RequestParam("sellr_id") int sid) {
		Seller s = (Seller) srepo.findById(sid);
		s.setPerm("YES");
		srepo.save(s);
		return "redirect:/passivesellers";
	}

	/**
	 * Revokes permission for a product from seller detail view.
	 *
	 * @param pid product ID
	 * @return redirect to seller permitted products view
	 */
	@Transactional
	@PostMapping("/Remprodperm")
	public String Remprodperm(@RequestParam("prodid") int pid) {
		Product x = (Product) prepo.findById(pid);
		x.setPerm("NO");
		prepo.save(x);
		return "redirect:/seller_det_sp";
	}

	/**
	 * Revokes permission for a product from admin view.
	 *
	 * @param pid product ID
	 * @return redirect to overall product list
	 */
	@Transactional
	@PostMapping("/Remadminprodperm")
	public String Remadminprodperm(@RequestParam("prodid") int pid) {
		Product x = (Product) prepo.findById(pid);
		x.setPerm("NO");
		prepo.save(x);
		return "redirect:/productlist";
	}

	/**
	 * Grants product permission only if the associated seller is already permitted.
	 *
	 * @param pid product ID
	 * @return redirect to non-permitted products view
	 */
	@Transactional
	@PostMapping("/Giveprodperm")
	public String Giveprodperm(@RequestParam("prodid") int pid) {
		Product x = (Product) prepo.findById(pid);
		if (x.getSeller().getPerm().equals("YES")) {
			x.setPerm("YES");
			prepo.save(x);
		}
		return "redirect:/seller_det_pp";
	}

	/**
	 * Authenticates the admin credentials. On success, initializes session and
	 * redirects to home.
	 * On failure, displays error on login page.
	 *
	 * @param aname   admin username
	 * @param apass   admin password
	 * @param model   Spring model for passing error message
	 * @param session HTTP session
	 * @param request HTTP request
	 * @return redirect to admin home or back to login page
	 */
	@PostMapping("/LoginAdmin")
	public String LoginAdmin(@RequestParam("admin_name") String aname,
			@RequestParam("admin_password") String apass, ModelMap model,
			HttpSession session, HttpServletRequest request) {
		Admin admi = arepo.findByUsername(aname);
		if (admi != null) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(5);
			if (encoder.matches(apass, admi.getPassword())) {
				session.setAttribute("admin", admi);
				return "redirect:/adminhome";
			}
		}
		model.addAttribute("msg", "alfail");
		return "Adminpage";
	}

}
