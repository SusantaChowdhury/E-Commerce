<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="com.example.ecom.model.Seller" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Add Product</title>
            <link rel="icon" href="/images/SwiftMart.ico" type="image/x-icon" />
            <link rel="stylesheet" href="/css/output.css" />
        </head>
        <% Seller c=(Seller)session.getAttribute("seller"); int seller_id=c.getId(); String sellrname=c.getName();
            String sellrperm=c.getPerm(); %>

            <body class=" bg-gradient-to-b from-cyan-600 to-purple-950 text-white min-h-screen flex flex-col
                    justify-between">

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
                                class="hover:text-cyan-400 font-medium transition">Pending
                                Permissions</a>
                            <a href="seller_add_product" class="text-cyan-400 font-medium border-b-2">Add
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

                        <h2 class="text-lg font-semibold text-amber-300">Your request to do business is being
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

                        <!-- Message -->
                        <section class="py-6 px-4 text-center">
                            <h2 class="text-2xl font-bold">Add Your Product</h2>
                        </section>

                        <% String getm=String.valueOf(request.getAttribute("addProdmsg")); 
                            if(getm.equals("Added")) { %>
                            <p
                                class="w-1/2 bg-green-100 mx-auto m-2 border-green-400 border-2 rounded text-lg text-green-500 font-bold text-center">
                                Product added successfully!</p>
                            <% } else if(!getm.equals("null")) { %>
                                <p class="text-red-600 font-medium">
                                    <%= getm %>
                                </p>
                            <% } %>

                                    <!-- Product Registration Form -->
                                    <section class="px-4">
                                        <div
                                            class="max-w-xl mx-auto bg-gray-800/40 p-6 border-b-4 border-gray-800 backdrop-blur-lg rounded-xl shadow-lg">
                                            <form action="RegisterProduct" method="post" enctype="multipart/form-data"
                                                class="space-y-5">
                                                <div>
                                                    <div class="bg-gray-700 rounded p-2 mb-1 border-amber-500 border">
                                                        <p class="text-md text-yellow-400"><span
                                                                class="text-md font-semibold underline">Warning:</span>
                                                            You can only add quantity once this product is enlisted. All
                                                            other details can't be edited later!</p>
                                                    </div>
                                                    <label class="block font-medium mb-1">Upload Product
                                                        Image</label>
                                                    <input type="file" name="product_image" accept="image/*" required
                                                        class="block w-full text-sm border file:w-26 file:p-1 file:bg-slate-900 file:m-1.5 file:rounded file:text-white hover:file:bg-slate-800 border-gray-400 rounded-md transition-all">
                                                    <p class="text-gray-400 text-sm mt-1">Accepted formats: .jpg,
                                                        .jpeg,
                                                        .png</p>
                                                </div>
                                                <div>
                                                    <label class="block font-medium mb-1">Product Name</label>
                                                    <input type="text" name="prod_name" placeholder="Product Name"
                                                        required class="w-full border border-gray-400 rounded-md p-2">
                                                </div>
                                                <div>
                                                    <label class="block font-medium mb-1">Product Price (in
                                                        Rs.)</label>
                                                    <input type="text" name="product_price" placeholder="100.00"
                                                        required class="w-full border border-gray-400 rounded-md p-2">
                                                </div>
                                                <div>
                                                    <label class="block font-medium mb-1">Product
                                                        Description</label>
                                                    <textarea name="product_pd"
                                                        placeholder="Describe your product in 300-500 characters"
                                                        rows="2" required
                                                        class="w-full border border-gray-400 rounded-md p-2"></textarea>
                                                </div>
                                                <div>
                                                    <label class="block font-medium mb-1">Product Quantity</label>
                                                    <input type="text" name="prod_quant" placeholder="Minimum 1"
                                                        required class="w-full border border-gray-400 rounded-md p-2">
                                                </div>
                                                <button type="submit"
                                                    class="bg-blue-600 text-white px-6 py-2 rounded-md hover:bg-blue-700 transition">Submit</button>
                                            </form>
                                        </div>
                                    </section>
                        <% } %>

                                        <!-- footer -->
                                        <footer class="rounded-lg shadow-sm bg-gray-900 m-4">
                                            <div class="w-full max-w-screen-xl mx-auto p-4 md:py-8">
                                                <div class="sm:flex sm:items-center sm:justify-between">
                                                    <a href="seller_add_product"
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
                                                    2025
                                                    <a href="https://flowbite.com/"
                                                        class="hover:underline">SwiftMart™</a>.
                                                    All
                                                    Rights Reserved.</span>
                                            </div>
                                        </footer>
                                        <script src="/js/script.js"></script>

            </body>
    </html>