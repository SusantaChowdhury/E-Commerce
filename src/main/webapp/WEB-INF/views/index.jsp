<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Welcome to SwiftMart™</title>
        <link rel="icon" href="/images/SwiftMart.ico" type="image/x-icon" />
        <link rel="stylesheet" href="/css/output.css" />
    </head>

    <body class="bg-gradient-to-b from-cyan-600 to-purple-950 min-h-screen flex flex-col bg-cover items-center">
        <!-- navbar -->
        <nav class="bg-gray-900 w-full text-gray-100 px-4">

            <div class="flex flex-wrap justify-between items-center my-2">
                <a href="/" class="flex m-4 items-center space-x-3 rtl:space-x-reverse">
                    <img src="/images/SwiftMart.png" class="h-16 rounded-2xl" alt="SwiftMart Logo" />
                    <span
                        class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                </a>
                <div class="flex justify-center items-center text-lg font-medium gap-3">
                    <a href="/" class="px-1 border-b-2 text-cyan-500">Home</a>
                    <a href="aboutus" class="px-1 hover:text-cyan-500 transition">About</a>
                    <a href="contactus" class="px-1 hover:text-cyan-500 transition">Contact
                        Us</a>
                    <a href="Adminpage" class="px-1 hover:text-cyan-500 transition">Admin</a>
                </div>
            </div>
        </nav>

        <div class="flex flex-col items-center justify-center mt-8">
            <h1 class="text-4xl font-semibold text-white mb-4 font-mono">Welcome to <span
                    class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-transparent font-sans font-bold">SwiftMart™</span>
            </h1>
            <p class="text-lg text-gray-200 mb-6">Your one-stop shop for everything you need!</p>

        </div>

        <!-- Hero Section -->
        <section class="w-[90vw] backdrop-blur-lg bg-[url(/images/shop.jpg)] bg-cover text-center rounded-lg mt-6">
            <!-- Login Cards -->
            <div class="py-10 mb-4 text-center">
                <div
                    class="max-w-xl mx-auto grid grid-cols-1 sm:grid-cols-2 gap-16 justify-around justify-items-center">
                    <!-- Seller Login -->
                    <div
                        class="bg-gray-900/40 backdrop-blur-sm border border-gray-200 shadow-xl hover:bg-gray-900/50 hover:shadow-2xl hover:-translate-y-1 transition-all duration-300 rounded-xl p-4 w-full max-w-sm text-center">
                        <div class="mx-auto mb-6 text-center">
                            <img src="/images/seller.svg" class="">
                        </div>
                        <h2 class="text-2xl font-semibold text-white mb-2">Wanna Sell?</h2>
                        <p class="text-sm text-gray-200 mb-6">Manage inventory, track orders, and grow your
                            business.
                        </p>
                        <button onclick="location.href='seller_login'"
                            class="w-full border bg-blue-700 hover:bg-blue-600 text-white py-2 rounded-lg font-medium transition">
                            Login as Seller
                        </button>
                    </div>

                    <!-- Customer Login -->
                    <div
                        class="bg-gray-900/40 backdrop-blur-sm border border-gray-200 shadow-xl hover:bg-gray-900/50 hover:shadow-2xl hover:-translate-y-1 transition-all duration-300 rounded-xl p-4 w-full max-w-sm text-center">
                        <div class="mx-auto lg:mt-4 md:mt-6 mb-6 text-center">
                            <img src="/images/customer.svg" class="mt-14">
                        </div>

                        <h2 class="text-2xl font-semibold text-white mt-12">Wanna Buy?</h2>
                        <p class="text-sm text-gray-200 mt-3">Browse thousands of products, add to
                            cart,
                            and
                            checkout
                            easily.</p>
                        <button onclick="location.href='customer_login'"
                            class="w-full border bg-blue-700 mt-5 hover:bg-blue-600 text-white py-2 rounded-lg font-medium transition">
                            Login as Customer
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- footer -->
        <footer class="rounded-lg shadow-sm bg-gray-900 m-4" style="width: 96vw;">
            <div class="w-full max-w-screen-xl mx-auto p-4 md:py-8">
                <div class="sm:flex sm:items-center sm:justify-between">
                    <a href="/" class="flex items-center mb-4 sm:mb-0 space-x-3 rtl:space-x-reverse">
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
                    <a href="/" class="hover:underline">SwiftMart™</a>. All
                    Rights Reserved.</span>
            </div>
        </footer>
    </body>

    </html>