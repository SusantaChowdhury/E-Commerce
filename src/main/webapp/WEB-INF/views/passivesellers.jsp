<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="com.example.ecom.model.Admin" %>
        <%@page import="com.example.ecom.model.Seller" %>
            <%@page import="java.util.List" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Passive Sellers</title>
                    <link rel="icon" href="/images/SwiftMart.ico" type="image/x-icon" />
                    <link rel="stylesheet" href="/css/output.css" />
                </head>
                <% Admin admi=(Admin)session.getAttribute("admin"); %>

                    <body class="bg-gradient-to-b from-cyan-600 to-purple-950 min-h-screen text-white font-sans">
                        <!-- Navbar -->
                        <nav class="bg-gray-900 w-full text-gray-100 px-4 shadow-md">
                            <div class="flex flex-wrap justify-between items-center py-2">
                                <a href="adminhome" class="flex m-4 items-center space-x-3 rtl:space-x-reverse">
                                    <img src="/images/SwiftMart.png" class="h-16 rounded-2xl" alt="SwiftMart Logo" />
                                    <span
                                        class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                                </a>
                                <div
                                    class="flex flex-wrap justify-center items-center lg:gap-6 sm:gap-8 text-lg font-medium p-2">
                                    <a href="adminhome" class="hover:text-cyan-400 transition">Active
                                        Sellers</a>
                                    <a href="passivesellers" class="text-cyan-400 border-b-2">Pending Sellers</a>
                                    <a href="customerlist" class="hover:text-cyan-400 transition">Customers</a>
                                    <a href="productlist" class="hover:text-cyan-400 transition">Products</a>
                                    <a href="orderslist" class="hover:text-cyan-400 transition">Orders</a>
                                    <!-- User Dropdown -->
                                    <div class="relative inline-block text-left mr-2">
                                        <button id="dropdownButton" onclick="toggleDropdown()"
                                            class="h-12 w-12 flex items-center gap-2 px-4 mr-2 py-2">
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
                            <h2 class="text-2xl font-semibold py-2 border-b">The Pending Sellers</h2>
                        </div>
                        <!-- Seller Cards -->
                        <div class="max-w-7xl mx-auto px-4 pb-12">
                            <% List<Seller> perm_pd = (List<Seller>) request.getAttribute("nonperm_seller");
                                    if (perm_pd == null || perm_pd.isEmpty()) { %>
                                    <div class="text-center text-xl text-gray-100">No pending sellers found.</div>
                                    <% } else { %>
                                        <div
                                            class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                                            <% for (Seller x : perm_pd) { String p_name=x.getName(); String
                                                p_id=String.valueOf(x.getId()); String p_mail=x.getEmail(); %>
                                                <div
                                                    class="bg-gray-800/50 backdrop-blur-xl border-b-4 border-gray-800 rounded-xl shadow-lg p-5 text-gray-200 flex flex-col justify-between">
                                                    <div>
                                                        <h3 class="text-xl font-semibold mb-1">
                                                            <%= p_name %>
                                                        </h3>
                                                        <p class="text-sm text-gray-300 mb-2">
                                                            <%= p_mail %>
                                                        </p>
                                                        <span
                                                            class="text-xs font-medium bg-yellow-100 text-yellow-800 px-2 py-1 rounded">Seller
                                                            ID: <%= p_id %></span>
                                                    </div>
                                                    <div class="mt-4 flex flex-col sm:flex-row gap-2">
                                                        <form action="seller_det" method="post" class="w-full">
                                                            <input type="hidden" name="sellr_id" value="<%= p_id %>">
                                                            <input type="hidden" name="page" value="passivesellers">
                                                            <button type="submit"
                                                                class="w-full bg-cyan-600 hover:bg-cyan-700 text-white py-2 px-3 rounded transition duration-200">
                                                                Details
                                                            </button>
                                                        </form>
                                                        <form action="Givsellerperm" method="post" class="w-full">
                                                            <input type="hidden" name="sellr_id" value="<%= p_id %>">
                                                            <button type="submit"
                                                                class="w-full bg-green-600 hover:bg-green-700 text-white py-2 px-3 rounded transition duration-200">
                                                                Approve
                                                            </button>
                                                        </form>
                                                    </div>
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
                                        <img src="images/SwiftMart.png" class="h-12 rounded-xl" alt="SwiftMart Logo" />
                                        <span
                                            class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-2xl text-transparent font-semibold whitespace-nowrap">SwiftMart™</span>
                                    </a>
                                    <ul
                                        class="flex flex-wrap items-center mb-6 text-sm font-medium text-gray-500 sm:mb-0 dark:text-gray-400">
                                        <li>
                                            <a href="aboutus" class="hover:underline me-4 md:me-6">About</a>
                                        </li>
                                        <li>
                                            <a href="contactus" class="hover:underline me-4 md:me-6">Contact</a>
                                        </li>
                                        <li>
                                            <a href="#" class="hover:underline me-4 md:me-6">Privacy Policy</a>
                                        </li>
                                        <li>
                                            <a href="#" class="hover:underline">Licensing</a>
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