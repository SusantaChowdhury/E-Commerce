<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="com.example.ecom.model.Seller" %>
        <%@page import="com.example.ecom.model.Product" %>
            <%@page import="java.util.List" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Seller Home</title>
                    <link rel="icon" href="/images/SwiftMart.ico" type="image/x-icon" />
                    <link rel="stylesheet" href="css/output.css" />
                </head>
                <%Seller c=(Seller)session.getAttribute("seller"); String sellrname=c.getName(); String
                    sellrperm=c.getPerm(); %>

                    <body
                        class="bg-gradient-to-b from-cyan-600 to-purple-950 min-h-screen text-white font-sans flex flex-col">
                        <!-- Navbar -->
                        <nav class="bg-gray-900 text-gray-100 px-4 shadow">
                            <div class="flex flex-wrap justify-between items-center py-2">
                                <!-- Logo -->
                                <a href="sellerhome" class="flex m-2 items-center space-x-3">
                                    <img src="/images/SwiftMart.png" class="h-14 rounded-xl shadow-lg"
                                        alt="SwiftMart Logo" />
                                    <span
                                        class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                                </a>

                                <!-- Navigation Links -->
                                <div class="flex gap-4 items-center text-sm sm:text-base">
                                    <a href="sellerhome" class="text-cyan-400 border-b-3 font-medium">My Products</a>
                                    <a href="seller_permission_pending"
                                        class="hover:text-cyan-400 font-medium transition">Pending
                                        Permissions</a>
                                    <a href="seller_add_product" class="hover:text-cyan-400 font-medium transition">Add
                                        Product</a>

                                    <!-- User Dropdown -->
                                    <div class="relative inline-block text-center mr-2">
                                        <button id="dropdownButton" onclick="toggleDropdown()"
                                            class="h-12 w-12 flex items-center gap-2 px-4 py-2">
                                            <% String[] nameParts=sellrname.trim().split(" "); String initials = ""; for (String part : nameParts) { if (!part.isEmpty()) initials += part.charAt(0); } initials = initials.toUpperCase(); %>
                            <div class=" flex items-center justify-center rounded-full p-1 border-white border-3
                                                bg-cyan-400 text-gray-700 font-semibold text-2xl">
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

                        <!-- For Unapproved Seller -->
                        <%if(sellrperm.equals("NO")){ %>
                            <h1 class="text-2xl font-bold text-center m-4">Welcome to SwiftMart, <%=sellrname%>!👋
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
                                    <h2 class="font-bold text-2xl text-white">Hello there!👋 </h2>
                                    <h2 class="font-bold text-2xl text-white">Here you can view and manage your
                                        products.
                                    </h2>
                                </section>

                                <!-- Product Section -->
                                <div class=" p-6 rounded-lg">
                                    <section
                                        class="products grid grid-cols-2 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                                        <% List<Product> perm_pd = (List<Product>)
                                                request.getAttribute("prod_W_perm");
                                                if (perm_pd.isEmpty()) {
                                                %>
                                                <div
                                                    class="col-span-full mx-10 py-4 bg-gray-800/40 backdrop-blur-lg rounded-lg justify-center items-center text-center text-lg">
                                                    <img src="/images/empty-box.svg" alt="No Products"
                                                        class="w-1/2 h-auto mx-auto">
                                                    <p class="text-center text-lg text-amber-300 m-2">You haven't
                                                        enlisted any products yet! <a src="seller_add_product"
                                                            class="underline hover:text-white">Click here</a> to add
                                                        product.</p>
                                                    <p class="text-center text-amber-300 m-2">If already enlisted,
                                                        wait
                                                        for them
                                                        to be verified!</p>

                                                </div>

                                                <% } else { for (Product x : perm_pd) { int p_id=x.getId(); String
                                                    p_name=x.getName(); String p_pd=x.getPd(); Double
                                                    p_price=x.getPrice(); int p_quant=x.getQuantity(); String
                                                    path=x.getImgp(); %>
                                                    <div
                                                        class="bg-gray-800/40 backdrop-blur-xl rounded-xl shadow-xl hover:shadow-2xl transition-all duration-300 p-4 flex flex-col items-center text-center">
                                                        <img src="<%=path%>" alt="Product <%=p_name%>"
                                                            class="w-full h-auto object-cover rounded">
                                                        <h3 class="text-lg font-semibold text-gray-100">
                                                            <%=p_name%>
                                                        </h3>
                                                        <p class="text-gray-300 mb-1 text-left">
                                                            <%=p_pd%>
                                                        </p>
                                                        <p class="text-sm text-amber-500 mb-2">Remaining:
                                                            <%=p_quant%>
                                                        </p>
                                                        <span class="text-lg font-bold text-green-600 mb-4">₹
                                                            <%=p_price%>
                                                        </span>
                                                        <form action="slctslrhmprod" method="post" class="w-full">
                                                            <input type="hidden" name="prod_id" value="<%=p_id%>">
                                                            <button type="submit"
                                                                class="w-full bg-blue-600 text-white font-semibold py-2 rounded-md hover:bg-blue-700 transition duration-200">
                                                                Add Quantity
                                                            </button>
                                                        </form>
                                                    </div>
                                                    <% } %>
                                    </section>
                                    <%}}%>
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
                                <%%>
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

                                        // setInterval(function () {
                                        //     location.reload();
                                        // }, 5000);
                                    </script>
                    </body>


                </html>