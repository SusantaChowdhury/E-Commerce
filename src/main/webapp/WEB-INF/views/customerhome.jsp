<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="com.example.ecom.model.Seller" %>
        <%@page import="com.example.ecom.model.Product" %>
            <%@page import="com.example.ecom.model.Customer" %>
                <%@page import="java.util.List" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <meta charset="UTF-8">
                        <title>Welcome to SwiftKart™</title>
                        <link rel="icon" href="/images/SwiftMart.ico" type="image/x-icon" />
                        <link rel="stylesheet" href="/css/output.css" />
                    </head>
                    <% Customer c=(Customer)session.getAttribute("customer"); int custid=c.getId(); String
                        custname=c.getName(); %>

                        <body class="bg-gradient-to-b from-cyan-600 to-purple-950 min-h-screen text-white font-sans">
                            <!-- Navbar -->
                            <nav class="bg-gray-900 text-gray-100 px-4 shadow">
                                <div class="flex flex-wrap justify-between items-center py-2">
                                    <!-- Logo -->
                                    <a href="customerhome" class="flex m-2 items-center space-x-3">
                                        <img src="/images/SwiftMart.png" class="h-14 rounded-xl shadow-lg"
                                            alt="SwiftMart Logo" />
                                        <span class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                                    </a>

                                    <!-- Navigation Links -->
                                    <div class="flex gap-4 items-center text-sm sm:text-base">
                                        <a href="customerhome"
                                            class="text-cyan-400 border-b-2 font-medium transition">Products</a>
                                        <a href="custcart" class=" hover:text-cyan-400 font-medium transition">Cart</a>
                                        <a href="custordrhist" class=" hover:text-cyan-400 font-medium transition">Orders</a>

                                        <!-- User Dropdown -->
                                        <div class="relative inline-block text-left mr-2">
                                            <button id="dropdownButton" onclick="toggleDropdown()"
                                                class="h-12 w-12 flex items-center gap-2 px-4 py-2">
                                                <% String[] nameParts=custname.trim().split(" "); String initials = ""; for (String part : nameParts) { if (!part.isEmpty()) initials += part.charAt(0); } initials = initials.toUpperCase(); %>
                            <div class=" flex items-center justify-center rounded-full p-1 border-white border-3
                                                    bg-cyan-400 text-gray-700 font-semibold text-2xl">
                                                    <%= initials %>
                                        </div>
                                        <!-- <span class="hidden text-white font-medium">
                                            <%= custname %>
                                        </span> -->
                                        <!-- <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor"
                                            stroke-width="2" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7">
                                            </path>
                                        </svg> -->
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

                            <!-- Greeting -->
                            <div class="text-3xl font-bold my-6 text-center text-gray-100">
                                <h1>Welcome, <%= custname %>!</h1>
                                <p class="text-lg text-gray-300">Explore our products and enjoy shopping!</p>
                            </div>

                            <!-- Products Grid -->
                            <div class="px-6 pb-16">
                                <% List<Product> perm_p = (List<Product>) request.getAttribute("prod_y_perm");
                                        if (perm_p.isEmpty()) { %>
                                        <div class="text-center text-gray-600 mt-10 text-lg font-medium">No products
                                            available right now.</div>
                                        <% } else { %>
                                            <section
                                                class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-10">
                                                <% for (Product x : perm_p) { int pd=x.getId(); int
                                                    sd=x.getSeller().getId(); String p_name=x.getName(); String
                                                    p_pd=x.getPd(); Double p_price=x.getPrice(); int
                                                    qty=x.getQuantity(); String s_name=x.getSeller().getName(); String
                                                    path=x.getImgp(); %>

                                                    <!-- Product Card -->
                                                    <div
                                                        class="bg-gray-800/50 backdrop:blur-xl border-gray-800 border-b-4 mb-0 rounded-xl shadow-xl hover:shadow-2xl hover:-translate-y-1 hover:bg-gray-800/60 transition-all duration-300 overflow-hidden">
                                                        <img src="<%= path %>" alt="Product <%= pd %>"
                                                            class="w-full h-auto object-cover p-4">
                                                        <div class="p-4 space-y-2">
                                                            <h3 class="text-lg font-semibold text-gray-100">
                                                                <%= p_name %>
                                                            </h3>
                                                            <p class="text-gray-400 text-sm">
                                                                <%= p_pd %>
                                                            </p>
                                                            <p class="text-gray-300 text-sm">Remaining: <%= qty %>
                                                            </p>
                                                            <p class="text-gray-300 text-sm">Seller: <%= s_name %>
                                                            </p>
                                                            <p class="text-xl font-bold text-amber-400">₹<%= p_price %>
                                                            </p>

                                                            <div class="w-full flex gap-4 mt-2 justify-center">
                                                                <form action="Addcart" method="post">
                                                                    <input type="hidden" name="product_id"
                                                                        value="<%= pd %>">
                                                                    <button type="submit"
                                                                        class="w-full bg-blue-600 hover:bg-blue-700 text-white py-2 px-3 rounded-md text-sm font-medium transition duration-300">
                                                                        Add to Cart
                                                                    </button>
                                                                </form>

                                                                <% if (qty> 0) { %>
                                                                    <form action="Buynowsingle" method="post"
                                                                        class="w-1/2">
                                                                        <input type="hidden" name="product_id"
                                                                            value="<%= pd %>">
                                                                        <button type="submit"
                                                                            class="w-full bg-green-600 hover:bg-green-700 text-white py-2 px-3 rounded-md text-sm font-medium transition duration-300">
                                                                            Buy Now
                                                                        </button>
                                                                    </form>
                                                                    <% } %>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <% } %>
                                            </section>
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
                                    <span class="block text-sm text-gray-500 sm:text-center dark:text-gray-400">©
                                        2023
                                        <a href="https://flowbite.com/" class="hover:underline">SwiftMart™</a>. All
                                        Rights Reserved.</span>
                                </div>
                            </footer>
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