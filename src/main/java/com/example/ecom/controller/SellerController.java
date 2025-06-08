package com.example.ecom.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.example.ecom.model.Product;
import com.example.ecom.model.Seller;
import com.example.ecom.service.ProductRepo;
import com.example.ecom.service.SellerRepo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

/**
 * Controller responsible for handling seller-related operations,
 * such as registration, login, product management, and logout.
 *
 * @author Susanta Chowdhury, Rishabh Gon
 * @version 2.0
 * @since 2025-06-07
 */
@Controller
public class SellerController {

	/** Injected repository for Seller-related database operations */
	@Autowired
	private SellerRepo srepo;

	/** Injected repository for Product-related database operations */
	@Autowired
	private ProductRepo prepo;

	/**
	 * Loads the seller login page.
	 *
	 * @return seller login view name
	 */
	@GetMapping("/seller_login")
	public String seller_login() {
		return "seller_login";
	}

	/**
	 * Loads the seller registration page.
	 *
	 * @return register seller view name
	 */
	@GetMapping("/register_seller")
	public String register_seller() {
		return "register_seller";
	}

	/**
	 * Loads the seller add product page.
	 *
	 * @return add product view name
	 */
	@GetMapping("/seller_add_product")
	public String seller_add_product() {
		return "seller_add_product";
	}

	/**
	 * Validates an email address against format and allowed domains.
	 * Accepted domains: gmail.com, rediffmail.com, yahoomail.com
	 *
	 * @param mail email address string to validate
	 * @return true if the email is valid and domain is allowed; false otherwise
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
	 * Handles seller registration by validating input, storing seller info,
	 * and saving the uploaded verification document.
	 *
	 * Validations include:
	 * <ul>
	 * <li>Password and confirm password match</li>
	 * <li>Unique email check</li>
	 * <li>Domain-restricted email validation</li>
	 * </ul>
	 *
	 * If successful, the uploaded PDF document is renamed and stored.
	 * Failure cases will result in appropriate feedback messages being added to the
	 * model.
	 *
	 * @param sname     seller name
	 * @param smail     seller email
	 * @param spass     password
	 * @param pdfFile   PDF document (ID verification)
	 * @param sconfpass re-entered password
	 * @param model     Spring ModelMap for conveying messages
	 * @return the registration page view
	 */

