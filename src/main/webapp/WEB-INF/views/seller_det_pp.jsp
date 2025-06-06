<%@page import="com.example.ecom.model.Product" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@page import="com.example.ecom.model.Seller" %>
            <%@page import="com.example.ecom.model.Admin" %>
                <%@page import="java.util.List" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <meta charset="UTF-8">
                        <title>Seller Details</title>
                        <link rel="stylesheet" href="/css/output.css" />
                    </head>
                    <% Admin admi=(Admin)session.getAttribute("admin"); String
                        retpage=(String)session.getAttribute("page"); Seller
                        s=(Seller)session.getAttribute("sellerinfo"); List<Product> plist=(List<Product>
                            )request.getAttribute("nonpermprodfsid");
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
                                        <div
                                            class="flex flex-wrap justify-center gap-4 text-base font-medium mt-4 md:mt-0">
                                            <a href="adminhome" class="hover:text-cyan-500 transition">Active
                                                Sellers</a>
                                            <a href="passivesellers" class="text-cyan-400 border-b-2">Pending
                                                Sellers</a>
                                            <a href="customerlist" class="hover:text-cyan-400 transition">Customers</a>
                                            <a href="productlist" class="hover:text-cyan-400 transition">Products</a>
                                            <a href="orderslist" class="hover:text-cyan-400 transition">Orders</a>
                                        </div>
                                    </div>
                                </nav>



                                <div class="max-w-7xl mx-auto mt-6 px-4">

                                    <!-- seller Details -->
                                    <div
                                        class="bg-gray-900 rounded-2xl shadow-lg p-6 mt-6 text-gray-100 w-full max-w-3xl mx-auto">
                                        <h3 class="text-2xl font-bold text-cyan-400 mb-4 flex items-center gap-2">
                                            <img src="/images/user.svg" alt="Seller Icon"
                                                class="h-14 w-14 inline-block shadow-gray-500 rounded-full shadow-md m-2">
                                            Seller Information
                                        </h3>


                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 text-sm sm:text-base">
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
                                                <p class="mb-1 text-gray-400">Seller ID:</p>
                                                <p class="text-white font-medium">#<%= s.getId() %>
                                                </p>
                                            </div>
                                            <div>
                                                <p class="mb-1 text-gray-400">Permission Status:</p>
                                                <p class="text-white font-medium">
                                                    <%if(s.getPerm().equals("YES")){%>
                                                        <span
                                                            class="text-green-700 bg-green-200 border-green-400 border-2 px-2 py-1 rounded-full">
                                                            Approved</span>
                                                        <%}else{%>
                                                            <span
                                                                class="text-red-700 bg-red-200 border-red-400 border-2 px-2 py-1 rounded-full">
                                                                Unapproved</span>
                                                            <%}%>
                                                </p>
                                            </div>
                                            <div class="md:col-span-2">
                                                <p class="mb-1 text-gray-400">Documents:</p>
                                                <a href="<%= s.getDocs() %>" target="_blank"
                                                    class="inline-block text-cyan-400 font-semibold hover:underline hover:text-cyan-300 transition">
                                                    <img src="/images/documents.svg"
                                                        class="h-14 w-14 inline-block shadow-gray-500"> View Submitted
                                                    PDF
                                                </a>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Seller Controls -->
                                    <div
                                        class="bg-gray-900/60 mt-6 rounded-lg px-5 py-4 flex flex-wrap justify-between items-center shadow-sm text-sm font-medium">
                                        <a href="<%= retpage %>" class="text-cyan-300 hover:text-cyan-400">← Back</a>
                                        <div class="flex gap-4 mt-4 md:mt-0">
                                            <a href="seller_det_sp"
                                                class="bg-slate-700 px-2 py-2 rounded hover:text-cyan-400">Selling
                                                Products</a>
                                            <a href="seller_det_pp"
                                                class="bg-slate-700 border-gray-400 border-1 px-2 py-2 rounded text-cyan-400">Pending
                                                Permission</a>
                                        </div>
                                    </div>

                                    <!-- Pending Permission Products Section -->
                                    <div class="mt-10">
                                        <h2 class="text-2xl font-bold text-cyan-400 mb-6 border-b border-cyan-500 pb-2">
                                            Pending Products for Approval</h2>

                                        <% if(plist.isEmpty()) { %>
                                            <div class="text-center text-lg text-gray-300">
                                                <div
                                                    class="flex flex-col justify-center items-center bg-gray-800/40 backdrop-blur-md rounded-lg m-4">
                                                    <img src="/images/empty-box.svg" class="h-auto w-fit mx-auto"
                                                        alt="No Products">
                                                    <p class="text-lg text-amber-300">No products pending permission at
                                                        the moment.</p>
                                                    <p class="text-md text-gray-300 m-2">Please check back later.</p>
                                                </div>
                                            </div>
                                            <% } else { %>

                                                <div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
                                                    <% for(Product x : plist) { String p_name=x.getName(); int
                                                        p_id=x.getId(); String p_price=String.valueOf(x.getPrice());
                                                        String p_qty=String.valueOf(x.getQuantity()); String
                                                        p_pd=x.getPd(); String path=x.getImgp(); %>

                                                        <!-- Single Product Card -->
                                                        <div
                                                            class="bg-gray-800/40 backdrop-blur-lg rounded-xl border-gray-800 border-b-4 shadow-md overflow-hidden hover:shadow-xl hover:bg-gray-800/50 hover:-translate-y-1 transition-all">
                                                            <img src="<%= path %>" alt="Product"
                                                                class="w-full h-auto object-cover rounded-lg p-4" />

                                                            <div class="p-4 flex flex-col gap-2">
                                                                <h3
                                                                    class="text-lg font-semibold text-white line-clamp-1">
                                                                    <%= p_name %>
                                                                </h3>
                                                                <p class="text-gray-300 text-sm line-clamp-2">
                                                                    <%= p_pd %>
                                                                </p>
                                                                <p class="text-sm text-gray-400">Remaining Stock: <span
                                                                        class="text-white font-medium">
                                                                        <%= p_qty %>
                                                                    </span></p>
                                                                <p class="text-xl font-bold text-cyan-400">₹<%= p_price
                                                                        %>
                                                                </p>

                                                                <form action="Giveprodperm" method="post" class="mt-4">
                                                                    <input type="hidden" name="prodid"
                                                                        value="<%= p_id %>">
                                                                    <button type="submit"
                                                                        class="w-full bg-cyan-600 hover:bg-cyan-500 text-white py-2 px-4 rounded-md font-semibold transition">
                                                                        Approve Product
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>

                                                        <% } %>
                                                </div>

                                                <% } %>
                                    </div>
                                </div>

                                <!-- footer -->
                                <footer class="rounded-lg shadow-sm bg-gray-900/70 backdrop-blur-xl m-4">
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
                                            <a href="https://flowbite.com/" class="hover:underline">SwiftMart™</a>.
                                            All
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