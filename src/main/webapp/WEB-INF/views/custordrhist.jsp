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
                                        <div>
                                            <div>
                                            <div class="flex flex-col  justify-between items-center min-h-screen">
                                                <!-- Navbar -->
                                                <nav class="w-full bg-gray-900 text-gray-100 px-4 shadow">
                                                    <div class="flex flex-wrap justify-between items-center py-2">
                                                        <!-- Logo -->
                                                        <a href="customerhome" class="flex m-2 items-center space-x-3">
                                                            <img src="/images/SwiftMart.png"
                                                                class="h-14 rounded-xl shadow-lg"
                                                                alt="SwiftMart Logo" />
                                                            <span
                                                                class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                                                        </a>

                                                        <!-- Navigation Links -->
                                                        <div class="flex gap-4 items-center text-sm sm:text-base">
                                                            <a href="customerhome"
                                                                class="py-1 hover:text-cyan-400 font-medium">Products</a>
                                                            <a href="custcart"
                                                                class="py-1 hover:text-cyan-400 font-medium">Cart</a>
                                                            <a href="custordrhist"
                                                                class="text-cyan-400 border-b-3">Orders</a>

                                                            <!-- User Dropdown -->
                                                            <div class="relative inline-block text-left mr-2">
                                                                <button id="dropdownButton" onclick="toggleDropdown()"
                                                                    class="h-12 w-12 flex items-center gap-2 px-4 py-2">
                                                                    <% String[]
                                                                        nameParts=custname.trim().split(" "); String initials = ""; for (String part : nameParts) { if (!part.isEmpty()) initials += part.charAt(0); } initials = initials.toUpperCase(); %>
                            <div class=" flex items-center justify-center rounded-full p-1 border-white border-3
                                                                        bg-cyan-400 text-gray-700 font-semibold text-2xl
                                                                        shadow">
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

                                            <div class="w-[90vw] mx-auto">
                                                <h2 class="text-3xl font-bold my-6 text-center text-gray-200">Your Order
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

                                                            <div class="w-full rounded overflow-x-auto">
                                                                <table
                                                                    class="min-w-full rounded-lg bg-gray-800/50 backdrop-blur-xl shadow-md">
                                                                    <thead
                                                                        class="bg-slate-800 text-base font-semibold text-white">
                                                                        <tr class="text-center">
                                                                            <th class="py-3 px-4 ">Image</th>
                                                                            <th class="py-3 px-4 ">Product</th>
                                                                            <th class="py-3 px-4 ">Details</th>
                                                                            <th class="py-3 px-4 ">Seller</th>
                                                                            <th class="py-3 px-4 ">Qty</th>
                                                                            <th class="py-3 px-4 ">Price</th>
                                                                            <th class="py-3 px-4 ">Subtotal</th>
                                                                            <th class="py-3 px-4 ">Date & Time</th>
                                                                            <th class="py-3 px-4 ">Status</th>
                                                                            <th class="py-3 px-4 ">Action</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <% for(Orderhist x : op) { int oid=x.getId();
                                                                            String p_name=x.getProductname(); String
                                                                            p_pd=x.getProductdesc(); Double
                                                                            p_price=x.getProductprice(); int
                                                                            bqty=x.getBqty(); String
                                                                            s_name=x.getSellername(); Double
                                                                            cost=p_price * bqty; String
                                                                            dt=x.getDatetime(); Double
                                                                            taken=x.getTaken(); Double
                                                                            ref=x.getRefunded(); String
                                                                            statusw=x.getOrderstatus(); String
                                                                            statusmessage="" ;
                                                                            if("completed".equals(statusw)){
                                                                            statusmessage=(ref> 0.0) ? "Refunded" :
                                                                            "Transaction done";
                                                                            } else if("cancelled".equals(statusw)){
                                                                            statusmessage = "Cancelled";
                                                                            } else if("tfailed".equals(statusw) && ref >
                                                                            0){
                                                                            statusmessage = "Transaction failed";
                                                                            } else if("appeal".equals(statusw) ||
                                                                            "cnc".equals(statusw)){
                                                                            statusmessage = "Cancel Requested";
                                                                            } else {
                                                                            statusmessage = "Ongoing";
                                                                            }
                                                                            %>
                                                                            <tr
                                                                                class="hover:bg-gray-800/50 transition border-gray-400 border-t-1 duration-200 text-gray-200 text-center">
                                                                                <td class="py-3 px-4">
                                                                                    <img src="<%= x.getOimg() %>"
                                                                                        alt="Order <%= oid %>"
                                                                                        class="w-full h-auto object-cover rounded" />
                                                                                </td>
                                                                                <td
                                                                                    class="py-3 px-4 font-semibold max-w-xs truncate">
                                                                                    <%= p_name %>
                                                                                </td>
                                                                                <td
                                                                                    class="py-3 px-4 text-sm text-gray-300 max-w-xs truncate">
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
                                                                                    class="py-3 px-4 font-semibold text-green-400">
                                                                                    ₹<%= cost %>
                                                                                </td>
                                                                                <td class="py-3 px-4 text-sm">
                                                                                    <%= dt %>
                                                                                </td>
                                                                                <% String statusColor="Ongoing"
                                                                                    .equals(statusmessage)
                                                                                    ? "text-yellow-600"
                                                                                    : "text-green-400" ; %>
                                                                                    <td
                                                                                        class="py-3 px-4 font-medium <%= statusColor %>">
                                                                                        <%= statusmessage %>
                                                                                    </td>
                                                                                    <td class="py-3 px-4 text-center">
                                                                                        <% if("ongoing".equals(statusw))
                                                                                            { %>
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
                                                                                                    class="text-gray-300 text-sm">Non-cancellable</span>
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
                                            <footer class="w-[95vw] rounded-lg shadow-sm bg-gray-900 m-4">
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
                                                                <a href="#"
                                                                    class="hover:underline me-4 md:me-6">About</a>
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

                                            setInterval(function () {
                                                location.reload();
                                            }, 5000);
                                        </script>
                                    </body>

                                </html>