<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="com.example.ecom.model.Admin" %>
        <%@page import="com.example.ecom.model.Customer" %>
            <%@page import="java.util.List" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Customers List</title>
                    <link rel="stylesheet" href="/css/output.css" />
                </head>
                <% Admin admi=(Admin)session.getAttribute("admin"); %>

                    <body class="bg-gradient-to-b from-cyan-600 to-purple-950 min-h-screen text-white font-sans">
                        <!-- Navbar -->
                        <nav class="bg-gray-900 w-full text-gray-100 px-4 shadow-md">
                            <div class="flex flex-wrap justify-between items-center py-4">
                                <a href="adminhome" class="flex items-center space-x-3">
                                    <img src="/images/SwiftMart.png" class="h-14 rounded-2xl" alt="SwiftMart Logo" />
                                    <span
                                        class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                                </a>
                                <div class="flex flex-wrap justify-center gap-4 text-base font-medium mt-4 md:mt-0">
                                    <a href="adminhome" class="hover:text-cyan-500 transition">Active
                                        Sellers</a>
                                    <a href="passivesellers" class="hover:text-cyan-400 transition">Pending Sellers</a>
                                    <a href="customerlist" class="text-cyan-400 border-b-2">Customers</a>
                                    <a href="productlist" class="hover:text-cyan-400 transition">Products</a>
                                    <a href="orderslist" class="hover:text-cyan-400 transition">Orders</a>
                                </div>
                            </div>
                        </nav>

                        <!-- Message -->
                        <div class="text-center py-8 px-4">
                            <h2 class="text-3xl font-semibold">Here are the Customers:</h2>
                        </div>
                        <!-- Customer List Section -->
                        <div class="px-6 pb-12">
                            <% List<Customer> customers = (List<Customer>)request.getAttribute("allcust");
                                    if(customers.isEmpty()) {
                                    %>
                                    <p class="text-center text-lg font-medium text-white">No customers found at the
                                        moment.</p>
                                    <% } else { %>
                                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                                            <% for(Customer x : customers) { String name=x.getName(); String
                                                id=String.valueOf(x.getId()); String email=x.getEmail(); %>
                                                <div
                                                    class="bg-gray-800/50 backdrop-blur-lg border-b-4 border-gray-800 rounded-xl p-6 shadow-xl hover:shadow-2xl hover:-translate-y-1 transition duration-300">
                                                    <h3 class="text-xl font-semibold text-white mb-2">
                                                        <%=name%>
                                                    </h3>
                                                    <p class="text-gray-300 mb-1">
                                                        <%=email%>
                                                    </p>
                                                    <span class="text-sm text-gray-400 block mb-4">Customer ID: <%=id%>
                                                    </span>
                                                    <form action="customer_det" method="post">
                                                        <input type="hidden" name="cust_id" value="<%=id%>">
                                                        <input type="hidden" name="page" value="passivesellers">
                                                        <button type="submit"
                                                            class="bg-cyan-500 text-white font-semibold px-4 py-2 rounded-md shadow-xl hover:bg-cyan-600 hover:shadow-2xl transition-all duration-500 ease-in-out">
                                                            View Details
                                                        </button>
                                                    </form>
                                                </div>
                                                <% } %>
                                        </div>
                                        <% } %>
                        </div>

                        <!-- footer -->
                        <footer class="rounded-lg shadow-sm bg-gray-900/70 backdrop-blur-xl m-4">
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