<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="com.example.ecom.model.Admin" %>
        <%@page import="com.example.ecom.model.Orderhist" %>
            <%@page import="java.util.List" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Orders</title>
                    <link rel="icon" href="/images/SwiftMart.ico" type="image/x-icon" />
                    <link rel="stylesheet" href="/css/output.css" />
                </head>
                <% Admin admi=(Admin)session.getAttribute("admin"); %>

                    <body class="bg-gradient-to-b from-cyan-600 to-purple-950 min-h-screen text-white font-sans">
                        <!-- Navbar -->
                        <nav class="bg-gray-900 w-full text-gray-100 px-4 shadow-md">
                                <div class="flex flex-wrap justify-between items-center py-2">
                                    <a href="adminhome" class="flex m-4 items-center space-x-3 rtl:space-x-reverse">
                                        <img src="/images/SwiftMart.png" class="h-16 rounded-2xl"
                                            alt="SwiftMart Logo" />
                                        <span
                                            class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                                    </a>
                                    <div
                                        class="flex flex-wrap justify-center items-center lg:gap-6 sm:gap-8 text-lg font-medium p-2">
                                        <a href="adminhome" class="hover:text-cyan-400 transition">Active
                                            Sellers</a>
                                        <a href="passivesellers" class="hover:text-cyan-400 transition">Pending
                                            Sellers</a>
                                        <a href="customerlist" class="hover:text-cyan-400 transition">Customers</a>
                                        <a href="productlist" class="hover:text-cyan-400 transition">Products</a>
                                        <a href="orderslist" class="text-cyan-400 border-b-2">Orders</a>
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
                        <div class="text-center pt-8 px-4">
                            <h2 class="text-2xl font-semibold py-2 border-b">The Orders Placed by Customers</h2>
                        </div>

                        <div class="max-w-7xl mx-auto px-4">

                            <% List<Orderhist> op = (List<Orderhist>)request.getAttribute("allordhist");
                                    if(op.isEmpty()){ %>
                                    <div class="text-white text-lg">No orders present now.</div>
                                    <% } else { %>

                                        <!-- Admin View: All Customer Orders -->
                                        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-10">
                                            <div
                                                class="bg-gray-900/80 backdrop-blur-lg shadow-xl rounded-2xl border-b-4 border-gray-700 overflow-hidden">
                                                <div class="px-6 py-4 bg-gray-900 border-b border-cyan-500">
                                                    <h2 class="text-xl font-semibold text-cyan-400">All Customer Orders
                                                    </h2>
                                                </div>

                                                <% if(op.isEmpty()) { %>
                                                    <div class="p-6 text-white text-center">No orders available.</div>
                                                    <% } else { %>

                                                        <div class="overflow-x-auto">
                                                            <table
                                                                class="min-w-full divide-y divide-cyan-400 border-gray-800 text-sm text-left">
                                                                <thead
                                                                    class="bg-gray-800 text-cyan-300 text-sm text-center uppercase">
                                                                    <tr>
                                                                        <th class="px-6 py-3">Image</th>
                                                                        <th class="px-6 py-3">Product</th>
                                                                        <th class="px-6 py-3">Details</th>
                                                                        <th class="px-6 py-3">Customer</th>
                                                                        <th class="px-6 py-3">Seller</th>
                                                                        <th class="px-6 py-3">Total</th>
                                                                        <th class="px-6 py-3">Date</th>
                                                                        <th class="px-6 py-3">Status</th>
                                                                        <th class="px-6 py-3">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody class="text-gray-200 divide-y divide-gray-600">
                                                                    <% for(Orderhist x : op) { int oid=x.getId(); String
                                                                        p_name=x.getProductname(); String
                                                                        p_pd=x.getProductdesc(); Double
                                                                        p_price=x.getProductprice(); int
                                                                        p_id=x.getProdid(); int bqty=x.getBqty(); int
                                                                        c_id=x.getCustid(); int s_id=x.getSelrid();
                                                                        String c_name=x.getCustname(); String
                                                                        s_name=x.getSellername(); Double cost=p_price *
                                                                        bqty; String dt=x.getDatetime(); Double
                                                                        taken=x.getTaken(); Double ref=x.getRefunded();
                                                                        String statusw=x.getOrderstatus(); String
                                                                        statusmessage="" ; if
                                                                        (statusw.equals("completed")) {
                                                                        statusmessage=ref> 0.0 ? "Refunded" :
                                                                        "Transaction Done";
                                                                        } else if (statusw.equals("cancelled")) {
                                                                        statusmessage = "Cancelled";
                                                                        } else if (statusw.equals("tfailed") && ref > 0)
                                                                        {
                                                                        statusmessage = "Transaction Failed";
                                                                        } else if (statusw.equals("ongoing")) {
                                                                        statusmessage = "Ongoing";
                                                                        } else if (statusw.equals("appeal")) {
                                                                        statusmessage = "Cancel Requested";
                                                                        } else if (statusw.equals("cnc")) {
                                                                        statusmessage = "Can't be Cancelled";
                                                                        }

                                                                        String badgeColor = "bg-cyan-700 border-2 text-gray-100";
                                                                        if (statusmessage.contains("Refunded"))
                                                                        badgeColor = "bg-green-700 border-2 text-green-300";
                                                                        if (statusmessage.contains("Ongoing"))
                                                                        badgeColor = "bg-yellow-700 border-2 text-yellow-100";
                                                                        else if (statusmessage.contains("Cancelled"))
                                                                        badgeColor = "bg-red-500 border-2 text-red-100";
                                                                        else if (statusmessage.contains("Failed"))
                                                                        badgeColor = "bg-yellow-300 border-2 text-yellow-700";
                                                                        else if (statusmessage.contains("Requested"))
                                                                        badgeColor = "bg-red-300 border-2 text-red-700";
                                                                        else if (statusmessage.contains("Can't be"))
                                                                        badgeColor = "bg-yellow-800 border-2 text-yellow-200";
                                                                        %>

                                                                        <tr
                                                                            class="hover:bg-gray-900/40 text-left rounded-2xl transition-all duration-200">
                                                                            <!-- Image -->
                                                                            <td class="px-6 py-4 align-top">
                                                                                <img src="<%= x.getOimg() %>"
                                                                                    alt="Order <%= oid %>"
                                                                                    class="h-auto w-full object-cover rounded border border-gray-700 shadow">
                                                                            </td>

                                                                            <!-- Product -->
                                                                            <td class="px-6 py-4 align-top space-y-1">
                                                                                <p class="font-semibold text-cyan-300">
                                                                                    <%= p_name %>
                                                                                </p>
                                                                                <p class="text-gray-400 text-xs">
                                                                                    <%= p_pd %>
                                                                                </p>
                                                                                <p class="text-gray-500 text-xs">PID:
                                                                                    <%= p_id %>
                                                                                </p>
                                                                            </td>

                                                                            <!-- Quantity & Pricing -->
                                                                            <td class="px-6 py-4 align-top text-sm">
                                                                                <p class="mb-2">Qty: <%= bqty %>
                                                                                </p>
                                                                                <p>Price: <span
                                                                                        class="text-yellow-500">₹<%=
                                                                                            p_price %></span>
                                                                                </p>
                                                                            </td>

                                                                            <!-- Customer -->
                                                                            <td class="px-6 py-4 align-top text-sm">
                                                                                <p>
                                                                                    <%= c_name %>
                                                                                </p>
                                                                                <p class="text-xs text-gray-400">ID: <%=
                                                                                        c_id %>
                                                                                </p>
                                                                            </td>

                                                                            <!-- Seller -->
                                                                            <td class="px-6 py-4 align-top text-sm">
                                                                                <p>
                                                                                    <%= s_name %>
                                                                                </p>
                                                                                <p class="text-xs text-gray-400">ID: <%=
                                                                                        s_id %>
                                                                                </p>
                                                                            </td>

                                                                            <!-- Total -->
                                                                            <td
                                                                                class="px-6 py-4 align-top text-green-400 font-medium">
                                                                                ₹<%= cost %>
                                                                            </td>

                                                                            <!-- Date -->
                                                                            <td class="px-6 py-4 align-top text-xs">
                                                                                <%= dt %>
                                                                            </td>

                                                                            <!-- Status -->
                                                                            <td class="px-6 py-4 align-top text-center">
                                                                                <span
                                                                                    class="inline-block px-2 py-1 text-center rounded-full text-sm <%= badgeColor %>">
                                                                                    <%= statusmessage %>
                                                                                </span>
                                                                            </td>

                                                                            <!-- Action -->
                                                                            <td class="px-6 py-4 align-top space-y-2">
                                                                                <% if (statusw.equals("appeal")) { %>
                                                                                    <form action="acceptcancel"
                                                                                        method="post" class="mb-1">
                                                                                        <input type="hidden"
                                                                                            name="orderhist_id"
                                                                                            value="<%= oid %>">
                                                                                        <button type="submit"
                                                                                            class="px-3 py-1.5 bg-green-600 hover:bg-green-700 text-white text-xs rounded transition">
                                                                                            Accept
                                                                                        </button>
                                                                                    </form>
                                                                                    <form action="rejectcancel"
                                                                                        method="post">
                                                                                        <input type="hidden"
                                                                                            name="orderhist_id"
                                                                                            value="<%= oid %>">
                                                                                        <button type="submit"
                                                                                            class="px-3 py-1.5 bg-red-600 hover:bg-red-700 text-white text-xs rounded transition">
                                                                                            Reject
                                                                                        </button>
                                                                                    </form>
                                                                                    <% } else if (statusw.equals("cnc"))
                                                                                        { %>
                                                                                        <p
                                                                                            class="text-yellow-400 text-xs mb-1">
                                                                                            Can't be cancelled</p>
                                                                                        <form action="rejectcancel"
                                                                                            method="post">
                                                                                            <input type="hidden"
                                                                                                name="orderhist_id"
                                                                                                value="<%= oid %>">
                                                                                            <button type="submit"
                                                                                                class="px-3 py-1.5 bg-red-600 hover:bg-red-700 text-white text-xs rounded transition">
                                                                                                Reject
                                                                                            </button>
                                                                                        </form>
                                                                                        <% } else { %>
                                                                                            <p
                                                                                                class="text-xs text-cyan-400 font-medium">
                                                                                                No action needed</p>
                                                                                            <% } %>
                                                                            </td>
                                                                        </tr>
                                                                        <% } %>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                        <% } %>
                                            </div>
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