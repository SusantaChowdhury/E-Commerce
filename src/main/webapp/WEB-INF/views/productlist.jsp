<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="com.example.ecom.model.Seller" %>
        <%@page import="com.example.ecom.model.Admin" %>
            <%@page import="com.example.ecom.model.Product" %>
                <%@page import="java.util.List" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <meta charset="UTF-8">
                        <title>ADMIN HOME</title>
                        <link rel="stylesheet" href="/css/output.css" />
                    </head>
                    <% Admin admi=(Admin)session.getAttribute("admin"); %>

                        <body class="bg-gradient-to-b from-cyan-600 to-purple-950 min-h-screen text-white font-sans">

                            <!-- Navbar -->
                            <nav class="bg-gray-900 w-full text-gray-100 px-4 shadow-md">
                                <div class="flex flex-wrap justify-between items-center py-4">
                                    <a href="adminhome" class="flex items-center space-x-3">
                                        <img src="/images/SwiftMart.png" class="h-14 rounded-2xl"
                                            alt="SwiftMart Logo" />
                                        <span
                                            class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                                    </a>
                                    <div class="flex flex-wrap justify-center sm:gap-12 items-center lg:gap-6 text-base font-medium mt-4 md:mt-0">
                                        <a href="adminhome" class="hover:text-cyan-500 transition">Active
                                            Sellers</a>
                                        <a href="passivesellers" class="hover:text-cyan-400 transition">Pending
                                            Sellers</a>
                                        <a href="customerlist" class="hover:text-cyan-400 transition">Customers</a>
                                        <a href="productlist" class="text-cyan-400 border-b-2">Products</a>
                                        <a href="orderslist" class="hover:text-cyan-400 transition">Orders</a>
                                        <!-- User Dropdown -->
                                        <div class="relative inline-block text-left mr-2">
                                            <button id="dropdownButton" onclick="toggleDropdown()"
                                                class="h-12 w-12 flex items-center gap-2 px-4 py-2">
                                                <% String[] nameParts=admi.getUsername().trim().split("",2); String
                                                    initials="" ; for (String part : nameParts) { if (!part.isEmpty())
                                                    initials +=part.charAt(0); } initials=initials.toUpperCase(); %>
                                                    <div class=" flex items-center justify-center rounded-full p-1 border-white border-3
                                                                        bg-cyan-400 text-gray-700 font-semibold
                                                                        text-2xl">
                                                        <%= initials %>
                                                    </div>

                                            </button>
                                            <!-- Dropdown -->
                                            <div id="dropdownMenu"
                                                class="absolute right-0 mt-2 w-40 bg-white rounded-md shadow-lg ring-1 ring-black ring-opacity-5 hidden z-50">
                                                <form action="Logout" method="post" class="py-1 text-gray-700">
                                                    <button type="submit"
                                                        class="block px-4 py-2 text-sm hover:bg-gray-100 w-full text-left">Logout</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </nav>

                            <!-- Message -->
                            <div class="text-center py-8 px-4">
                                <h2 class="text-3xl font-semibold">Here are the Products:</h2>
                            </div>

                            <!-- Product Section -->
                            <div class="px-6 md:px-12 py-8">
                                <% List<Product> perm_p = (List<Product>) request.getAttribute("prod_y_perm");
                                        if (perm_p.isEmpty()) { %>
                                        <p class="text-center text-xl mt-10 text-gray-200">No products available
                                            currently.</p>
                                        <% } else { %>

                                            <div
                                                class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                                                <% for (Product x : perm_p) { int pd=x.getId(); int
                                                    sd=x.getSeller().getId(); String p_name=x.getName(); String
                                                    p_pd=x.getPd(); Double p_price=x.getPrice(); int
                                                    qty=x.getQuantity(); String s_name=x.getSeller().getName(); String
                                                    path=x.getImgp(); %>

                                                    <div
                                                        class="bg-gray-800/50 backdrop:blur-xl border-b-4 border-gray-800 rounded-2xl shadow-md hover:shadow-xl hover:-translate-y-1 transition duration-300 p-4 flex flex-col">
                                                        <img src="<%= path %>" alt="Product <%= pd %>"
                                                            class="w-full h-auto object-cover rounded-xl mb-4">
                                                        <h3 class="text-lg font-semibold text-white truncate">
                                                            <%= p_name %>
                                                        </h3>
                                                        <p class="text-sm text-gray-300 mb-1 truncate">
                                                            <%= p_pd %>
                                                        </p>
                                                        <p class="text-sm text-gray-400">Remaining: <span
                                                                class="font-medium">
                                                                <%= qty %>
                                                            </span></p>
                                                        <p class="text-sm text-gray-400">Seller: <span
                                                                class="font-medium">
                                                                <%= s_name %>
                                                            </span></p>
                                                        <span class="text-cyan-400 font-semibold text-lg mt-2">₹<%=
                                                                p_price %></span>
                                                        <form action="Remadminprodperm" method="post" class="mt-4">
                                                            <input type="hidden" name="prodid" value="<%= pd %>">
                                                            <button type="submit"
                                                                class="w-full bg-red-600 hover:bg-red-700 text-white py-2 rounded-xl font-medium transition duration-300">
                                                                Unapprove
                                                            </button>
                                                        </form>
                                                    </div>

                                                    <% } %>
                                            </div>

                                            <% } %>
                            </div>

                            <!-- footer -->
                            <footer class="rounded-lg shadow-sm bg-gray-900 m-4">
                                <div class="w-full max-w-screen-xl mx-auto p-4 md:py-8">
                                    <div class="sm:flex sm:items-center sm:justify-between">
                                        <a href="/sellerhome"
                                            class="flex items-center mb-4 sm:mb-0 space-x-3 rtl:space-x-reverse">
                                            <img src="images/SwiftMart.png" class="h-12 rounded-xl"
                                                alt="SwiftMart Logo" />
                                            <span
                                                class="self-center text-2xl font-semibold whitespace-nowrap text-white">SwiftMart™</span>
                                        </a>
                                        <ul
                                            class="flex flex-wrap items-center mb-6 text-sm font-medium text-gray-500 sm:mb-0 dark:text-gray-400">
                                            <li>
                                                <a href="#" class="hover:underline me-4 md:me-6">About</a>
                                            </li>
                                            <li>
                                                <a href="#" class="hover:underline me-4 md:me-6">Privacy Policy</a>
                                            </li>
                                            <li>
                                                <a href="#" class="hover:underline me-4 md:me-6">Licensing</a>
                                            </li>
                                            <li>
                                                <a href="#" class="hover:underline">Contact</a>
                                            </li>
                                        </ul>
                                    </div>
                                    <hr class="my-6 border-gray-200 sm:mx-auto dark:border-gray-700 lg:my-8" />
                                    <span class="block text-sm text-gray-500 sm:text-center dark:text-gray-400">© 2025
                                        <a href="https://flowbite.com/" class="hover:underline">SwiftMart™</a>. All
                                        Rights Reserved.</span>
                                </div>
                            </footer>
                            <script>
                                setInterval(function () {
                                    location.reload();
                                }, 5000);
                            </script>
                        </body>

                    </html>