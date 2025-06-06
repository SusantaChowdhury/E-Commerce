<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="com.example.ecom.model.Seller" %>
        <%@page import="com.example.ecom.model.Product" %>
            <%@page import="java.util.List" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Edit Product Details</title>
                    <link rel="icon" href="/images/SwiftMart.ico" type="image/x-icon" />
                    <link rel="stylesheet" href="/css/output.css" />

                </head>

                <% Seller c=(Seller)session.getAttribute("seller"); String sellrname=c.getName(); String
                    sellrperm=c.getPerm(); %>



                    <body class="bg-gradient-to-b from-cyan-600 to-purple-950 text-white">
                        <!-- Navbar -->
                        <nav class="bg-gray-900 text-gray-100 px-4 shadow">
                            <div class="flex flex-wrap justify-between items-center py-2">
                                <!-- Logo -->
                                <a href="sellerhome" class="flex m-2 items-center space-x-3">
                                    <img src="/images/SwiftMart.png" class="h-14 rounded-xl shadow-lg"
                                        alt="SwiftMart Logo" />
                                    <span
                                        class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                                </a>

                                <!-- Navigation Links -->
                                <div class="flex gap-4 items-center text-sm sm:text-base">
                                    <a href="sellerhome" class="hover:text-cyan-400 font-medium transition">My
                                        Products</a>
                                    <a href="seller_permission_pending"
                                        class="hover:text-cyan-400 font-medium transition">Pending
                                        Permissions</a>
                                    <a href="seller_add_product" class="hover:text-cyan-400 font-medium transition">Add
                                        Product</a>

                                    <!-- User Dropdown -->
                                    <div class="relative inline-block text-left mr-2">
                                        <button id="dropdownButton" onclick="toggleDropdown()"
                                            class="h-12 w-12 flex items-center gap-2 px-4 py-2">
                                            <% String[] nameParts=sellrname.trim().split(" "); String initials = ""; for (String part : nameParts) { if (!part.isEmpty()) initials += part.charAt(0); } initials = initials.toUpperCase(); %>
                            <div class=" flex items-center justify-center rounded-full p-1 border-white border-3
                                                bg-cyan-400 text-gray-700 font-semibold text-2xl">
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
                        <h2 class="text-2xl font-bold text-center m-2 text-white">Edit Details of Pending Product</h2>
                        <!-- Main Content -->
                        <div class="flex justify-center px-4 py-10">
                            <div
                                class="w-full max-w-3xl bg-gray-800/40 backdrop-blur-xl border-b-4 border-gray-800 rounded-xl shadow-xl p-6 space-y-6">

                                <% Product x=(Product) session.getAttribute("prod_edit"); if (x==null) { %>
                                    <div class="text-center text-red-400 text-lg">No product selected for editing.
                                    </div>
                                    <% } else { int p_id=x.getId(); String p_name=x.getName(); String p_pd=x.getPd();
                                        Double p_price=x.getPrice(); int p_quant=x.getQuantity(); String
                                        pth=x.getImgp(); %>
                                        <form action="EdtProductSelr" enctype="multipart/form-data" method="post"
                                            class="space-y-6">
                                            <!-- Product Info Grid -->
                                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                                <!-- Product Image -->
                                                <div>
                                                    <label class="block text-sm font-medium text-gray-300 mb-2">Current
                                                        Product Image</label>
                                                    <img src="<%= pth %>" alt="Product Image"
                                                        class="rounded-lg w-full h-auto object-cover border border-gray-600" />
                                                </div>
                                                <div class="space-y-4">
                                                    <!-- Upload New Image -->
                                                    <div>
                                                        <label
                                                            class="block text-sm font-medium text-gray-300 mb-2">Upload
                                                            New Image</label>
                                                        <input type="file" name="product_image" accept="image/*" required
                                                        class="block w-full text-sm border file:w-26 file:p-1 file:bg-slate-900 file:m-1.5 file:rounded file:text-white hover:file:bg-slate-800 border-gray-400 rounded-md transition-all">
                                                        <p class="text-gray-400 text-xs mt-1">Accepted formats: .jpg,
                                                            .jpeg,
                                                            .png</p>
                                                    </div>

                                                    <div>
                                                        <label
                                                            class="block text-sm font-medium text-gray-300 mb-1">Product
                                                            Name</label>
                                                        <textarea type="text" name="prod_name" 
                                                            required
                                                            class="w-full px-4 py-2 rounded-md bg-gray-800 text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-indigo-500" /><%= p_name %></textarea>
                                                    </div>

                                                    <div>
                                                        <label
                                                            class="block text-sm font-medium text-gray-300 mb-1">Product
                                                            Price (₹)</label>
                                                        <input type="number" step="0.01" name="product_price"
                                                            value="<%= p_price %>" required
                                                            class="w-full px-4 py-2 rounded-md bg-gray-800 text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-indigo-500" />
                                                    </div>
                                                    <div>
                                                        <label
                                                            class="block text-sm font-medium text-gray-300 mb-1">Current
                                                            Quantity</label>
                                                        <input type="number" name="prod_quant" value="<%= p_quant %>"
                                                            required
                                                            class="w-full px-4 py-2 rounded-md bg-gray-800 text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-indigo-500" />
                                                    </div>
                                                </div>

                                            </div>


                                            <div class="space-y-2">
                                                <div>
                                                    <label class="block text-sm font-medium text-gray-300 mb-1">Product
                                                        Description</label>
                                                    <textarea name="product_pd" rows="2" required
                                                        class="w-full px-4 py-2 rounded-md bg-gray-800 text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-indigo-500"><%= p_pd %></textarea>
                                                </div>
                                            </div>

                                            <!-- Hidden ID -->
                                            <input type="hidden" name="prod_id" value="<%= p_id %>" />

                                            <!-- Submit Button -->
                                            <div class="">
                                                <button type="submit"
                                                    class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold px-6 py-3 rounded-md transition shadow-lg">
                                                    Update Product
                                                </button>
                                            </div>
                                        </form>

                                        <!-- Feedback Message -->
                                        <% String getm=String.valueOf(request.getAttribute("msg")); if
                                            (getm.equals("Success")) { %>
                                            <div class="text-green-400 text-center font-medium mt-4">
                                                ✅ Product updated successfully!
                                            </div>
                                            <% } else if (!getm.equals("null")) { %>
                                                <div class="text-red-500 text-center font-medium mt-4">
                                                    ⚠️ <%= getm %>
                                                </div>
                                                <% } %>

                                                    <% } %>
                            </div>
                        </div>
                        <!-- footer -->
                        <footer class="rounded-lg shadow-sm bg-gray-900 m-4">
                            <div class="w-full max-w-screen-xl mx-auto p-4 md:py-8">
                                <div class="sm:flex sm:items-center sm:justify-between">
                                    <a href="/sellerhome"
                                        class="flex items-center mb-4 sm:mb-0 space-x-3 rtl:space-x-reverse">
                                        <img src="images/SwiftMart.png" class="h-12 rounded-xl" alt="SwiftMart Logo" />
                                        <span
                                            class="self-center text-2xl font-semibold whitespace-nowrap text-white">SwiftMart™</span>
                                    </a>
                                    <ul
                                        class="flex flex-wrap items-center mb-6 text-sm font-medium text-gray-500 sm:mb-0 dark:text-gray-400">
                                        <li>
                                            <a href="#" class="hover:underline me-4 md:me-6">About</a>
                                        </li>
                                        <li>
                                            <a href="#" class="hover:underline me-4 md:me-6">Privacy
                                                Policy</a>
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
                                    2025
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
                        </script>
                    </body>


                </html>