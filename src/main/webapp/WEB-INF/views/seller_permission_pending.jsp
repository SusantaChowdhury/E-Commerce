<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.example.ecom.model.Seller" %>
        <%@ page import="com.example.ecom.model.Product" %>
            <%@ page import="java.util.List" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Product Permission Pending</title>
                    <link rel="icon" href="/images/SwiftMart.ico" type="image/x-icon" />
                    <link rel="stylesheet" href="/css/output.css" />
                </head>

                <% Seller c=(Seller) session.getAttribute("seller"); String sellrname=c.getName(); String
                    sellrperm=c.getPerm(); %>

                    <body
                        class="bg-gradient-to-b from-cyan-600 to-purple-950 text-white min-h-screen flex flex-col justify-between">

                        <!-- Navbar -->
                        <nav class="bg-gray-900 w-full text-gray-100 px-4 shadow-md">
                            <div class="flex flex-wrap justify-between items-center py-2">
                                <a href="sellerhome" class="flex m-4 items-center space-x-3 rtl:space-x-reverse">
                                    <img src="/images/SwiftMart.png" class="h-16 rounded-2xl" alt="SwiftMart Logo" />
                                    <span
                                        class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                                </a>
                                <div
                                    class="flex flex-wrap justify-center items-center lg:gap-4 sm:gap-20 text-lg font-medium p-2">
                                    <a href="sellerhome" class="hover:text-cyan-400 font-medium transition">My
                                        Products</a>
                                    <a href="seller_permission_pending"
                                        class="text-cyan-400 font-medium border-b-2">Pending
                                        Permissions</a>
                                    <a href="seller_add_product" class="hover:text-cyan-400 font-medium transition">Add
                                        Product</a>
                                    <!-- User Dropdown -->
                                    <div class="relative inline-block text-left mr-2">
                                        <button id="dropdownButton" onclick="toggleDropdown()"
                                            class="h-12 w-12 flex items-center gap-2 px-4 mr-2 py-2">
                                            <% String[] nameParts=sellrname.trim().split(" "); String initials = ""; for (String part : nameParts) { if (!part.isEmpty()) initials += part.charAt(0); } initials = initials.toUpperCase(); %>
                                                    <div class=" flex items-center justify-center rounded-full p-1
                                                border-white border-3 bg-cyan-400 text-gray-700 font-semibold text-2xl">
                                                <%= initials %>


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
                        <!-- For Unapproved Seller -->
                        <% if(sellrperm.equals("NO")){ %>
                            <h1 class="text-2xl font-bold text-center m-4">Welcome to SwiftMart, <%=sellrname%>!
                            </h1>
                            <div
                                class="flex flex-col m-10 items-center rounded-xl justify-center bg-gray-800/40 backdrop:blur-xl border-b-4 border-gray-800 shadow-xl p-6 text-gray-200 hover:shadow-2xl hover:-translate-y-1 transition">

                                <h2 class="text-lg font-semibold text-amber-300">Your request to do business is
                                    being
                                    evaluated. Please wait for our team to verify your account.</h2>
                                <img src="/images/unverified.svg" class="h-auto w-1/2 rounded-xl mt-4 mb-6"
                                    alt="Unapproved Seller" />

                                <div class="mb-4">
                                    <p class="text-gray-300 text-center">Visit this page sometimes later!</p>
                                </div>
                                <div class="mb-4">
                                    <p class="text-gray-300 text-center">Thank you for your cooperation.</p>
                                </div>

                            </div>
                            <!-- For Approved seler -->
                            <% }else{ %>
                                <h2 class="text-2xl font-bold text-center m-2">Products that are pending for approval
                                </h2>

                                <main class="p-6">
                                    <section class="grid grid-cols-2 md:grid-cols-2 lg:grid-cols-4 gap-6">
                                        <% List<Product> perm_pd = (List<Product>)request.getAttribute("prod_Wo_perm");
                                            if (perm_pd.isEmpty()) {%>
                                                <div
                                                    class="col-span-full mx-10 py-4 bg-gray-800/40 backdrop-blur-lg rounded-lg justify-center items-center text-center text-lg">
                                                    <img src="/images/empty-box.svg" alt="No Products"
                                                        class="w-1/2 h-auto mx-auto">
                                                    <p class="text-center text-lg text-amber-300 m-2">No products
                                                    pending for permission at the moment. <a src="seller_add_product"
                                                            class="underline hover:text-white">Click here</a> to add
                                                        product.</p>
                                                </div>
                                            <% } else { 
                                                    for (Product x : perm_pd) { 
                                                    int p_id=x.getId(); 
                                                    String p_name=x.getName(); 
                                                    String p_pd=x.getPd(); 
                                                    Double p_price=x.getPrice(); 
                                                    int p_quant=x.getQuantity(); 
                                                    String path=x.getImgp(); %>
                                                    <div
                                                        class="bg-gray-800/50 backdrop-blur-lg shadow-lg rounded-xl overflow-hidden p-4 flex flex-col items-center text-center hover:-translate-y-1 transition-all">
                                                        <img src="<%= path %>" alt="Product <%= p_name %>"
                                                            class="w-full h-auto object-cover rounded mb-4" />
                                                        <h3 class="text-xl font-semibold text-gray-100 mb-1">
                                                            <%= p_name %>
                                                        </h3>
                                                        <p class="text-gray-300 text-sm mb-2">
                                                            <%= p_pd %>
                                                        </p>
                                                        <div
                                                            class="w-full mx-2 flex flex-row items-center justify-between">
                                                            <p class="text-lg font-bold text-yellow-400 mb-2">
                                                                ₹<%= p_price %>
                                                            </p>
                                                            <p class="text-sm text-gray-300 mb-2">Remaining: <span
                                                                    class="font-bold">
                                                                    <%= p_quant %>
                                                                </span></p>
                                                        </div>

                                                        </span>
                                                        <form action="editsellrproddet" method="post" class="w-full">
                                                            <input type="hidden" name="prod_id" value="<%= p_id %>">
                                                            <button type="submit"
                                                                class="w-full bg-blue-500 hover:bg-blue-600 text-white py-2 rounded transition duration-200">
                                                                Edit Details
                                                            </button>
                                                        </form>
                                                    </div>
                                                    <% } }%>
                                    </section>
                                <% } %>   
                            </main>
                            <!-- footer -->
                                <footer class="rounded-lg shadow-sm bg-gray-900 m-4">
                                    <div class="w-full max-w-screen-xl mx-auto p-4 md:py-8">
                                        <div class="sm:flex sm:items-center sm:justify-between">
                                            <a href="seller_permission_pending"
                                                class="flex items-center mb-4 sm:mb-0 space-x-3 rtl:space-x-reverse">
                                                <img src="images/SwiftMart.png" class="h-12 rounded-xl"
                                                    alt="SwiftMart Logo" />
                                                <span
                                                    class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-2xl text-transparent font-sans font-semibold whitespace-nowrap">SwiftMart™</span>
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
                            <script src="/js/script.js"></script>
                            <script>
                                setInterval(function () {
                                    location.reload();
                                }, 5000);
                            </script>
                    </body>
                </html>