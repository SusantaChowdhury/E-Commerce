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
                                    <title>Customer Cart</title>
                                    <link rel="stylesheet" href="/css/output.css" />
                                </head>
                                <% Customer c=(Customer)session.getAttribute("customer"); int custid=c.getId(); String
                                    custname=c.getName(); %>

                                    <body class="min-h-screen font-sans"
                                        style="background-image: linear-gradient(to top, rgb(81, 3, 81), rgb(37, 197, 197));">

                                        <!-- Navbar -->
                                        <nav class="bg-gray-900 text-gray-100 px-4 rounded-b-lg shadow">
                                            <div class="flex flex-wrap justify-between items-center py-2">
                                                <!-- Logo -->
                                                <a href="/" class="flex m-2 items-center space-x-3">
                                                    <img src="/images/SwiftMart.png" class="h-14 rounded-xl shadow-lg"
                                                        alt="SwiftMart Logo" />
                                                    <span class="text-2xl font-semibold text-white">SwiftMart™</span>
                                                </a>

                                                <!-- Navigation Links -->
                                                <div class="flex gap-4 items-center text-sm sm:text-base">
                                                    <a href="customerhome"
                                                        class="bg-gray-800 px-4 py-2 rounded hover:bg-gray-700 font-medium shadow">Products</a>
                                                    <a href="custcart"
                                                        class="bg-gray-800 px-4 py-2 rounded hover:bg-gray-700 font-medium shadow">Cart</a>
                                                    <a href="custordrhist"
                                                        class="bg-gray-600 px-4 py-2 rounded hover:bg-gray-700 font-medium shadow">Orders</a>

                                                    <!-- User Dropdown -->
                                                    <div class="relative inline-block text-left">
                                                        <button id="dropdownButton" onclick="toggleDropdown()"
                                                            class="h-12 w-12 flex items-center gap-2 px-4 py-2">
                                                            <% String[]
                                                                nameParts=custname.trim().split(" "); String initials = ""; for (String part : nameParts) { if (!part.isEmpty()) initials += part.charAt(0); } initials = initials.toUpperCase(); %>
                            <div class=" flex items-center justify-center text-gray-700 font-semibold text-2xl shadow"
                                                                style="width: 50px; height: 50px; border-radius: 50%; background-color: rgb(32, 220, 220); border: 3px solid white;">
                                                                <%= initials %>
                                                    </div>
                                                    <span class="hidden sm:inline text-white font-medium">
                                                        <%= custname %>
                                                    </span>
                                                    <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor"
                                                        stroke-width="2" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            d="M19 9l-7 7-7-7"></path>
                                                    </svg>
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

                                        <div class="container mx-auto">
                                            <h2 class="text-3xl font-bold my-6 text-center text-gray-200">Your Order
                                                History</h2>

                                            <% List<Orderhist> op = (List<Orderhist>) request.getAttribute("ordhist");
                                                    if(op == null || op.isEmpty()) {
                                                    %>
                                                    <p class="text-center text-gray-600 text-lg">No orders available.
                                                    </p>
                                                    <% } else { %>

                                                        <div class="rounded" style="overflow-x: auto;">
                                                            <table
                                                                class="min-w-full m-4 rounded-lg bg-white shadow-md overflow-hidden"
                                                                style="border-radius: 8px;">
                                                                <thead
                                                                    class="bg-blue-600 text-lg font-semibold text-white">
                                                                    <tr>
                                                                        <th class="py-3 px-4 text-left">Image</th>
                                                                        <th class="py-3 px-4 text-left">Product</th>
                                                                        <th class="py-3 px-4 text-left">Details</th>
                                                                        <th class="py-3 px-4 text-left">Seller</th>
                                                                        <th class="py-3 px-4 text-left">Qty</th>
                                                                        <th class="py-3 px-4 text-left">Price</th>
                                                                        <th class="py-3 px-4 text-left">Subtotal</th>
                                                                        <th class="py-3 px-4 text-left">Date & Time</th>
                                                                        <th class="py-3 px-4 text-left">Status</th>
                                                                        <th class="py-3 px-4 text-left">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody class="divide-y divide-gray-200">
                                                                    <% for(Orderhist x : op) { int oid=x.getId(); String
                                                                        p_name=x.getProductname(); String
                                                                        p_pd=x.getProductdesc(); Double
                                                                        p_price=x.getProductprice(); int
                                                                        bqty=x.getBqty(); String
                                                                        s_name=x.getSellername(); Double cost=p_price *
                                                                        bqty; String dt=x.getDatetime(); Double
                                                                        taken=x.getTaken(); Double ref=x.getRefunded();
                                                                        String statusw=x.getOrderstatus(); String
                                                                        statusmessage="" ;
                                                                        if("completed".equals(statusw)){
                                                                        statusmessage=(ref> 0.0) ? "Refunded" :
                                                                        "Transaction done";
                                                                        } else if("cancelled".equals(statusw)){
                                                                        statusmessage = "Cancelled";
                                                                        } else if("tfailed".equals(statusw) && ref > 0){
                                                                        statusmessage = "Transaction failed";
                                                                        } else if("appeal".equals(statusw) ||
                                                                        "cnc".equals(statusw)){
                                                                        statusmessage = "Cancel Requested";
                                                                        } else {
                                                                        statusmessage = "Ongoing";
                                                                        }
                                                                        %>
                                                                        <tr>
                                                                            <td class="py-3 px-4">
                                                                                <img src="<%= x.getOimg() %>"
                                                                                    alt="Order <%= oid %>"
                                                                                    class="object-cover rounded"
                                                                                    style="width: 300px;" />
                                                                            </td>
                                                                            <td class="py-3 px-4 font-semibold">
                                                                                <%= p_name %>
                                                                            </td>
                                                                            <td class="py-3 px-4 text-sm text-gray-600">
                                                                                <%= p_pd %>
                                                                            </td>
                                                                            <td class="py-3 px-4">
                                                                                <%= s_name %>
                                                                            </td>
                                                                            <td class="py-3 px-4">
                                                                                <%= bqty %>
                                                                            </td>
                                                                            <td class="py-3 px-4">₹<%= p_price %>
                                                                            </td>
                                                                            <td
                                                                                class="py-3 px-4 font-semibold text-green-700">
                                                                                ₹<%= cost %>
                                                                            </td>
                                                                            <td class="py-3 px-4 text-sm">
                                                                                <%= dt %>
                                                                            </td>
                                                                            <% String statusColor="Ongoing"
                                                                                .equals(statusmessage)
                                                                                ? "text-yellow-600" : "text-blue-700" ;
                                                                                %>
                                                                                <td
                                                                                    class="py-3 px-4 font-medium <%= statusColor %>">
                                                                                    <%= statusmessage %>
                                                                                </td>
                                                                                <td class="py-3 px-4">
                                                                                    <% if("ongoing".equals(statusw)) {
                                                                                        %>
                                                                                        <form action="cancelord"
                                                                                            method="post">
                                                                                            <input type="hidden"
                                                                                                name="orderhist_id"
                                                                                                value="<%= oid %>">
                                                                                            <button type="submit"
                                                                                                class="bg-red-500 hover:bg-red-600 text-white py-1 px-3 rounded text-sm">Cancel</button>
                                                                                        </form>
                                                                                        <% } else { %>
                                                                                            <span
                                                                                                class="text-gray-500 text-sm">-</span>
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
                                                            <a href="#"
                                                                class="hover:underline me-4 md:me-6">Licensing</a>
                                                        </li>
                                                        <li>
                                                            <a href="#" class="hover:underline">Contact</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <hr
                                                    class="my-6 border-gray-200 sm:mx-auto dark:border-gray-700 lg:my-8" />
                                                <span
                                                    class="block text-sm text-gray-500 sm:text-center dark:text-gray-400">©
                                                    2023
                                                    <a href="https://flowbite.com/"
                                                        class="hover:underline">SwiftMart™</a>.
                                                    All
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