	@PostMapping("/RegisterSeller")
	public String RegisterSeller(@RequestParam("seller_name") String sname,
			@RequestParam("seller_mail") String smail, @RequestParam("seller_password") String spass,
			@RequestParam("pdfFile") MultipartFile pdfFile,
			@RequestParam("seller_re_password") String sconfpass, ModelMap model) {
		if (spass.equals(sconfpass) == false) { // passwords don't match
			model.addAttribute("msg", "pfail");
		} else if (srepo.existsByEmail(smail)) { // email already exists
			model.addAttribute("msg", "mxstfail");
		} else if (validEmail(smail) == false) {
			model.addAttribute("msg", "emfail");
		} else {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(5);
			spass = encoder.encode(spass);
			Seller s = new Seller(sname, smail, spass);
			s = srepo.save(s);
			try {
				String fileName = "doc" + s.getId() + ".pdf";

				// Target directory inside static or external path
				String uploadDir = "src\\main\\webapp\\sdocs\\";
				Path path = Paths.get(uploadDir, fileName);

				// Save PDF
				Files.copy(pdfFile.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
				s.setDocs("/sdocs/" + fileName);
				srepo.save(s);
			} catch (IOException e) {
				srepo.delete(s);
				model.addAttribute("msg", "tfail");
				return "register_seller";
			}
			model.addAttribute("msg", "success");
		}
		return "register_seller";
	}

	/**
	 * Selects a product to edit its quantity only.
	 *
	 * @param pid     product ID
	 * @param session HTTP session
	 * @return view for editing product quantity
	 */
	@PostMapping("/slctslrhmprod")
	public String slctslrhmprod(@RequestParam("prod_id") int pid, HttpSession session) {
		Product p = prepo.findById(pid);
		session.setAttribute("prod_edit_quant", p);
		return "editquantsellr";
	}

	/**
	 * Selects a product to edit its details.
	 * Applicable only for the products that are pending for being approved.
	 *
	 * @param pid     product ID
	 * @param session HTTP session
	 * @return view for editing product details
	 */
	@PostMapping("/editsellrproddet")
	public String editsellrproddet(@RequestParam("prod_id") int pid, HttpSession session) {
		Product p = prepo.findById(pid);
		session.setAttribute("prod_edit", p);
		return "selreddet";
	}

	/**
	 * Updates product details for a seller.
	 *
	 * @param pname   product name
	 * @param pquant  product quantity
	 * @param pprice  product price
	 * @param ppd     product description
	 * @param image   product image
	 * @param request servlet request
	 * @param session HTTP session
	 * @return view for editing product
	 */
	@PostMapping("/EdtProductSelr")
	public String EdtProductSelr(@RequestParam("prod_name") String pname, @RequestParam("prod_quant") String pquant,
			@RequestParam("product_price") String pprice, @RequestParam("product_pd") String ppd,
			@RequestParam("product_image") MultipartFile image,
			HttpServletRequest request, HttpSession session) {
		Product p = (Product) session.getAttribute("prod_edit");
		request.setAttribute("msg", "Success");
		if (ppd.length() != 0) {
			p.setPd(ppd);
		}
		if (pname.length() != 0) {
			p.setName(pname);
		}
		if (pprice.length() != 0) {
			try {
				double price = Double.parseDouble(pprice);
				p.setPrice(price);
			} catch (NumberFormatException e) {
				request.setAttribute("msg", "Price must be a numerical value");
			}
		}
		if (pquant.length() != 0) {
			try {
				int quant = Integer.parseInt(pquant);
				if (quant < 1) {
					request.setAttribute("msg", "Quantity must be equal or greater than 1");
				} else {
					p.setQuantity(quant);
				}
			} catch (NumberFormatException e) {
				request.setAttribute("msg", "Quantity must be a whole number");
			}
		}
		try {
			String originalFilename = image.getOriginalFilename();
			if (originalFilename != null) {
				String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1);
				String newFileName = "img" + p.getId() + "." + extension;
				String uploadDir = "src\\main\\webapp\\prodimages";
				Path path = Paths.get(uploadDir, newFileName);
				Files.copy(image.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
				p.setImgp("/prodimages/" + newFileName);
				prepo.save(p);
			}
		} catch (Exception e) {
			request.setAttribute("msg", "Failed to add image");
		}
		prepo.save(p);
		return "selreddet";
	}

	/**
	 * Loads the view to edit product quantity.
	 *
	 * @return edit quantity page
	 */
	@GetMapping("/editquantsellr")
	public String editquantsellr() {
		return "editquantsellr";
	}

	/**
	 * Adds quantity to an existing product.
	 *
	 * @param pid     product ID
	 * @param qnt     quantity to add
	 * @param request HTTP request
	 * @return edit quantity page
	 */
	@Transactional
	@PostMapping("/editaddquantsellr")
	public String editaddquantsellr(@RequestParam("prod_id") int pid,
			@RequestParam("addprod_quant") String qnt, HttpServletRequest request) {
		int plusqnt = 0;
		try {
			plusqnt = Integer.parseInt(qnt);
		} catch (NumberFormatException e) {
			request.setAttribute("prod_id", pid);
			request.setAttribute("msg", "Enter quantity as a whole number");
		}
		if (plusqnt < 1) {
			request.setAttribute("prod_id", pid);
			request.setAttribute("msg", "Quantity must be a positive number");
		} else {
			int chng = prepo.safeUpdateQuantity(pid, plusqnt);
			if (chng == 1) {
				request.setAttribute("prod_id", pid);
				request.setAttribute("msg", "Success");
			} else {
				request.setAttribute("prod_id", pid);
				request.setAttribute("msg", "Problem in server. Try agin");
			}
		}
		return "editquantsellr";
	}

	/**
	 * Authenticates and logs in the seller.
	 *
	 * @param smail   seller email
	 * @param spass   seller password
	 * @param model   ModelMap to pass messages
	 * @param session HTTP session
	 * @param request servlet request
	 * @return seller home or login page
	 */
	@PostMapping("/LoginSeller")
	public String LoginSeller(@RequestParam("seller_mail") String smail,
			@RequestParam("seller_password") String spass, ModelMap model,
			HttpSession session, HttpServletRequest request) {
		Seller seller = srepo.findByEmail(smail);
		if (seller != null) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(5);
			if (encoder.matches(spass, seller.getPassword())) {
				session.setAttribute("seller", seller);
				return "redirect:/sellerhome";
			}
		}
		model.addAttribute("msg", "slfail");
		return "seller_login";
	}

