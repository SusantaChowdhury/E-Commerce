<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>About Us</title>
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
                    <a href="/" class="px-1 hover:text-cyan-500 transition">Home</a>
                    <a href="aboutus" class="px-1 border-b-2 text-cyan-500">About</a>
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
        <!-- abount section -->
        <section
            class="m-6 flex flex-col justify-center items-center bg-[url(/images/shop.jpg)] bg-cover text-center rounded-lg">
            <div
                class="bg-gray-800/50 w-fit backdrop-blur-md border text-white py-10 px-4 m-12 rounded-lg text-center shadow-2xl">
                <h2 class="text-3xl text-black font-semibold mb-6">About Us</h2>
                <p class="text-lg mb-6">At <span class="font-semibold underline">SwiftMart</span>, we are dedicated to
                    providing
                    you with the best
                    shopping experience. Our platform connects buyers and sellers seamlessly, offering a wide range of
                    products at competitive prices.</p>
                <p class="text-lg mb-6">Whether you're looking for electronics, clothing, groceries, or
                    anything in between, SwiftMart™ has got you covered. Our user-friendly interface and secure payment
                    options ensure a hassle-free shopping journey.</p>
                <p class="text-lg mb-6">Join us today and discover the convenience of online shopping with
                    <span class="font-semibold underline">SwiftMart</span>.
                </p>
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