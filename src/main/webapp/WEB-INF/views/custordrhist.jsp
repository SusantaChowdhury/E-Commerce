<%@page import="com.example.ecom.model.Orderhist" %>
    <%@page import="com.example.ecom.model.Orderprod" %>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <%@page import="com.example.ecom.model.Seller" %>
                <%@page import="com.example.ecom.model.Product" %>
                    <%@page import="com.example.ecom.model.Customer" %>
                        <%@page import="com.example.ecom.model.Orderprod" %>
                            <%@page import="java.util.List, java.util.Date" %>
                                <!DOCTYPE html>
                                <html>

                                <head>
                                    <meta charset="UTF-8">
                                    <title>Your Orders</title>
                                    <link rel="icon" href="/images/SwiftMart.ico" type="image/x-icon" />
                                    <link rel="stylesheet" href="/css/output.css" />
                                </head>
                                <% Customer c=(Customer)session.getAttribute("customer"); int custid=c.getId(); String
                                    custname=c.getName(); %>

                                    <body
                                        class="bg-gradient-to-b from-cyan-600 to-purple-950 min-h-screen text-white font-sans">


                                        <!-- <div class="flex flex-col  justify-between items-center min-h-screen"> -->

                                        <!-- Navbar -->
                                        <nav class="bg-gray-900 w-full text-gray-100 px-4 shadow-md">
                                            <div class="flex flex-wrap justify-between items-center py-2">
                                                <a href="adminhome"
                                                    class="flex m-4 items-center space-x-3 rtl:space-x-reverse">
                                                    <img src="/images/SwiftMart.png" class="h-16 rounded-2xl"
                                                        alt="SwiftMart Logo" />
                                                    <span
                                                        class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                                                </a>
                                                <div
                                                    class="flex flex-wrap justify-center items-center lg:gap-6 sm:gap-8 text-lg font-medium p-2">
                                                    <a href="customerhome"
                                                        class="hover:text-cyan-400 font-medium transition">Products</a>
                                                    <a href="custcart" class="hover:text-cyan-400 transition">Cart</a>
                                                    <a href="custordrhist"
                                                        class="text-cyan-400 font-medium border-b-2">Orders</a>
                                                    <!-- User Dropdown -->
                                                    <div class="relative inline-block text-left mr-2">
                                                        <button id="dropdownButton" onclick="toggleDropdown()"
                                                            class="h-12 w-12 flex items-center gap-2 px-4 mr-2 py-2">
                                                            <% String[]
                                                                nameParts=custname.trim().split(" "); String initials = ""; for (String part : nameParts) { if (!part.isEmpty()) initials += part.charAt(0); } initials = initials.toUpperCase(); %>
                                                    <div class=" flex items-center justify-center rounded-full p-1
                                                                border-white border-3 bg-cyan-400 text-gray-700
                                                                font-semibold text-2xl">
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
                                        <div class="w-[90vw] mx-auto">
                                            <h2 class="text-3xl font-bold my-6 text-center text-gray-200">Your
                                                Order
                                                History</h2>

                                            <% List<Orderhist> op = (List<Orderhist>)
                                                    request.getAttribute("ordhist");
                                                    if(op == null || op.isEmpty()) {
                                                    %>
                                                    <div
                                                        class="w-[55vw] mx-auto flex flex-col items-center bg-gray-800/40 backdrop-blur-lg border-gray-800 border-b-4 m-10 rounded-xl shadow-xl text-center text-lg text-amber-400 font-semibold mt-1">
                                                        <img src="/images/empty-box.svg" alt="Empty Cart"
                                                            class="lg:w-[35vw] h-auto">
                                                        <p class="p-2 ">You haven't ordered anything yet.</p>

                                                        <a type="button" href="customerhome"
                                                            class="bg-blue-600 m-4 hover:bg-blue-700 text-white font-semibold px-6 py-2 rounded-md shadow-md">
                                                            Start shopping now!</a>
                                                    </div>
                                                    <% } else { %>

                                                        <!-- Customer View: All Orders Table -->
                                                        <div class="w-full rounded overflow-x-auto">
                                                            <table
                                                                class="min-w-full rounded-lg bg-gray-800/50 backdrop-blur-xl shadow-md">
                                                                <thead
                                                                    class="bg-slate-800 text-base font-semibold text-white">
                                                                    <tr class="text-center">
                                                                        <th class="py-3 px-4">Image</th>
                                                                        <th class="py-3 px-4">Product</th>
                                                                        <th class="py-3 px-4">Details</th>
                                                                        <th class="py-3 px-4">Seller</th>
                                                                        <th class="py-3 px-4">Qty</th>
                                                                        <th class="py-3 px-4">Price (₹)</th>
                                                                        <th class="py-3 px-4">Total (₹)</th>
                                                                        <th class="py-3 px-4">Date & Time</th>
                                                                        <th class="py-3 px-4">Status</th>
                                                                        <th class="py-3 px-4">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <% for(Orderhist x : op) { 
                                                                        int oid=x.getId(); 
                                                                        String p_name=x.getProductname(); 
                                                                        String p_pd=x.getProductdesc(); 
                                                                        Double p_price=x.getProductprice(); 
                                                                        int bqty=x.getBqty(); 
                                                                        String s_name=x.getSellername(); 
                                                                        Double cost = p_price * bqty; 
                                                                        String dt = x.getDatetime(); 
                                                                        Double taken=x.getTaken(); 
                                                                        Double ref = x.getRefunded();
                                                                        String statusw = x.getOrderstatus(); 
                                                                        String statusmessage="" ; 
                                                                        if("completed".equals(statusw)) {
                                                                            statusmessage=(ref> 0.0) ? "Refunded" : "Transaction Done";
                                                                        } else if ("cancelled".equals(statusw)){
                                                                            statusmessage = "Cancelled";
                                                                        } else if ("tfailed".equals(statusw) && ref > 0) {
                                                                            statusmessage = "Transaction Failed";
                                                                        } else if ("appeal".equals(statusw) || "cnc".equals(statusw)) {
                                                                            statusmessage = "Cancel Requested";
                                                                        } else {
                                                                            statusmessage = "Ongoing";
                                                                        }

                                                                        String statusColor = "text-yellow-500";
                                                                        if (statusmessage.contains("Done"))
                                                                            statusColor = "bg-cyan-800 text-cyan-100";
                                                                        else if (statusmessage.contains("Refunded"))
                                                                            statusColor = "bg-green-700 text-green-300";
                                                                        else if (statusmessage.contains("Cancelled"))
                                                                            statusColor = "bg-red-500 border-2 text-red-200";
                                                                        else if (statusmessage.contains("Failed"))
                                                                            statusColor = "bg-yellow-300 text-yellow-700";
                                                                        else if (statusmessage.contains("Requested"))
                                                                            statusColor = "bg-orange-300 text-red-800";
                                                                    %>
                                                                        <tr
                                                                            class="hover:bg-gray-800/50 transition border-gray-600 border-t duration-200 text-gray-200 text-center">
                                                                            <!-- Image -->
                                                                            <td class="py-3 px-4">
                                                                                <img src="<%= x.getOimg() %>"
                                                                                    alt="Order <%= oid %>"
                                                                                    class="w-full h-auto object-cover rounded shadow">
                                                                            </td>

                                                                            <!-- Product Name -->
                                                                            <td
                                                                                class="py-3 px-4 font-semibold max-w-xs truncate">
                                                                                <%= p_name %>
                                                                            </td>

                                                                            <!-- Product Description -->
                                                                            <td
                                                                                class="py-3 px-4 text-sm text-gray-300 max-w-xs truncate">
                                                                                <%= p_pd %>
                                                                            </td>

                                                                            <!-- Seller -->
                                                                            <td class="py-3 px-4">
                                                                                <%= s_name %>
                                                                            </td>

                                                                            <!-- Quantity -->
                                                                            <td class="py-3 px-4">
                                                                                <%= bqty %>
                                                                            </td>

                                                                            <!-- Unit Price -->
                                                                            <td class="py-3 px-4 text-yellow-500">
                                                                                ₹<%= p_price %>
                                                                            </td>

                                                                            <!-- Total Cost -->
                                                                            <td
                                                                                class="py-3 px-4 font-semibold text-green-400">
                                                                                ₹<%= cost %>
                                                                            </td>

                                                                            <!-- Date & Time -->
                                                                            <td class="py-3 px-4 text-sm">
                                                                                <%= dt %>
                                                                            </td>

                                                                            <!-- Status -->
                                                                            <td class="py-3 px-4 font-medium text-sm">
                                                                                <div
                                                                                    class="border-2 p-2 rounded-full <%= statusColor %>">
                                                                                    <%= statusmessage %>
                                                                                </div>
                                                                            </td>

                                                                            <!-- Action -->
                                                                            <td class="py-3 px-4 text-center">
                                                                                <% if ("ongoing".equals(statusw)) { %>
                                                                                    <form action="cancelord"
                                                                                        method="post">
                                                                                        <input type="hidden"
                                                                                            name="orderhist_id"
                                                                                            value="<%= oid %>">
                                                                                        <button type="submit"
                                                                                            class="bg-red-500 hover:bg-red-600 text-white py-1 px-3 rounded text-sm transition">
                                                                                            Cancel
                                                                                        </button>
                                                                                    </form>
                                                                                <% } else { %>
                                                                                        <span class="text-gray-300 text-sm">Non-cancellable</span>
                                                                                <% } %>
                                                                            </td>
                                                                        </tr>
                                                                    <% } %>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    <% } %>
                                        </div>

                                        <!-- footer -->
                                        <footer class="rounded-lg shadow-sm bg-gray-900 m-4">
                                            <div class="w-full max-w-screen-xl mx-auto p-4 md:py-8">
                                                <div class="sm:flex sm:items-center sm:justify-between">
                                                    <a href="custordrhist"
                                                        class="flex items-center mb-4 sm:mb-0 space-x-3 rtl:space-x-reverse">
                                                        <img src="images/SwiftMart.png" class="h-12 rounded-xl"
                                                            alt="SwiftMart Logo" />
                                                        <span
                                                            class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-2xl text-transparent font-semibold whitespace-nowrap">SwiftMart™</span>
                                                    </a>
                                                    <ul
                                                        class="flex flex-wrap items-center mb-6 text-sm font-medium text-gray-500 sm:mb-0 dark:text-gray-400">
                                                        <li>
                                                            <a href="aboutus"
                                                                class="hover:underline me-4 md:me-6">About</a>
                                                        </li>
                                                        <li>
                                                            <a href="contactus"
                                                                class="hover:underline me-4 md:me-6">Contact</a>
                                                        </li>
                                                        <li>
                                                            <a href="#" class="hover:underline me-4 md:me-6">Privacy
                                                                Policy</a>
                                                        </li>
                                                        <li>
                                                            <a href="#" class="hover:underline">Licensing</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <hr
                                                    class="my-6 border-gray-200 sm:mx-auto dark:border-gray-700 lg:my-8" />
                                                <span
                                                    class="block text-sm text-gray-500 sm:text-center dark:text-gray-400">©
                                                    2025
                                                    <a href="https://flowbite.com/"
                                                        class="hover:underline">SwiftMart™</a>.
                                                    All
                                                    Rights Reserved.</span>
                                            </div>
                                        </footer>
                                        </div>
                                        <script src="/js/script.js"></script>
                                        <script>                                            
                                            setInterval(function () {
                                                location.reload();
                                            }, 5000);
                                        </script>
                                    </body>
                                </html>