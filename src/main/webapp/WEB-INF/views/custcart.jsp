<%@page import="com.example.ecom.model.Orderprod" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@page import="com.example.ecom.model.Seller" %>
            <%@page import="com.example.ecom.model.Product" %>
                <%@page import="com.example.ecom.model.Customer" %>
                    <%@page import="com.example.ecom.model.Orderprod" %>
                        <%@page import="java.util.List" %>
                            <!DOCTYPE html>
                            <html>

                            <head>
                                <meta charset="UTF-8">
                                <link rel="icon" href="/images/SwiftMart.ico" type="image/x-icon" />
                                <title>Your Cart</title>
                                <link rel="stylesheet" href="css/output.css" />
                            </head>
                            <% Customer c=(Customer)session.getAttribute("customer"); int custid=c.getId(); String
                                custname=c.getName(); %>

                                <body class="min-h-screen"
                                    style="background-image: linear-gradient(to top, rgb(81, 3, 81), rgb(37, 197, 197));">

                                    <!-- Navbar -->
                                    <nav class="bg-gray-900 text-gray-100 px-4 shadow">
                                        <div class="flex flex-wrap justify-between items-center py-2">
                                            <!-- Logo -->
                                            <a href="customerhome" class="flex m-2 items-center space-x-3">
                                                <img src="/images/SwiftMart.png" class="h-14 rounded-xl shadow-lg"
                                                    alt="SwiftMart Logo" />
                                                <span
                                                    class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                                            </a>

                                            <!-- Navigation Links -->
                                            <div class="flex gap-4 items-center text-sm sm:text-base">
                                                <a href="customerhome"
                                                    class="hover:text-cyan-400 font-medium">Products</a>
                                                <a href="custcart" class="text-cyan-400 border-b-2">Cart</a>
                                                <a href="custordrhist"
                                                    class="py-1 hover:text-cyan-400 font-medium">Orders</a>

                                                <!-- User Dropdown -->
                                                <div class="relative inline-block text-left mr-2">
                                                    <button id="dropdownButton" onclick="toggleDropdown()"
                                                        class="h-12 w-12 flex items-center gap-2 px-4 py-2">
                                                        <% String[]
                                                            nameParts=custname.trim().split(" "); String initials = ""; for (String part : nameParts) { if (!part.isEmpty()) initials += part.charAt(0); } initials = initials.toUpperCase(); %>
                            <div class=" flex items-center justify-center rounded-full p-1 border-white border-3
                                                            bg-cyan-400 text-gray-700 font-semibold text-2xl shadow">
                                                            <%= initials %>
                                                </div>
                                                <!-- <span class="hidden text-white font-medium">
                                            <%= custname %>
                                        </span> -->
                                                <!-- <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor"
                                            stroke-width="2" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7">
                                            </path>
                                        </svg> -->
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

                                    <!-- Cart Section -->
                                    <div class="py-6">
                                        <h2 class="text-3xl font-bold my-6 text-center text-gray-100">Products in your
                                            cart</h2>

                                        <% List<Orderprod> op = (List<Orderprod>) request.getAttribute("cartprods"); %>
                                                <% if (op.isEmpty()) { %>
                                                    <div
                                                        class="w-[55vw] mx-auto flex flex-col items-center bg-gray-800/40 backdrop-blur-lg border-gray-800 border-b-4 m-10 rounded-xl shadow-xl text-center text-lg text-amber-400 font-semibold mt-1">
                                                        <img src="/images/empty-cart.svg" alt="Empty Cart"
                                                            class="lg:w-[35vw] h-auto">
                                                        <p class="mb-4 p-2 ">No products in your cart right now.</p>
                                                        <a type="button" href="customerhome"
                                                            class="bg-blue-600 m-4 hover:bg-blue-700 text-white font-semibold px-6 py-2 rounded-md shadow-md">
                                                            Keep Shopping</a>
                                                    </div>
                                                    <% } else { %>

                                                        <!-- Table -->
                                                        <div
                                                            class="mt-6 m-8 rounded-lg overflow-x-auto">
                                                            <table class="min-w-full rounded-lg text-md sm:text-base">
                                                                <thead
                                                                    class="bg-slate-800 rounded text-gray-100 text-base font-semibold">
                                                                    <tr class="text-center">
                                                                        <th class="px-6 py-4">Image</th>
                                                                        <th class="px-6 py-4">Product</th>
                                                                        <th class="px-6 py-4">Description</th>
                                                                        <th class="px-6 py-4">Seller</th>
                                                                        <th class="px-6 py-4">Available</th>
                                                                        <th class="px-6 py-4">Price</th>
                                                                        <th class="px-6 py-4">Quantity</th>
                                                                        <th class="px-6 py-4">Cost</th>
                                                                        <th class="px-6 py-4">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <% double total=0.0; int nobuy=0; for (Orderprod x :
                                                                        op) { int oid=x.getId(); String
                                                                        p_name=x.getProduct().getName(); String
                                                                        p_pd=x.getProduct().getPd(); Double
                                                                        p_price=x.getProduct().getPrice(); int
                                                                        avlqty=x.getProduct().getQuantity(); int
                                                                        bqty=x.getQty(); String
                                                                        s_name=x.getProduct().getSeller().getName();
                                                                        Double cost=p_price * bqty; total +=cost; String
                                                                        path=x.getProduct().getImgp(); String message=""
                                                                        ; boolean disableBuy=false; if (avlqty==0) {
                                                                        message="Out of stock" ; nobuy++;
                                                                        disableBuy=true; } else if (bqty> avlqty) {
                                                                        message = "Insufficient stock"; nobuy++;
                                                                        disableBuy = true; }
                                                                        %>
                                                                        <tr
                                                                            class="bg-gray-800/50 backdrop-blur-xl border-gray-300 border-t text-gray-200 text-center hover:bg-gray-800/60 transition-all ">
                                                                            <td class="py-3 px-4">
                                                                                <img src="<%= path %>"
                                                                                    alt="Order <%= oid %>"
                                                                                    class="w-full h-auto object-cover rounded shadow-md mx-auto" />
                                                                            </td>
                                                                            <td
                                                                                class="px-4 py-4 font-semibold max-w-xs truncate">
                                                                                <%= p_name %>
                                                                            </td>
                                                                            <td
                                                                                class="px-4 py-4 text-sm max-w-xs truncate">
                                                                                <%= p_pd %>
                                                                            </td>
                                                                            <td class="px-4 py-4 text-sm">
                                                                                <%= s_name %>
                                                                            </td>
                                                                            <td class="px-4 py-4">
                                                                                <%= avlqty %>
                                                                            </td>
                                                                            <td class="px-4 py-4 font-semibold">₹<%=
                                                                                    p_price %>
                                                                            </td>
                                                                            <td class="px-4 py-4">
                                                                                <div
                                                                                    class="flex border rounded-lg overflow-hidden justify-center items-center gap-2">
                                                                                    <form action="Subprodcartval"
                                                                                        method="post">
                                                                                        <input type="hidden"
                                                                                            name="order_id"
                                                                                            value="<%= oid %>">
                                                                                        <button
                                                                                            class="bg-gray-500 hover:bg-gray-600 text-gray-100 px-2 py-1 rounded-l text-md">−</button>
                                                                                    </form>
                                                                                    <input type="text"
                                                                                        value="<%= bqty %>" readonly
                                                                                        class="text-center text-sm"
                                                                                        style="width: 25px; height: 25px;" />
                                                                                    <form action="Addprodcartval"
                                                                                        method="post">
                                                                                        <input type="hidden"
                                                                                            name="order_id"
                                                                                            value="<%= oid %>">
                                                                                        <button
                                                                                            class="bg-gray-500 hover:bg-gray-600 text-gray-100 px-2 py-1 rounded-r text-md">+</button>
                                                                                    </form>
                                                                                </div>
                                                                            </td>
                                                                            <td
                                                                                class="px-4 py-4 text-green-400 font-medium">
                                                                                ₹<%= cost %>
                                                                            </td>
                                                                            <td class="px-4 py-4">
                                                                                <form action="Delcart" method="post">
                                                                                    <input type="hidden" name="order_id"
                                                                                        value="<%= oid %>">
                                                                                    <button type="submit"
                                                                                        class="bg-red-500 hover:bg-red-600 border-gray-100 border text-white flex items-center justify-center gap-1 px-4 py-2 rounded-lg font-semibold text-md">
                                                                                        <img src="/images/bin.png"
                                                                                            alt="Delete"
                                                                                            class="h-4 w-4" />
                                                                                        Remove
                                                                                    </button>
                                                                                </form>
                                                                                <% if (!message.isEmpty()) { %>
                                                                                    <p
                                                                                        class="text-red-600 text-sm mt-1">
                                                                                        <%= message %>
                                                                                    </p>
                                                                                    <% } %>
                                                                            </td>
                                                                        </tr>
                                                                        <% } %>
                                                                </tbody>
                                                            </table>
                                                        </div>

                                                        <% if (nobuy==0) { %>
                                                            <!-- Total and Buy Now -->
                                                            <div
                                                                class="flex flex-col sm:flex-row justify-center items-center mt-6 gap-4">
                                                                <p class="text-xl font-semibold text-green-500">Total: ₹
                                                                    <%= total %>
                                                                </p>
                                                                <form action="Buynowset" method="post">
                                                                    <input type="hidden" name="cust_id"
                                                                        value="<%= custid %>">
                                                                    <button type="submit"
                                                                        class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-6 py-2 rounded-md shadow">
                                                                        Buy Now
                                                                    </button>
                                                                </form>
                                                            </div>
                                                            <% } %>
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
                                                        <a href="#" class="hover:underline me-4 md:me-6">Licensing</a>
                                                    </li>
                                                    <li>
                                                        <a href="#" class="hover:underline">Contact</a>
                                                    </li>
                                                </ul>
                                            </div>
                                            <hr class="my-6 border-gray-200 sm:mx-auto dark:border-gray-700 lg:my-8" />
                                            <span
                                                class="block text-sm text-gray-500 sm:text-center dark:text-gray-400">©
                                                2023
                                                <a href="https://flowbite.com/" class="hover:underline">SwiftMart™</a>.
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