	/**
	 * Handles the addition of a new product by the logged-in seller.
	 * Validates numeric inputs, quantity constraints, and processes file uploads.
	 * If validation or file upload fails, appropriate error messages are added.
	 *
	 * @param pname   product name
	 * @param pquant  quantity as string
	 * @param pprice  price as string
	 * @param ppd     product description
	 * @param image   image file
	 * @param model   Spring ModelMap for status messages
	 * @param session HTTP session containing seller information
	 * @return product addition view
	 */
	@PostMapping("/RegisterProduct")
	public String RegisterProduct(@RequestParam("prod_name") String pname, @RequestParam("prod_quant") String pquant,
			@RequestParam("product_price") String pprice, @RequestParam("product_pd") String ppd,
			@RequestParam("product_image") MultipartFile image,

			ModelMap model, HttpSession session) {
		double prod_price = 0.0;
		int prod_quantity = 1;
		try {
			prod_price = Double.parseDouble(pprice);
		} catch (NumberFormatException E) {
			model.addAttribute("addProdmsg", "Price must be a numerical value");
			return "seller_add_product";
		}
		try {
			prod_quantity = Integer.parseInt(pquant);
		} catch (NumberFormatException E) {
			model.addAttribute("addProdmsg", "Quantity must be a whole value");
			return "seller_add_product";
		}
		if (prod_quantity < 1) {
			model.addAttribute("addProdmsg", "Quantity must be equal or greater than 1");
			return "seller_add_product";
		}
		Seller s = (Seller) session.getAttribute("seller");
		Product p = new Product(s, pname, prod_price, ppd, prod_quantity);
		p = prepo.save(p);

		int prodid = p.getId();
		try {
			String originalFilename = image.getOriginalFilename();
			String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1);
			String newFileName = "img" + prodid + "." + extension;
			String uploadDir = "src\\main\\webapp\\prodimages";
			Path path = Paths.get(uploadDir, newFileName);
			Files.copy(image.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
			p.setImgp("/prodimages/" + newFileName);
			prepo.save(p);
			model.addAttribute("addProdmsg", "Added");
		} catch (Exception e) {
			model.addAttribute("addProdmsg", "Problem in adding image");
			throw new RuntimeException("Image upload failed", e);
		}

		model.addAttribute("addProdmsg", "Added");
		return "seller_add_product";
	}

	/**
	 * Displays products awaiting permission for a seller.
	 *
	 * @param session HTTP session
	 * @param request servlet request
	 * @return seller permission pending view
	 */
	@GetMapping("/seller_permission_pending")
	public String seller_permission_pending(HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("prod_edit") != null) {
			session.setAttribute("prod_edit", null);
		}
		Seller s = (Seller) session.getAttribute("seller");
		List<Product> prod_wo_perm = prepo.findBySeller_IdAndPerm(s.getId(), "NO");
		request.setAttribute("prod_Wo_perm", prod_wo_perm);
		return "seller_permission_pending";
	}

	/**
	 * Displays the seller home page with approved products.
	 *
	 * @param session HTTP session
	 * @param request servlet request
	 * @return seller home view
	 */
	@GetMapping("/sellerhome")
	public String sellerhome(HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("prod_edit_quant") != null) {
			session.setAttribute("prod_edit_quant", null);
		}
		Seller s = (Seller) session.getAttribute("seller");
		List<Product> prod_w_perm = prepo.findBySeller_IdAndPerm(s.getId(), "YES");
		request.setAttribute("prod_W_perm", prod_w_perm);
		return "sellerhome";
	}

}
