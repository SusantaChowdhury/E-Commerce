<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="com.example.ecom.model.Seller" %>
        <%@page import="com.example.ecom.model.Admin" %>
            <%@page import="java.util.List" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>ADMIN HOME</title>
                    <link rel="stylesheet" href="css/output.css" />
                </head>
                <% Admin admi=(Admin)session.getAttribute("admin"); %>

                    <body class="bg-gradient-to-b from-cyan-600 to-purple-950 min-h-screen text-white font-sans">
                        <!-- navbar -->
                        <nav class="bg-gray-900 w-full text-gray-100 px-4">

                            <div class="flex flex-wrap justify-between items-center my-2">
                                <a href="adminhome.jsp" class="flex m-4 items-center space-x-3 rtl:space-x-reverse">
                                    <img src="/images/SwiftMart.png" class="h-16 rounded-2xl" alt="SwiftMart Logo" />
                                    <span
                                        class="self-center text-2xl font-semibold whitespace-nowrap text-white">SwiftMart™</span>
                                </a>
                                <div class="flex justify-center items-center text-lg font-medium gap-3 mb-2">
                                    <a href="adminhome" class="px-2 text-cyan-500">Active Sellers</a>
                                    <a href="passivesellers" class="px-2 hover:text-cyan-500">Pending Sellers</a>
                                    <a href="customerlist" class="px-2 hover:text-cyan-500">Customers</a>
                                    <a href="productlist" class="px-2 hover:text-cyan-500">Products</a>
                                    <a href="orderslist" class="px-2 hover:text-cyan-500">Orders</a>
                                </div>
                            </div>
                        </nav>

                        <!-- Welcome Header -->
                        <div class="text-center py-6">
                            <h2 class="text-3xl font-semibold">Welcome, Admin <%= admi.getUsername() %> 👋</h2>
                            <p class="text-lg text-gray-200 mt-2">Here are your active sellers:</p>
                        </div>

                        <!-- Seller List Section -->
                        <div class="max-w-7xl mx-auto px-4 pb-12">
                            <% List<Seller> perm_pd = (List<Seller>) request.getAttribute("perm_seller");
                                    if (perm_pd == null || perm_pd.isEmpty()) {
                                    %>
                                    <div class="text-center text-xl text-gray-100">No active sellers found.</div>
                                    <% } else { %>
                                        <div
                                            class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                                            <% for (Seller x : perm_pd) { String p_name=x.getName(); String
                                                p_id=String.valueOf(x.getId()); String p_mail=x.getEmail(); %>
                                                <div
                                                    class="bg-white rounded-xl shadow-lg p-5 text-gray-800 flex flex-col justify-between">
                                                    <div>
                                                        <h3 class="text-xl font-semibold mb-1">
                                                            <%= p_name %>
                                                        </h3>
                                                        <p class="text-sm text-gray-600 mb-2">
                                                            <%= p_mail %>
                                                        </p>
                                                        <span
                                                            class="text-xs font-medium bg-cyan-100 text-cyan-800 px-2 py-1 rounded">Seller
                                                            ID: <%= p_id %></span>
                                                    </div>
                                                    <div class="mt-4 flex gap-2">
                                                        <form action="seller_det" method="post">
                                                            <input type="hidden" name="sellr_id" value="<%= p_id %>">
                                                            <input type="hidden" name="page" value="adminhome">
                                                            <button type="submit"
                                                                class="w-full bg-cyan-600 hover:bg-cyan-700 text-white py-1.5 px-3 rounded transition duration-200">
                                                                Details
                                                            </button>
                                                        </form>
                                                        <form action="Remsellerperm" method="post">
                                                            <input type="hidden" name="sellr_id" value="<%= p_id %>">
                                                            <button type="submit"
                                                                class="w-full bg-red-600 hover:bg-red-700 text-white py-1.5 px-3 rounded transition duration-200">
                                                                Unapprove
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                                <% } %>
                                        </div>
                                        <% } %>
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
                        </script>
                    </body>

                </html>