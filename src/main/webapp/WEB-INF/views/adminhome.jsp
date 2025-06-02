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

                        <!-- Navbar -->
                        <nav class="bg-gray-900 w-full text-gray-100 px-4 shadow-md">
                            <div class="flex flex-wrap justify-between items-center py-4">
                                <a href="adminhome.jsp" class="flex items-center space-x-3">
                                    <img src="/images/SwiftMart.png" class="h-14 rounded-2xl" alt="SwiftMart Logo" />
                                    <span class="text-2xl font-bold text-white">SwiftMart™</span>
                                </a>
                                <div class="flex flex-wrap justify-center gap-4 text-base font-medium mt-4 md:mt-0">
                                    <a href="adminhome" class="text-cyan-400 border-b-2">Active
                                        Sellers</a>
                                    <a href="passivesellers" class="hover:text-cyan-400 transition">Pending Sellers</a>
                                    <a href="customerlist" class="hover:text-cyan-400 transition">Customers</a>
                                    <a href="productlist" class="hover:text-cyan-400 transition">Products</a>
                                    <a href="orderslist" class="hover:text-cyan-400 transition">Orders</a>
                                </div>
                            </div>
                        </nav>

                        <!-- Welcome Header -->
                        <header class="text-center py-8 px-4">
                            <h2 class="text-3xl font-semibold">Welcome, Admin <%= admi.getUsername() %> 👋</h2>
                            <p class="text-lg text-gray-200 mt-2">Here are your active sellers:</p>
                        </header>

                        <!-- Seller Grid -->
                        <main class="max-w-7xl mx-auto px-4 pb-16">
                            <% List<Seller> perm_pd = (List<Seller>) request.getAttribute("perm_seller");
                                    if (perm_pd == null || perm_pd.isEmpty()) {
                                    %>
                                    <div class="text-center text-xl text-white font-medium mt-8">
                                        No active sellers found.
                                    </div>
                                    <% } else { %>
                                        <div
                                            class="grid gap-6 grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
                                            <% for (Seller x : perm_pd) { String p_name=x.getName(); String
                                                p_id=String.valueOf(x.getId()); String p_mail=x.getEmail(); %>
                                                <div
                                                    class="bg-gray-800/50 backdrop:blur-xl border-b-4 border-gray-800 rounded-xl shadow-xl p-6 flex flex-col justify-between text-gray-200 hover:shadow-2xl hover:-translate-y-1 transition">
                                                    <div>
                                                        <h3 class="text-xl font-semibold mb-1">
                                                            <%= p_name %>
                                                        </h3>
                                                        <p class="text-sm text-gray-300 mb-2">
                                                            <%= p_mail %>
                                                        </p>
                                                        <span
                                                            class="inline-block bg-cyan-100 text-cyan-800 text-xs font-semibold px-3 py-1 rounded-full">
                                                            Seller ID: <%= p_id %>
                                                        </span>
                                                    </div>
                                                    <div class="mt-4 flex flex-col gap-2">
                                                        <form action="seller_det" method="post" class="w-full">
                                                            <input type="hidden" name="sellr_id" value="<%= p_id %>">
                                                            <input type="hidden" name="page" value="adminhome">
                                                            <button type="submit"
                                                                class="w-full bg-cyan-600 hover:bg-cyan-700 text-white py-2 rounded-lg transition">
                                                                View Details
                                                            </button>
                                                        </form>
                                                        <form action="Remsellerperm" method="post" class="w-full">
                                                            <input type="hidden" name="sellr_id" value="<%= p_id %>">
                                                            <button type="submit"
                                                                class="w-full bg-red-600 hover:bg-red-700 text-white py-2 rounded-lg transition">
                                                                Unapprove
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                                <% } %>
                                        </div>
                                        <% } %>
                        </main>

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
                                <span class="block text-sm text-gray-500 sm:text-center dark:text-gray-400">© 2023
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