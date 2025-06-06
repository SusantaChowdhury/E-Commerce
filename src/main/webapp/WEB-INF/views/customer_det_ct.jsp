<%@page import="com.example.ecom.model.Orderprod" %>
    <%@page import="com.example.ecom.model.Orderhist" %>
        <%@page import="com.example.ecom.model.Customer" %>
            <%@page import="com.example.ecom.model.Product" %>
                <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                    <%@page import="com.example.ecom.model.Seller" %>
                        <%@page import="com.example.ecom.model.Admin" %>
                            <%@page import="java.util.List" %>
                                <!DOCTYPE html>
                                <html>

                                <head>
                                    <meta charset="UTF-8">
                                    <title>Customer Details</title>
                                    <link rel="stylesheet" href="/css/output.css" />
                                </head>
                                <% Admin admi=(Admin)session.getAttribute("admin"); Customer
                                    s=(Customer)session.getAttribute("custinfo"); List<Orderprod> op=(List<Orderprod>
                                        )request.getAttribute("cartofcust");
                                        %>

                                        <body
                                            class="bg-gradient-to-b from-cyan-600 to-purple-950 min-h-screen text-white font-sans">
                                            <!-- Navbar -->
                                            <nav class="bg-gray-900 w-full text-gray-100 px-4 shadow-md">
                                                <div class="flex flex-wrap justify-between items-center py-4">
                                                    <a href="adminhome" class="flex items-center space-x-3">
                                                        <img src="/images/SwiftMart.png" class="h-14 rounded-2xl"
                                                            alt="SwiftMart Logo" />
                                                        <span
                                                            class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                                                    </a>
                                                    <div class="flex justify-around gap-[10vw] text-base font-medium">
                                                        <div class="flex flex-row justify-center items-center ">
                                                            <a href="customerlist"
                                                                class="hover:text-cyan-400 transition">←
                                                                Back to
                                                                Customers
                                                            </a>
                                                        </div>
                                                        <div class="flex flex-row justify-center items-center gap-4">
                                                            <a href="customer_det_oh"
                                                                class="hover:text-cyan-400 transition">Orders</a>
                                                            <a href="customer_det_ct"
                                                                class="text-cyan-400 border-b-2">Cart</a>
                                                            <!-- User Dropdown -->
                                                            <div class="relative inline-block text-left mr-2">
                                                                <button id="dropdownButton" onclick="toggleDropdown()"
                                                                    class="h-12 w-12 flex items-center gap-2 px-4 py-2">
                                                                    <% String[]
                                                                        nameParts=admi.getUsername().trim().split("",2); String initials = ""; for (String part : nameParts) { if (!part.isEmpty()) initials += part.charAt(0); } initials = initials.toUpperCase(); %>
                            <div class=" flex items-center justify-center rounded-full p-1 border-white border-3
                                                                        bg-cyan-400 text-gray-700 font-semibold
                                                                        text-2xl">
                                                                        <%= initials %>
                                                            </div>
                                                            
                                                            </button>
                                                            <!-- Dropdown -->
                                                            <div id="dropdownMenu"
                                                                class="absolute right-0 mt-2 w-40 bg-white rounded-md shadow-lg ring-1 ring-black ring-opacity-5 hidden z-50">
                                                                <form action="Logout" method="post"
                                                                    class="py-1 text-gray-700">
                                                                    <button type="submit"
                                                                        class="block px-4 py-2 text-sm hover:bg-gray-100 w-full text-left">Logout</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </nav>

                                            <!-- customer Details -->
                                            <div
                                                class="bg-gray-900 rounded-2xl shadow-lg p-6 mt-6 text-gray-100 w-full max-w-3xl mx-auto">
                                                <h3
                                                    class="text-2xl font-bold text-cyan-400 mb-4 flex items-center gap-2">
                                                    <img src="/images/user.svg" alt="Seller Icon"
                                                        class="h-14 w-14 inline-block shadow-gray-500 rounded-full shadow-md m-2">
                                                    Customer Information
                                                </h3>

                                                <div
                                                    class="grid grid-cols-1  md:grid-cols-2 gap-6 text-sm sm:text-base">
                                                    <div>
                                                        <p class="mb-1 text-gray-400">Name:</p>
                                                        <p class="text-white font-medium">
                                                            <%= s.getName() %>
                                                        </p>
                                                    </div>
                                                    <div>
                                                        <p class="mb-1 text-gray-400">Email:</p>
                                                        <p class="text-white font-medium">
                                                            <%= s.getEmail() %>
                                                        </p>
                                                    </div>
                                                    <div>
                                                        <p class="mb-1 text-gray-400">Customer ID:</p>
                                                        <p class="text-white font-medium">#<%= s.getId() %>
                                                        </p>
                                                    </div>

                                                </div>
                                            </div>


                                            <h2
                                                class="text-2xl font-bold text-cyan-400 mb-6 border-b border-cyan-500 pb-2">
                                                Cart of <%= s.getName()%>
                                            </h2>

                                            <div class="">
                                                <div class="">
                                                    <section class="">
                                                        <% if(op.isEmpty()){ %>
                                                            No objects present now
                                                            <% }else{ double total=0.0; int nobuy=0; for(Orderprod x:
                                                                op) { int oid=x.getId(); String
                                                                p_name=x.getProduct().getName(); String
                                                                p_pd=x.getProduct().getPd(); Double
                                                                p_price=x.getProduct().getPrice(); int
                                                                avlqty=x.getProduct().getQuantity(); int
                                                                bqty=x.getQty(); String
                                                                s_name=x.getProduct().getSeller().getName(); String
                                                                s_mail=x.getProduct().getSeller().getEmail(); int
                                                                s_id=x.getProduct().getSeller().getId(); Double
                                                                cost=p_price*bqty; total+=cost; String
                                                                path=x.getProduct().getImgp(); %>
                                                                <div class="cart-item">
                                                                    <img src="<%=path%>" alt="Order <%=oid%>" />

                                                                    <div class="cart-name-price">
                                                                        <h2>
                                                                            <%=p_name%>
                                                                        </h2>
                                                                        <p class="price">Order Id<%=oid%>
                                                                        </p>
                                                                        <p class="price">₹<%=cost%>
                                                                        </p>
                                                                    </div>

                                                                    <div class="cart-description">
                                                                        <p>
                                                                            <%=p_pd%>
                                                                        </p>
                                                                        <p class="seller-info">Seller: <%=s_name%>
                                                                        </p>
                                                                        <p class="seller-info">Seller Id: <%=s_id%>
                                                                        </p>
                                                                        <p class="seller-info">Seller mail: <%=s_mail%>
                                                                        </p>
                                                                    </div>
                                                                    <div class="cart-description">
                                                                        <p class="seller-info">Customer:
                                                                            <%=x.getCustomer().getName()%>
                                                                        </p>
                                                                        <p class="seller-info">Customer Id:
                                                                            <%=x.getCustomer().getId()%>
                                                                        </p>
                                                                        <p class="seller-info">Customer mail:
                                                                            <%=x.getCustomer().getEmail()%>
                                                                        </p>
                                                                    </div>
                                                                    <div class="cart-description">
                                                                        <p class="stock-info">Available: <%=avlqty%>
                                                                        </p>
                                                                        <p class="stock-info">Price: ₹<%=p_price%>
                                                                        </p>
                                                                        <p class="stock-info">Buying Quantity: ₹
                                                                            <%=bqty%>
                                                                        </p>
                                                                    </div>

                                                                    <% if(avlqty==0){ String
                                                                        prodmsg="Cannot buy this item" ; %>
                                                                        <div class="cart-description">
                                                                            <p class="stock-info">
                                                                                <%=prodmsg%>
                                                                            </p>
                                                                        </div>

                                                                        <% } else if(bqty>avlqty){
                                                                            String prodmsg="Can't buy this quantity";
                                                                            %>
                                                                            <div class="cart-description">
                                                                                <p class="stock-info">
                                                                                    <%=prodmsg%>
                                                                                </p>
                                                                            </div>

                                                                            <% } else{ %>
                                                                                <div class="cart-description">
                                                                                    <p class="stock-info"> </p>
                                                                                </div>
                                                                                <% } %>

                                                                </div>
                                                                <%} } %>
                                                    </section>
                                                </div>
                                            </div>
                                            <script>
                                                function toggleDropdown() {
                                                    const menu = document.getElementById('dropdownMenu');
                                                    menu.classList.toggle('hidden');
                                                }

                                                // Close dropdown if clicked outside
                                                window.addEventListener('click', function (e) {
                                                    const dropdownButton = document.getElementById('dropdownButton');
                                                    const dropdownMenu = document.getElementById('dropdownMenu');
                                                    if (!dropdownButton.contains(e.target)) {
                                                        dropdownMenu.classList.add('hidden');
                                                    }
                                                });

                                                setInterval(function () {
                                                    location.reload();
                                                }, 5000);
                                            </script>
                                        </body>

                                </html>