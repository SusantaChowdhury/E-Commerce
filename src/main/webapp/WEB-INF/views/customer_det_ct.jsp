<%@page import="com.example.ecom.model.Orderprod" %>
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
                                    s=(Customer)session.getAttribute("custinfo"); List<Orderprod> op=(List<Orderprod>
                                        )request.getAttribute("cartofcust");
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
                                                            <a href="customerlist"
                                                                class="hover:text-cyan-400 transition">← Back</a>
                                                        </div>
                                                        <div class="flex flex-row justify-center items-center gap-4">
                                                            <a href="customer_det_oh"
                                                                class="hover:text-cyan-400 transition">Orders</a>
                                                            <a href="customer_det_ct"
                                                                class="text-cyan-400 border-b-2">Cart</a>
                                                            <!-- User Dropdown -->
                                                            <div class="relative inline-block text-left mr-2">
                                                                <button id="dropdownButton" onclick="toggleDropdown()"
                                                                    class="h-12 w-12 flex items-center gap-2 px-4 py-2">
                                                                    <% String[]
                                                                        nameParts=admi.getUsername().trim().split("",2);
                                                                        String initials="" ; for (String part :
                                                                        nameParts) { if (!part.isEmpty()) initials
                                                                        +=part.charAt(0); }
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
                                                class="w-[50vw] bg-black/60 backdrop-blur-lg border-gray-700 border-b-4 rounded-2xl shadow-lg p-6 mt-6 text-gray-100 mx-auto">
                                                <h3
                                                    class="text-2xl font-bold text-cyan-400 mb-4 flex items-center gap-2">
                                                    <img src="/images/user.svg" alt="Seller Icon"
                                                        class="h-14 w-14 inline-block shadow-gray-500 rounded-full shadow-md m-2">
                                                    Customer Information
                                                </h3>

                                                <div
                                                    class="grid grid-cols-1  md:grid-cols-2 gap-6 text-sm sm:text-base">
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

                                            <section class="max-w-7xl mx-auto mt-10 px-4">
                                                <div
                                                    class="bg-gray-900 shadow-xl rounded-2xl overflow-hidden border border-gray-700">

                                                    <div
                                                        class="px-6 py-4 border-b rounded-t-2xl bg-gray-900 border-cyan-500">
                                                        <h2 class="text-xl font-semibold text-cyan-400"><%= s.getName() %>'s Cart
                                                        </h2>
                                                    </div>
                                                    <% if(op.isEmpty()){ %>
                                                        <p class="p-6 text-center text-lg text-gray-200">🛒 No items in
                                                            the
                                                            cart
                                                        </p>
                                                        <% } else { double total=0.0; int nobuy=0; %>

                                                            <!-- Table Wrapper -->
                                                            <div
                                                                class="overflow-x-auto shadow-lg border border-gray-700">
                                                                <table
                                                                    class="min-w-full divide-y divide-gray-700 text-sm text-left">
                                                                    <thead
                                                                        class="bg-gray-800 text-cyan-300 text-sm uppercase">
                                                                        <tr>
                                                                            <th class="px-4 py-3">Image</th>
                                                                            <th class="px-4 py-3">Product</th>
                                                                            <th class="px-4 py-3">Seller</th>
                                                                            <th class="px-4 py-3">Customer</th>
                                                                            <th class="px-4 py-3">Quantity</th>
                                                                            <th class="px-4 py-3">Price (₹)</th>
                                                                            <th class="px-4 py-3">Total (₹)</th>
                                                                            <th class="px-4 py-3">Status</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody
                                                                        class="bg-gray-900 text-gray-200 divide-y divide-gray-700">
                                                                        <% for(Orderprod x : op) { int oid=x.getId();
                                                                            String p_name=x.getProduct().getName();
                                                                            String p_pd=x.getProduct().getPd(); Double
                                                                            p_price=x.getProduct().getPrice(); int
                                                                            avlqty=x.getProduct().getQuantity(); int
                                                                            bqty=x.getQty(); String
                                                                            s_name=x.getProduct().getSeller().getName();
                                                                            String
                                                                            s_mail=x.getProduct().getSeller().getEmail();
                                                                            int s_id=x.getProduct().getSeller().getId();
                                                                            Double cost=p_price * bqty; total +=cost;
                                                                            String path=x.getProduct().getImgp(); String
                                                                            statusText="" ; String statusColor="" ; if
                                                                            (avlqty==0) { statusText="Out of Stock" ;
                                                                            statusColor="text-red-400" ; } else if
                                                                            (bqty>
                                                                            avlqty) {
                                                                            statusText = "Qty Exceeds Stock";
                                                                            statusColor = "text-yellow-400";
                                                                            } else {
                                                                            statusText = "Ready to Buy";
                                                                            statusColor = "text-green-400";
                                                                            }
                                                                            %>
                                                                            <tr class="hover:bg-gray-800 transition">
                                                                                <!-- Image -->
                                                                                <td class="px-4 py-3">
                                                                                    <img src="<%=path%>"
                                                                                        alt="Prod <%=oid%>"
                                                                                        class="w-16 h-16 rounded shadow-md object-cover">
                                                                                </td>

                                                                                <!-- Product Info -->
                                                                                <td class="px-4 py-3">
                                                                                    <p
                                                                                        class="font-semibold text-cyan-200">
                                                                                        <%=p_name%>
                                                                                    </p>
                                                                                    <p class="text-sm text-gray-400">
                                                                                        <%=p_pd%>
                                                                                    </p>
                                                                                    <p
                                                                                        class="text-xs text-gray-500 mt-1">
                                                                                        OID: <%=oid%>
                                                                                    </p>
                                                                                </td>

                                                                                <!-- Seller Info -->
                                                                                <td class="px-4 py-3 text-sm">
                                                                                    <p><span
                                                                                            class="text-white">Name:</span>
                                                                                        <%=s_name%>
                                                                                    </p>
                                                                                    <p><span
                                                                                            class="text-white">ID:</span>
                                                                                        <%=s_id%>
                                                                                    </p>
                                                                                    <p class="text-gray-400 text-xs">
                                                                                        <%=s_mail%>
                                                                                    </p>
                                                                                </td>

                                                                                <!-- Customer Info -->
                                                                                <td class="px-4 py-3 text-sm">
                                                                                    <p>
                                                                                        <%=x.getCustomer().getName()%>
                                                                                    </p>
                                                                                    <p>ID: <%=x.getCustomer().getId()%>
                                                                                    </p>
                                                                                    <p class="text-gray-400 text-xs">
                                                                                        <%=x.getCustomer().getEmail()%>
                                                                                    </p>
                                                                                </td>

                                                                                <!-- Qty -->
                                                                                <td class="px-4 py-3">
                                                                                    <p>
                                                                                        <%=bqty%>
                                                                                    </p>
                                                                                    <p class="text-xs text-gray-400">
                                                                                        Available: <%=avlqty%>
                                                                                    </p>
                                                                                </td>

                                                                                <!-- Price -->
                                                                                <td class="px-4 py-3">
                                                                                    ₹<%=p_price%>
                                                                                </td>

                                                                                <!-- Total -->
                                                                                <td
                                                                                    class="px-4 py-3 font-semibold text-cyan-300">
                                                                                    ₹<%=cost%>
                                                                                </td>

                                                                                <!-- Status -->
                                                                                <td class="px-4 py-3">
                                                                                    <span
                                                                                        class="text-sm font-medium <%=statusColor%>">
                                                                                        <%=statusText%>
                                                                                    </span>
                                                                                </td>
                                                                            </tr>
                                                                            <% } %>
                                                                    </tbody>
                                                                </table>
                                                            </div>

                                                            <!-- Total Amount -->
                                                            <div
                                                                class="text-right mt-6 text-xl font-bold text-cyan-400">
                                                                Total Cart Value: ₹ <%= total %>
                                                            </div>
                                                            <% } %>
                                                </div>
                                            </section>

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