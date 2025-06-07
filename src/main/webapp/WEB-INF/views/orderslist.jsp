<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="com.example.ecom.model.Admin" %>
        <%@page import="com.example.ecom.model.Orderhist" %>
            <%@page import="java.util.List" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Customers List</title>
                    <link rel="icon" href="/images/SwiftMart.ico" type="image/x-icon" />
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
                                <div class="flex flex-wrap justify-center sm:gap-12 items-center lg:gap-6 text-base font-medium mt-4 md:mt-0">
                                    <a href="adminhome" class="hover:text-cyan-500 transition">Active
                                        Sellers</a>
                                    <a href="passivesellers" class="hover:text-cyan-400 transition">Pending
                                        Sellers</a>
                                    <a href="customerlist" class="hover:text-cyan-400 transition">Customers</a>
                                    <a href="productlist" class="hover:text-cyan-400 transition">Products</a>
                                    <a href="orderslist" class="text-cyan-400 border-b-2">Orders</a>
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
                                <h2 class="text-2xl font-semibold py-2 border-b">The Orders Placed by Customers</h2>
                            </div>

                        <div class="max-w-7xl mx-auto px-4">                            

                            <% List<Orderhist> op = (List<Orderhist>)request.getAttribute("allordhist");
                                    if(op.isEmpty()){ %>
                                    <div class="text-white text-lg">No orders present now.</div>
                                    <% } else { %>

                                        <!-- Orders Section -->
                                        <section class="grid lg:grid-cols-1 md:grid-cols-2 gap-6 p-6">
                                            <% for(Orderhist x : op) { int oid=x.getId(); String
                                                p_name=x.getProductname(); String p_pd=x.getProductdesc(); Double
                                                p_price=x.getProductprice(); int p_id=x.getProdid(); int
                                                bqty=x.getBqty(); int c_id=x.getCustid(); int s_id=x.getSelrid(); String
                                                c_name=x.getCustname(); String s_name=x.getSellername(); Double
                                                cost=p_price * bqty; String dt=x.getDatetime(); Double
                                                taken=x.getTaken(); Double ref=x.getRefunded(); String
                                                statusw=x.getOrderstatus(); String statusmessage="" ; if
                                                (statusw.equals("completed")) { statusmessage=ref> 0.0 ? "Refunded" :
                                                "Transaction done";
                                                } else if (statusw.equals("cancelled")) {
                                                statusmessage = "Cancelled";
                                                } else if (statusw.equals("tfailed") && ref > 0) {
                                                statusmessage = "Transaction failed";
                                                } else if (statusw.equals("ongoing")) {
                                                statusmessage = "Ongoing";
                                                }
                                                %>

                                                <div
                                                    class="bg-gray-800/50 backdrop-blur-md border-b-4 border-gray-800 rounded-2xl shadow-lg hover:shadow-2xl hover:-translate-y-1 transition duration-300 overflow-hidden flex flex-col sm:flex-row">
                                                    <!-- Product Image -->
                                                    <div class="w-full sm:w-1/3">
                                                        <img src="<%= x.getOimg() %>" alt="Product <%= oid %>"
                                                            class="w-full h-auto object-cover sm:h-full">
                                                    </div>

                                                    <!-- Order Details -->
                                                    <div class="w-full sm:w-2/3 p-4 flex flex-col justify-between">
                                                        <div class="space-y-4">
                                                            <h2 class="text-lg md:text-xl font-semibold text-white">
                                                                <%= p_name %>
                                                            </h2>
                                                            <p class="text-sm text-gray-300">
                                                                <%= p_pd %>
                                                            </p>

                                                            <div class="text-sm text-gray-300 mt-2 space-y-3">
                                                                <p><span
                                                                        class="font-semibold text-gray-200">Seller:</span>
                                                                    <%= s_name %> (ID: <%= s_id %>)
                                                                </p>
                                                                <p><span
                                                                        class="font-semibold text-gray-200">Customer:</span>
                                                                    <%= c_name %> (ID: <%= c_id %>)
                                                                </p>
                                                                <p><span class="font-semibold text-gray-200">Product
                                                                        ID:</span>
                                                                    <%= p_id %>
                                                                </p>
                                                                <p>
                                                                    <span
                                                                        class="font-semibold text-gray-200">Quantity:</span>
                                                                    <%= bqty %> |
                                                                        <span class="font-semibold">Unit Price:</span> ₹
                                                                        <%= p_price %>
                                                                </p>
                                                                <p><span class="font-semibold text-gray-200">Total
                                                                        Cost:</span> ₹<%= cost %>
                                                                </p>
                                                                <p><span
                                                                        class="font-semibold text-gray-200">Date:</span>
                                                                    <%= dt %>
                                                                </p>
                                                            </div>
                                                        </div>

                                                        <!-- Action Section -->
                                                        <div class="mt-4">
                                                            <% if (statusw.equals("appeal")) { %>
                                                                <div class="flex flex-wrap gap-2">
                                                                    <form action="acceptcancel" method="post">
                                                                        <input type="hidden" name="orderhist_id"
                                                                            value="<%= oid %>">
                                                                        <button type="submit"
                                                                            class="px-4 py-1.5 bg-green-600 hover:bg-green-700 text-white text-sm rounded-md transition">
                                                                            Accept
                                                                        </button>
                                                                    </form>
                                                                    <form action="rejectcancel" method="post">
                                                                        <input type="hidden" name="orderhist_id"
                                                                            value="<%= oid %>">
                                                                        <button type="submit"
                                                                            class="px-4 py-1.5 bg-red-600 hover:bg-red-700 text-white text-sm rounded-md transition">
                                                                            Reject
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                                <% } else if (statusw.equals("cnc")) { %>
                                                                    <p
                                                                        class="text-yellow-400 text-sm font-semibold mb-1">
                                                                        Can't be cancelled</p>
                                                                    <form action="rejectcancel" method="post">
                                                                        <input type="hidden" name="orderhist_id"
                                                                            value="<%= oid %>">
                                                                        <button type="submit"
                                                                            class="px-4 py-1.5 bg-red-600 hover:bg-red-700 text-white text-sm rounded-md transition">
                                                                            Reject
                                                                        </button>
                                                                    </form>
                                                                    <% } else { %>
                                                                        <p
                                                                            class="text-md w-fit border-cyan-400 border rounded p-2 font-semibold text-cyan-400">
                                                                            <%= statusmessage %>
                                                                        </p>
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
                            setInterval(function () {
                                location.reload();
                            }, 5000);
                        </script>
                    </body>

                </html>