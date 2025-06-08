<%@page import="com.example.ecom.model.Orderhist" %>
    <%@page import="com.example.ecom.model.Customer" %>
        <%@page import="com.example.ecom.model.Product" %>
            <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                <%@page import="com.example.ecom.model.Seller" %>
                    <%@page import="com.example.ecom.model.Admin" %>
                        <%@page import="java.util.List" %>
                            <!DOCTYPE html>
                            <html>

                            <head>
                                <meta charset="UTF-8">
                                <title>Customer Details</title>
                                <link rel="icon" href="/images/SwiftMart.ico" type="image/x-icon" />
                                <link rel="stylesheet" href="/css/output.css" />
                            </head>
                            <% Admin admi=(Admin)session.getAttribute("admin"); Customer
                                s=(Customer)session.getAttribute("custinfo"); List<Orderhist> op=(List<Orderhist>
                                    )request.getAttribute("ordhistofcust");
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
                                                <div class="flex justify-around gap-[10vw] text-base font-medium">
                                                    <div class="flex flex-row justify-center items-center ">
                                                        <a href="customerlist" class="hover:text-cyan-400 transition">←
                                                            Back
                                                        </a>
                                                    </div>
                                                    <div class="flex flex-row justify-center items-center gap-4">
                                                        <a href="customer_det_oh"
                                                            class="text-cyan-400 border-b-2">Orders</a>
                                                        <a href="customer_det_ct"
                                                            class="hover:text-cyan-400 transition">Cart</a>
                                                        <!-- User Dropdown -->
                                                        <div class="relative inline-block text-left mr-2">
                                                            <button id="dropdownButton" onclick="toggleDropdown()"
                                                                class="h-12 w-12 flex items-center gap-2 px-4 py-2">
                                                                <% String[]
                                                                    nameParts=admi.getUsername().trim().split("",2);
                                                                    String initials="" ; for (String part : nameParts) {
                                                                    if (!part.isEmpty()) initials +=part.charAt(0); }
                                                                    initials=initials.toUpperCase(); %>
                                                                    <div class=" flex items-center justify-center rounded-full p-1 border-white border-3
                                                                        bg-cyan-400 text-gray-700 font-semibold
                                                                        text-2xl">
                                                                        <%= initials %>
                                                                    </div>

                                                            </button>
                                                            <!-- Dropdown -->
                                                            <div id="dropdownMenu"
                                                                class="absolute right-0 mt-2 w-40 bg-white rounded-md shadow-lg ring-1 ring-black ring-opacity-5 hidden z-50">
                                                                <form action="Logout" method="post"
                                                                    class="py-1 text-gray-700">
                                                                    <button type="submit"
                                                                        class="block px-4 py-2 text-sm hover:bg-gray-100 w-full text-left">Logout</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                        </nav>

                                        <!-- customer Details -->
                                        <div
                                            class="w-[50vw] bg-black/60 backdrop-blur-lg rounded-2xl border-gray-700 border-b-4 shadow-lg p-6 mt-6 text-gray-100 mx-auto">
                                            <h3 class="text-2xl font-bold text-cyan-400 mb-4 flex items-center gap-2">
                                                <img src="/images/user.svg" alt="Seller Icon"
                                                    class="h-14 w-14 inline-block shadow-gray-500 rounded-full shadow-md m-2">
                                                Customer Information
                                            </h3>

                                            <div class="grid grid-cols-1  md:grid-cols-2 gap-6 text-sm sm:text-base">
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
                                                    <p class="mb-1 text-gray-400">Customer ID:</p>
                                                    <p class="text-white font-medium">#<%= s.getId() %>
                                                    </p>
                                                </div>

                                            </div>
                                        </div>


                                        <!-- Order History Table -->
                                        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-10">
                                            <div
                                                class="bg-gray-900 shadow-xl rounded-2xl overflow-hidden border border-gray-700">
                                                <div class="px-6 py-4 border-b border-cyan-500">
                                                    <h2 class="text-xl font-semibold text-cyan-400">Order History of <%=
                                                            s.getName() %>
                                                    </h2>
                                                </div>

                                                <% if(op.isEmpty()){ %>
                                                    <div class="p-6 text-white text-center">🛒 No orders available.
                                                    </div>
                                                    <% } else { %>

                                                        <!-- Table Wrapper -->
                                                        <div class="overflow-x-auto">
                                                            <table
                                                                class="min-w-full divide-y divide-gray-700 text-sm text-left">
                                                                <thead
                                                                    class="bg-gray-800 text-center text-cyan-300 text-sm uppercase">
                                                                    <tr>
                                                                        <th class="px-6 py-3">Image</th>
                                                                        <th class="px-6 py-3">Product</th>
                                                                        <th class="px-6 py-3">Details</th>
                                                                        <th class="px-6 py-3">Total (₹)</th>
                                                                        <th class="px-6 py-3">Customer</th>
                                                                        <th class="px-6 py-3">Date</th>
                                                                        <th class="px-6 py-3">Status</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody
                                                                    class="bg-gray-950 text-gray-200 divide-y divide-gray-800">
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
                                                                        if(statusw.equals("completed")) {
                                                                        statusmessage=ref> 0.0 ? "Refunded" :
                                                                        "Transaction Done";
                                                                        } else if(statusw.equals("cancelled")) {
                                                                        statusmessage = "Cancelled";
                                                                        } else if(statusw.equals("tfailed") && ref > 0)
                                                                        {
                                                                        statusmessage = "Transaction Failed";
                                                                        } else if(statusw.equals("appeal") ||
                                                                        statusw.equals("cnc")) {
                                                                        statusmessage = "Cancel Requested";
                                                                        } else if(statusw.equals("ongoing")) {
                                                                        statusmessage = "Ongoing Transaction";
                                                                        }

                                                                        String badgeColor = "bg-cyan-600";
                                                                        if (statusmessage.contains("Refunded"))
                                                                        badgeColor = "bg-green-700";
                                                                        else if (statusmessage.contains("Cancelled"))
                                                                        badgeColor = "bg-red-700";
                                                                        else if (statusmessage.contains("Ongoing"))
                                                                        badgeColor = "bg-blue-700";
                                                                        else if (statusmessage.contains("Failed"))
                                                                        badgeColor = "bg-yellow-700";
                                                                        else if (statusmessage.contains("Requested"))
                                                                        badgeColor = "bg-orange-700";
                                                                        %>
                                                                        <tr
                                                                            class="hover:bg-gray-800/50 text-left transition-all duration-200">
                                                                            <!-- Image -->
                                                                            <td class="px-6 py-4 align-middle">
                                                                                <img src="<%= x.getOimg() %>"
                                                                                    alt="Order <%= oid %>"
                                                                                    class="h-16 w-16 object-cover rounded shadow border border-gray-700">
                                                                            </td>

                                                                            <!-- Product -->
                                                                            <td class="px-6 py-4 align-top space-y-1">
                                                                                <p class="font-semibold text-cyan-300">
                                                                                    <%= p_name %>
                                                                                </p>
                                                                                <p class="text-gray-400 text-xs">
                                                                                    <%= p_pd %>
                                                                                </p>
                                                                                <p class="text-xs text-gray-500">Seller:
                                                                                    <%= s_name %>
                                                                                </p>
                                                                            </td>

                                                                            <!-- Quantity & Total -->
                                                                            <td
                                                                                class="px-6 py-4 align-top text-sm text-left">
                                                                                <p>Qty: <%= bqty %>
                                                                                </p>
                                                                                <p>Price: <span class="text-amber-500">
                                                                                        ₹<%= p_price %>
                                                                                    </span>
                                                                                </p>

                                                                            </td>

                                                                            <!-- Final Price -->
                                                                            <td
                                                                                class="px-6 py-4 align-top text-cyan-300 font-medium">
                                                                                ₹<%= cost %>
                                                                            </td>

                                                                            <!-- Customer Info -->
                                                                            <td class="px-6 py-4 align-top text-sm">
                                                                                <p>
                                                                                    <%= s.getName() %>
                                                                                </p>
                                                                                <p class="text-gray-400 text-xs">
                                                                                    <%= s.getEmail() %>
                                                                                </p>
                                                                                <p class="text-gray-500 text-xs">ID: #
                                                                                    <%= s.getId() %>
                                                                                </p>
                                                                            </td>

                                                                            <!-- Order Date -->
                                                                            <td class="px-6 py-4 align-top text-xs">
                                                                                <%= dt %>
                                                                            </td>

                                                                            <!-- Status -->
                                                                            <td class="px-6 py-4 align-top text-center">
                                                                                <span
                                                                                    class="inline-block text-center px-2 py-1 rounded-full text-xs font-semibold border-2 text-white <%= badgeColor %>">
                                                                                    <%= statusmessage %>
                                                                                </span>
                                                                            </td>
                                                                        </tr>
                                                                        <% } %>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                        <% } %>
                                            </div>
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
                                                        class="hover:underline">SwiftMart™</a>. All
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